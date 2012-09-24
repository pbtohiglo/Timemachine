using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.DirectoryServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    string tm_EmptyString = "<br />";
    protected void Page_Load(object sender, EventArgs e)
    {
        lbl_error_message.Text = tm_EmptyString;
        System.Web.Security.MembershipUserCollection mutest;
        /*mutest = System.Web.Security.Membership.GetAllUsers();
        foreach (System.Web.Security.MembershipUser muser in mutest)
        {
            lbl_error_message.Text += muser.UserName + "<br />";
        }*/
        /*System.Web.Security.MembershipUser mtest;
        mtest = System.Web.Security.Membership.GetUser("studentnet\\107088");
        lbl_error_message.Text = (mtest == null ? "Not Found" : mtest.UserName) + "<br />";*/
    }
    
    protected void LoginButtonClick(object sender, EventArgs e)
    {
        Int32 intUserType = 0;
        Boolean userDisabled = false;

        if (!System.Web.Security.Membership.ValidateUser(txt_username.Text, txt_password.Text))
            lbl_error_message.Text += "Username or password was invalid.<br />";
        else
        {
            // Open DB connection
            SqlConnection TM_DB = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["SEI_TMConnString"].ConnectionString);
            TM_DB.Open();

            SqlCommand command_GetUser = new SqlCommand("tm_GetUser", TM_DB);
            command_GetUser.CommandType = CommandType.StoredProcedure;
            command_GetUser.Parameters.AddWithValue("@UserID", txt_username.Text);

            SqlDataReader user_reader = command_GetUser.ExecuteReader();

            //Get the first user returned
            if (user_reader.HasRows)
            {
                while (user_reader.Read())
                {
                    intUserType = (Int32)user_reader["TypeID"];
                    userDisabled = (user_reader["Disabled"].ToString() == "1");
                    break;
                }
            }
            else
            {
                lbl_error_message.Text = "You are not a current user.  Please contact the administrator of Time Machine.<br />";
            }
            user_reader.Close();
            user_reader.Dispose();
            command_GetUser.Dispose();

            // Close DB connection
            TM_DB.Close();
            TM_DB.Dispose();

            if (userDisabled)
                lbl_error_message.Text = "Your account is disabled.  Please contact the administrator of Time Machine.<br />";

            if (lbl_error_message.Text == tm_EmptyString)
            {
                Session["s_user"] = txt_username.Text;
                if (intUserType >= 1)
                    Response.Redirect("Statistics.aspx");
                else
                    Response.Redirect("Timelog.aspx");
            }
        }
    }
}