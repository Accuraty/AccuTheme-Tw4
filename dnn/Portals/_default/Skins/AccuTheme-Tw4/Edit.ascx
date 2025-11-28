<!--#include file="includes/vars.ascx"-->
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
    <section class="<%=( HeroBannerPane.Visible != true ? "" : "-mt-8")%>">
      <!--#include file="panes/page-hero-banner.ascx"-->
    </section>
    
    <% if ( BreadCrumbsOnHome ? BreadCrumbsEnabled : ( !isHome && BreadCrumbsEnabled ) ) { %>
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
