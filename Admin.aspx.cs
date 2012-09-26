using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        gdvUsers.ShowFooter = true;
    }

    protected void ToggleUser(object sender, EventArgs e)
    {
        sqlUsers.UpdateParameters["userID"].DefaultValue = ((sender as LinkButton).Parent.FindControl("lblUserID") as Label).Text;
        sqlUsers.Update();
        gdvUsers.DataBind();
    }

    protected void lnkAddUser_Click(object sender, EventArgs e)
    {
        sqlUsers.InsertParameters["userID"].DefaultValue = ((sender as LinkButton).Parent.FindControl("txtUserID") as TextBox).Text;
        sqlUsers.InsertParameters["userType"].DefaultValue = ((sender as LinkButton).Parent.FindControl("ddlUserType") as DropDownList).SelectedValue;
        sqlUsers.Insert();
        gdvUsers.DataBind();
    }
}