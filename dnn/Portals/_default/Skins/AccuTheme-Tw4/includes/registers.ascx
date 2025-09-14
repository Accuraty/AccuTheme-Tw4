<%@ Control Language="C#" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>

<%-- To be more self-documenting, every known SkinObject is referenced below, see #42 20250914 JRF --%>

<%-- IN USE --%>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %> 
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/Breadcrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %> 
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %><%-- Not used by AccuTheme --%>

<%-- NOT IN USE - Copy/Paste to IN USE above as needed --%>
<%--
<%@ Register TagPrefix="dnn" TagName="CONTROLPANEL" Src="~/Admin/Skins/ControlPanel.ascx" %>
<%@ Register TagPrefix="dnn" TagName="CURRENTDATE" Src="~/Admin/Skins/CurrentDate.ascx" %> 
<%@ Register TagPrefix="dnn" TagName="DnnLink" Src="~/Admin/Skins/DnnLink.ascx" %>
<%@ Register TagPrefix="dnn" TagName="DOTNETNUKE" Src="~/Admin/Skins/DotNetNuke.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Help" Src="~/Admin/Skins/Help.ascx" %>
<%@ Register TagPrefix="dnn" TagName="HOSTNAME" Src="~/Admin/Skins/HostName.ascx" %> 
<%@ Register TagPrefix="dnn" TagName="JavaScriptLibraryInclude" Src="~/Admin/Skins/JavaScriptLibraryInclude.ascx" %>
<%@ Register TagPrefix="dnn" TagName="JQUERY" Src="~/Admin/Skins/jQuery.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %> 
<%@ Register TagPrefix="dnn" TagName="LINKS" Src="~/Admin/Skins/Links.ascx" %> 
<%@ Register TagPrefix="dnn" TagName="LINKTOFULLSITE" Src="~/Admin/Skins/LinkToFullSite.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LINKTOMOBILESITE" Src="~/Admin/Skins/LinkToMobileSite.ascx" %>
<%@ Register TagPrefix="dnn" TagName="META" Src="~/Admin/Skins/Meta.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MODULEMESSAGE" Src="~/Admin/Skins/ModuleMessage.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="STYLES" Src="~/Admin/Skins/Styles.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TAGS" Src="~/Admin/Skins/Tags.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/Admin/Skins/Text.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TOAST" Src="~/Admin/Skins/Toast.ascx" %> 
<%@ Register TagPrefix="dnn" TagName="TreeViewMenu" Src="~/Admin/Skins/TreeViewMenu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/user.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USERANDLOGIN" Src="~/Admin/Skins/UserAndLogin.ascx" %>
--%>

<%-- Additional items in ~/Admin/Skins that do NOT need to be Registered to use:
DnnCssInclude, DnnCssExclude, DnnJsInclude, DnnJsExclude
--%>

<%-- REMOVED IN DNN v10 --%>
<%--
<%@ Register TagPrefix="dnn" TagName="NAV" Src="~/Admin/Skins/Nav.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LEFTMENU" Src="~/Admin/Skins/LeftMenu.ascx" %>
--%>
