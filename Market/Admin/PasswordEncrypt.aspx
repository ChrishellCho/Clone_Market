<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.Master" AutoEventWireup="true" CodeBehind="PasswordEncrypt.aspx.cs" Inherits="Market.Admin.PasswordEncrypt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

	<p>패스워드 암호화 테스트</p>
	<asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
	<asp:Button ID="btnCreate" runat="server" Text="암호화 문자열 생성" OnClick="btnCreate_Click" /><br />
	<asp:Label ID="lblPassword" runat="server" Text=""></asp:Label>	

</asp:Content>
