<%-- Don't render any HTML unless the pane has content. --%>
<% if (BottomPane.Visible == true) { %>
  <div
    id="BottomPane"
    data-name="BottomPane"
    class="max-w-7xl mx-auto mt-20 lg:mt-32"
    visible="false"
    runat="server"
  ></div>
<% } %>