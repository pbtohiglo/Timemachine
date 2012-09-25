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
                       UpdateCommand="tm_DisableUser">
        <InsertParameters>
            <asp:Parameter Name="userID" />
            <asp:Parameter Name="userType" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="userID" />
        </UpdateParameters>
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
                        <asp:LinkButton ID="lnkDisable" Text="Disable" OnClick="ToggleUser" runat="server" Visible='<%#Eval("Disabled").ToString() != "1" %>' />
                        <asp:LinkButton ID="lnkEnable" Text="Enable" OnClick="ToggleUser" runat="server" Visible='<%#Eval("Disabled").ToString() == "1" %>' />
                    </ItemTemplate>
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
                        <%# Eval("Type").ToString() %>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList ID="ddlUserType" runat="server">
                            <asp:ListItem Text="User"    Value="1" Selected="True" />
                            <asp:ListItem Text="Teacher" Value="2" />
                            <asp:ListItem Text="Admin"   Value="3" />
                        </asp:DropDownList>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cph_Foot" Runat="Server">
</asp:Content>