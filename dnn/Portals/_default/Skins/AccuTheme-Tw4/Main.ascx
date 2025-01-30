<% 
  bool isHome = PortalSettings.ActiveTab.TabID == PortalSettings.HomeTabId;
%>

<div id="page-<%=PortalSettings.ActiveTab.TabID %>" 
  class="page-wrapper page-main<%= isHome ? " page-home" : "" %>"
>
<!--#include file="includes/_header.ascx"-->

  <%-- Reference: https://css-tricks.com/how-to-section-your-html/ --%>
  <main id="main-<%=PortalSettings.ActiveTab.TabID %>"
    class="booya" role="main">
    
    <div class="">
    <% if (!isHome) { %>
      <!--#include file="includes/_breadcrumb.ascx"-->
    <% } %>
      <div
        id="ContentPane"
        class=""
        runat="server"
      ></div>

      <%-- Don't render any HTML unless at least one pane has content. --%>
      <% if (MainPane.Visible == true || AsidePane.Visible == true) { %>
        <div class="flex flex-row">
          <div
            id="MainPane"
            class="grow"
            visible="false"
            runat="server"
          ></div>
          <div
            id="AsidePane"
            class="basis-1/4"
            visible="false"
            runat="server"
          ></div>
        </div>
      <% } %>

    </div>

  </main>

<!--#include file="includes/_footer.ascx"-->
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
