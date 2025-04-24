<%-- Don't render any HTML unless the pane has content. --%>
<% if (BottomPane.Visible == true) { %>
  <div
    id="BottomPane"
    data-name="BottomPane"
    class="max-w-7xl mx-auto"
    visible="false"
    runat="server"
  ></div>
<% } %>