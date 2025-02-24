<%-- Don't render any HTML unless at least one pane has content. --%>
<% if (MainPane.Visible == true || SidebarPane.Visible == true) { %>
  <div class="grid grid-cols-12 gap-8 lg:gap-16 xl:gap-24 mb-8 lg:mb-16 xl:mb-24">
    <div
      id="MainPane"
      class="col-span-12 md:col-span-7 bg-yellow-300 inline-block"
      visible="false"
      runat="server"
    ></div>
    <div
      id="SidebarPane"
      class="col-span-12 md:col-span-5 bg-emerald-300 inline-block"
      visible="false"
      runat="server"
    ></div>
  </div>
<% } %>
