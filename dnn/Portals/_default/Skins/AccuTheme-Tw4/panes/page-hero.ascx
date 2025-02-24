<%-- Don't render any HTML unless the pane has content. --%>
<% if (HeroPane.Visible == true) { %>
  <div
    id="HeroPane"
    data-name="HeroPane"
    class="bg-rose-400"
    visible="false"
    runat="server"
  ></div>
<% } %>