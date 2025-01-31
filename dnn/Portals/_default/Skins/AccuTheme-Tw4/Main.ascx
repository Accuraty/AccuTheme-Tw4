<% 
  bool isHome = PortalSettings.ActiveTab.TabID == PortalSettings.HomeTabId;
%>

<div id="page-<%=PortalSettings.ActiveTab.TabID %>" 
  class="page-wrapper page-main<%= isHome ? " page-home" : "" %>"
>
  <!--#include file="includes/header.ascx"-->

  <%-- Reference: https://css-tricks.com/how-to-section-your-html/ --%>
  <main 
    id="main-<%=PortalSettings.ActiveTab.TabID %>"
    class=""
    role="main"
  >
    <!--#include file="panes/page-hero.ascx"-->
    
    <div class="">
    <% if (!isHome) { %>
      <!--#include file="includes/breadcrumb.ascx"-->
    <% } %>
      <div
        id="ContentPane"
        class="bg-orange-400"
        runat="server"
      ></div>

      <!--#include file="panes/page-main-sidebar.ascx"-->

      <!--#include file="panes/page-bottom.ascx"-->

    </div>

  </main>

  <!--#include file="includes/footer.ascx"-->

</div>

<%-- NOT IN USE (YET?)
see src/scripts/README.md, Individual files - to implement Home (page) specific JS 
--%>
<%-- 
<dnn:DnnJsInclude
  FilePath="dist/Home.bundle.js"
  PathNameAlias="SkinPath"
  ForceProvider="DnnFormBottomProvider"
  Priority="106"
  runat="server"
/> 
--%>
