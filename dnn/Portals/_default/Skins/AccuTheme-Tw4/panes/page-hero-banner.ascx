<%-- Don't render any HTML unless the pane has content. --%>
<% if (HeroBannerPane.Visible == true) { %>
  <div
    id="HeroBannerPane"
    data-name="HeroBannerPane"
    class="mx-auto"
    visible="false"
    runat="server"
  ></div>
<% } %>