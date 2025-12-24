<%@ Control language="C#" Inherits="System.Web.UI.UserControl" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>

<script runat="server">
  protected override void OnLoad(EventArgs e)
  {
      base.OnLoad(e);
      AddFavicons();
      // AddOpenGraph();
  }

  private void AddFavicons()
  {
    // TODO see Issue #83, convert to use AccuTheme.config
    // NOTE the following line is (re)generated and replaced by `npm run favicons` using realfavicongenerator.net and a PowerShell script
    string Favicons = @"";
    if ( Favicons != "") 
    {
      LiteralControl FaviconsMarkup = new LiteralControl(Favicons);
      Page.Header.Controls.Add(FaviconsMarkup);
    }
  }

  <%--
  private void AddOpenGraph()
  {
      // TODO !!!!

      // Page.Header.Controls.Add(new LiteralControl("<meta property='og:url' content=" + PortalSettings.ActiveTab.FullUrl + ">"));
  }
  --%>

</script>








