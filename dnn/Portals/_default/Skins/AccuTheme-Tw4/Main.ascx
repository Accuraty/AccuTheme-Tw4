<%-- 
1. rethink Breadcrumbs: Home false, Enabled, true - DONE 20251126 JRF
2. Look at .env, is there overlap? should the .ps1 also write to .env??
3. Rename /includes to /components
4. Rename move debug, notice, vars to /components/parts
5. Move /controls/meta.ascx to /components/parts
6. In dnnEdit mode, the panes are too tall (TBD/WIP added DnnEditModeCssPaneMinHeight to AccuTheme.config, unused 20251126 JRF)
--%>

<!-- #include file="includes/vars.ascx" --> 
<% 
  Accu.Dev.Debug = isDebug;
%>
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
    <div><%=Accu.Dev.GetLog() %></div>
    <section class="<%=( HeroBannerPane.Visible != true ? "" : "-mt-8")%>">
      <!--#include file="panes/page-hero-banner.ascx"-->
    </section>
    
    <% if ( (BreadCrumbsOnHome || !isHome) && BreadCrumbsEnabled ) { %>
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

    <!--#include file="panes/page-left-right.ascx"-->

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
