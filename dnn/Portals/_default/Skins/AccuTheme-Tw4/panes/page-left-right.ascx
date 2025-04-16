<%-- Don't render any HTML unless at least one pane has content. --%>
<% if (LeftPane.Visible == true || RightPane.Visible == true) { %>
  <div class="grid grid-cols-12 gap-8 lg:gap-16 xl:gap-24 mt-8">
    <div
      id="LeftPane"
      class="col-span-12 md:col-span-6 bg-lime-200 inline-block"
      visible="false"
      runat="server"
    ></div>
    <div
      id="RightPane"
      class="col-span-12 md:col-span-6 bg-indigo-200 inline-block"
      visible="false"
      runat="server"
    ></div>
  </div>
<% } %>
