<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Speakers.aspx.cs" Inherits="LegacyExamples.Speakers" %>

<asp:Content ID="BodyContents" ContentPlaceHolderID="BodyContentPlaceHolder" runat="server">
    <asp:ObjectDataSource runat="server" ID="SpeakersDataSource" SelectMethod="GetSpeakers" TypeName="LegacyExamples.SpeakerDataProvider" DataObjectTypeName="LegacyExamples.Speaker"></asp:ObjectDataSource>
    <asp:Repeater runat="server" DataSourceID="SpeakersDataSource">
        <ItemTemplate>
            <div class="speaker">
                <img src="SpeakerImageHandler.ashx?speakerId=<%# Eval("SpeakerId") %>" alt="Speaker Image" title="<%# Eval("FirstName") %> <%# Eval("LastName") %>" />
                <a class="name" href="Speaker.aspx?speakerId=<%# Eval("SpeakerId") %>">
                    <span><%# ((string)Eval("FirstName")).ToLower() %></span>
                    <span><%# Eval("LastName") %></span>
                </a>
                <p class="bio"><%# Eval("Bio") %></p>
                <div class="social">
                </div>
            </div>
            <div style="clear: both"></div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
