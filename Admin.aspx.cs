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

    protected void lnkUpdateUser_Click(object sender, EventArgs e)
    {
        sqlUsers.UpdateParameters["userID"].DefaultValue = ((sender as LinkButton).Parent.FindControl("lblUserID") as Label).Text;
        sqlUsers.UpdateParameters["userType"].DefaultValue = ((sender as LinkButton).Parent.FindControl("ddlUserEditType") as DropDownList).SelectedValue;
        sqlUsers.UpdateParameters["userFirst"].DefaultValue = ((sender as LinkButton).Parent.FindControl("txtUserEditFirst") as TextBox).Text;
        sqlUsers.UpdateParameters["userLast"].DefaultValue = ((sender as LinkButton).Parent.FindControl("txtUserEditLast") as TextBox).Text;
        sqlUsers.UpdateParameters["userDisabled"].DefaultValue = ((sender as LinkButton).Parent.FindControl("chkUserEditDisabled") as CheckBox).Checked ? "1" : "0";
        sqlUsers.Update();
        gdvUsers.DataBind();
    }

    protected void lnkAddUser_Click(object sender, EventArgs e)
    {
        sqlUsers.InsertParameters["userID"].DefaultValue = ((sender as LinkButton).Parent.FindControl("txtUserID") as TextBox).Text;
        sqlUsers.InsertParameters["userType"].DefaultValue = ((sender as LinkButton).Parent.FindControl("ddlUserType") as DropDownList).SelectedValue;
        sqlUsers.InsertParameters["firstName"].DefaultValue = ((sender as LinkButton).Parent.FindControl("txtUserFirst") as TextBox).Text;
        sqlUsers.InsertParameters["lastName"].DefaultValue = ((sender as LinkButton).Parent.FindControl("txtUserLast") as TextBox).Text;
        sqlUsers.InsertParameters["disabled"].DefaultValue = ((sender as LinkButton).Parent.FindControl("chkUserDisabled") as CheckBox).Checked ? "1" : "0";
        sqlUsers.Insert();
        gdvUsers.DataBind();
    }
}