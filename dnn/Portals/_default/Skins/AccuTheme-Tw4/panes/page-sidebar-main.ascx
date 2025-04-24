<%-- Don't render any HTML unless at least one pane has content. --%>
<% if (SidebarLeftPane.Visible == true || MainRightPane.Visible == true) { %>
  <div class="max-w-7xl mx-auto grid grid-cols-12 gap-8 lg:gap-16 xl:gap-24">
    <div
      id="SidebarLeftPane"
      class="col-span-12 md:col-span-5 inline-block"
      visible="false"
      runat="server"
    ></div>
    <div
      id="MainRightPane"
      class="col-span-12 md:col-span-7 inline-block"
      visible="false"
      runat="server"
    ></div>
  </div>
<% } %>
