<%-- Don't render any HTML unless the pane has content. --%>
<% if (BottomPane.Visible == true) { %>
  <div
    id="BottomPane"
    data-name="BottomPane"
    class="bg-fuchsia-200 mt-8"
    visible="false"
    runat="server"
  ></div>
<% } %>