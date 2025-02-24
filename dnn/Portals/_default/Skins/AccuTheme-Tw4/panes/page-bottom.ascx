<%-- Don't render any HTML unless the pane has content. --%>
<% if (BottomPane.Visible == true) { %>
  <div
    id="BottomPane"
    data-name="BottomPane"
    class="bg-sky-400"
    visible="false"
    runat="server"
  ></div>
<% } %>