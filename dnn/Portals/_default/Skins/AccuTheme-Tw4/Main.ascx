<%@ Import Namespace="Accuraty.Libraries.AccuLadder" %>
<% 
  bool isDebug = false; // 
  Accu.Dev.Debug = isDebug;
  int pageId = PortalSettings.ActiveTab.TabID;
  bool isHome = pageId == PortalSettings.HomeTabId;
  Accu.Dev.Log("pageId", pageId);
  Accu.Dev.Log("isHome", isHome);
%>
<% if (isDebug) { %>
<%=Accu.Dev.GetLog() %>
<% } %>

<div id="page-skin-<%=pageId %>" 
  class="page-skin-main<%= isHome ? " page-skin-home" : "" %>"
>
  <%-- Reminder, nested includes: header > preheader > registers  --%>
  <!--#include file="includes/header.ascx"-->

  <%-- Reference: https://css-tricks.com/how-to-section-your-html/ --%>
  <main 
    id="main-<%=pageId %>"
    class=""
    role="main"
  >
    <section class="<%=( HeroBannerPane.Visible != true ? "" : "-mt-8")%>">
      <!--#include file="panes/page-hero-banner.ascx"-->
    </section>
    
    <% if (!isHome) { %>
    <div class="max-w-7xl mx-auto mt-8">
      <!--#include file="includes/breadcrumb.ascx"-->
    </div>
    <% } %>

    <div
      id="ContentPane"
      class="max-w-7xl mx-auto"
      runat="server"
    ></div>

    <!--#include file="panes/page-main-sidebar.ascx"-->

    <!--#include file="panes/page-bottom.ascx"-->

  </main>

  <!--#include file="includes/footer.ascx"-->

</div>

<%-- NOT IN USE (YET?)
see src/scripts/README.md, Individual files - to implement Home (page) specific JS 
--%>
<%-- 
<dnn:DnnJsInclude
  FilePath="dist/home.bundle.js"
  PathNameAlias="SkinPath"
  ForceProvider="DnnFormBottomProvider"
  Priority="106"
  runat="server"
/> 
--%>
