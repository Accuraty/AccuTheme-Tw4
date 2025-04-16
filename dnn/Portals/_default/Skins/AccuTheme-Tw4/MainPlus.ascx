<% 
  bool isHome = PortalSettings.ActiveTab.TabID == PortalSettings.HomeTabId;
%>

<div id="page-<%=PortalSettings.ActiveTab.TabID %>" 
  class="page-wrapper page-main<%= isHome ? " page-home" : "" %>"
>
  <%-- Reminder, nested includes: header > preheader > registers  --%>
  <!--#include file="includes/header.ascx"-->

  <%-- Reference: https://css-tricks.com/how-to-section-your-html/ --%>
  <main 
    id="main-<%=PortalSettings.ActiveTab.TabID %>"
    class=""
    role="main"
  >
    <!--#include file="panes/page-hero.ascx"-->
    
    <div class="">
    
      <div
        id="ContentPane"
        class="bg-green-200 mt-8"
        runat="server"
      ></div>

      <!--#include file="panes/page-main-sidebar.ascx"-->

      <!--#include file="panes/page-sidebar-main.ascx"-->

      <!--#include file="panes/page-left-right.ascx"-->

      <!--#include file="panes/page-three-column.ascx"-->

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
