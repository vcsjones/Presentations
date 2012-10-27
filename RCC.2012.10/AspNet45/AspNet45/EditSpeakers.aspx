<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditSpeakers.aspx.cs" Inherits="AspNet45.EditSpeakers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:Label runat="server" ID="ErrorsLabel"></asp:Label>
    <asp:GridView runat="server" AutoGenerateEditButton="True" Width="100%"
        AutoGenerateColumns="False" ID="SpeakersGrid" ItemType="AspNet45.Speaker"
        DataKeyNames="SpeakerId" SelectMethod="GetSpeakers" UpdateMethod="UpdateSpeaker">
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:TemplateField HeaderText="Twitter">
                <ItemTemplate>
                    <%#: Item.Twitter == null ? "" : "@" + Item.Twitter %>
                </ItemTemplate>
                <EditItemTemplate>
                    @<asp:TextBox runat="server" ID="TwitterTextBox" MaxLength="14" Text="<%#: BindItem.Twitter %>"  />
                    <asp:ModelErrorMessage runat="server" ModelStateKey="Twitter" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
