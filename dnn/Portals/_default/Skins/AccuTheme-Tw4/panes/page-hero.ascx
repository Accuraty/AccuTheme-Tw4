<%-- Don't render any HTML unless the pane has content. --%>
<% if (HeroPane.Visible == true) { %>
  <div
    id="HeroPane"
    data-name="HeroPane"
    class="bg-rose-200"
    visible="false"
    runat="server"
  ></div>
<% } %>