<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_Body" Runat="Server">
    <asp:SqlDataSource ID="sqlUsers" runat="server" ConnectionString='<%$ connectionStrings:SEI_TMConnString %>'
                       SelectCommandType="StoredProcedure"
                       SelectCommand="tm_GetUsers"
                       InsertCommandType="StoredProcedure"
                       InsertCommand="tm_CreateUser"
                       UpdateCommandType="StoredProcedure"
                       UpdateCommand="tm_UpdateUser">
        <InsertParameters>
            <asp:Parameter Name="userID" />
            <asp:Parameter Name="userType" />
            <asp:Parameter Name="firstName" />
            <asp:Parameter Name="lastName" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="userID" />
            <asp:Parameter Name="userType" />
            <asp:Parameter Name="userDisabled" />
            <asp:Parameter Name="userFirst" />
            <asp:Parameter Name="userLast" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlUserTypes" runat="server" ConnectionString='<%$ connectionStrings:SEI_TMConnString %>'
                       SelectCommandType="StoredProcedure"
                       SelectCommand="tm_GetUserTypes">
    </asp:SqlDataSource>

    <div style="margin-left:20px">
        <br /><br />
        <asp:GridView ID="gdvUsers" Caption="<b>Users</b>" DataSourceID="sqlUsers" AutoGenerateColumns="false" runat="server"
                      AllowSorting="true" AllowPaging="true"
                      PagerSettings-Mode="NumericFirstLast" PageSize="10" PagerSettings-Visible="true" PagerStyle-HorizontalAlign="Center" PagerStyle-BackColor="Gray"
                      BorderWidth="2px" BorderColor="DarkBlue">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" Text="Edit" CommandName="edit" runat="server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="lnkUpdate" Text="Update" OnClick="lnkUpdateUser_Click" runat="server" /><br />
                        <asp:LinkButton ID="lnkCancel" Text="Cancel" CommandName="cancel" runat="server" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:LinkButton ID="lnkAddUser" Text="Add" OnClick="lnkAddUser_Click" runat="server" />
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Username" SortExpression="ID">
                    <ItemTemplate>
                        <asp:Label ID="lblUserID" Text='<%# Eval("ID").ToString()%>' runat="server" />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtUserID" runat="server" />
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Permissions" SortExpression="Type">
                    <ItemTemplate>
                        <%# Eval("TypeName").ToString() %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlUserEditType" DataSourceID = "SqlUserTypes" DataValueField="ID" DataTextField="Name" runat="server" SelectedValue='<%# Eval ( "Type" ) %>' />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList ID="ddlUserType" DataSourceID = "SqlUserTypes" DataValueField="ID" DataTextField="Name" runat="server" />
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                    <ItemTemplate>
                        <%# Eval("FirstName").ToString() %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUserEditFirst" runat="server" Text='<%# Eval ( "FirstName" ) %>' />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtUserFirst" runat="server" />
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                    <ItemTemplate>
                        <%# Eval("LastName").ToString() %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUserEditLast" runat="server" Text='<%# Eval ( "LastName" ) %>' />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtUserLast" runat="server" />
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Disabled" SortExpression="Disabled">
                    <ItemTemplate>
                        <asp:Label ID="lblDisabledYes" Text="Yes" Visible='<%# Eval("Disabled").ToString () == "1" %>' runat="server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkUserEditDisabled" runat="server" Checked='<%# Eval ( "Disabled" ).ToString ( ) == "1" %>' />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:CheckBox ID="chkUserDisabled" runat="server" />
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cph_Foot" Runat="Server">
</asp:Content>