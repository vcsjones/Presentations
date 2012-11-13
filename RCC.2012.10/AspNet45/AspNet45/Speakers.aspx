<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Site.Master" ValidateRequest="false"  AutoEventWireup="true" CodeBehind="Speakers.aspx.cs" Inherits="AspNet45.Speakers" %>

<asp:Content ID="BodyContents" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:Repeater runat="server" ItemType="AspNet45.Speaker" SelectMethod="GetSpeakers">
        <ItemTemplate>
            <div class="speaker">
                <img src="SpeakerImageHandler.ashx?speakerId=<%#: Item.SpeakerId %>" alt="Speaker Image" title="<%#: Item.FirstName %> <%#: Item.LastName %>" />
                <a class="name" href="Speaker.aspx?speakerId=<%#: Item.SpeakerId %>">
                    <span><%#: Item.FirstName %></span>
                    <span><%#: Item.LastName %></span>
                </a>
                <p class="bio"><%#: Item.Bio %></p>
                <div class="social">
                </div>
            </div>
            <div style="clear: both"></div> 
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
