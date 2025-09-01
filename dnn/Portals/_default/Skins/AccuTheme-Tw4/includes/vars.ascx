<%@ Import Namespace="Accuraty.Libraries.AccuLadder" %>
<%@ Import Namespace="DotNetNuke.Services.Personalization" %>
<% 
  bool isDebug = false; //  
  Accu.Dev.Debug = isDebug;
  int pageId = PortalSettings.ActiveTab.TabID;
  bool isHome = pageId == PortalSettings.HomeTabId;
  // note: this next one is consumed in preheader.ascx
  bool isEditMode = Personalization.GetUserMode() == PortalSettings.Mode.Edit;
  Accu.Dev.Log("pageId", pageId);
  Accu.Dev.Log("isHome", isHome);
  Accu.Dev.Log("isEditMode", isEditMode);
  string ctl = Request.QueryString["ctl"];
  Accu.Dev.Log("ctl", ctl);
  // Accu.Dev.Log(".IsAdminTab", PortalSettings.ActiveTab.IsSuperTab);
  // Accu.Dev.Log(".IsAdminTab", PortalSettings.Mode);
  // Accu.Dev.Log(".UserMode", .ToString());
  Accu.Dev.Log("AccuTheme.SkinJsPath", AccuTheme.SkinJsPath);
%>
<% if (isDebug) { %>
<div class="text-2xl p-3" style="font-size: 1.5rem;line-height: 2rem;padding: 0.75rem;"><%=Accu.Dev.GetLog() %></div>
<% } %>
