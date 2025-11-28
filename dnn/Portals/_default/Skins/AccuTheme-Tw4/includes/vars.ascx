<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Text.Json" %>
<%@ Import Namespace="Accuraty.Libraries.AccuLadder" %>
<%@ Import Namespace="DotNetNuke.Services.Personalization" %>
<% 
  bool isDebug = false; // Set to false in production to prevent debug info exposure
  Accu.Dev.Debug = isDebug;
  int pageId = PortalSettings.ActiveTab.TabID;
  bool isHome = pageId == PortalSettings.HomeTabId;
  // note: this next one is consumed in preheader.ascx
  bool isEditMode = Personalization.GetUserMode() == PortalSettings.Mode.Edit;

  // AccuTheme.config settings (strongly-typed accessors)
  bool BreadCrumbsEnabled = GetAccuThemeBool("BreadCrumbsEnabled", true);
  bool BreadCrumbsOnHome = GetAccuThemeBool("BreadCrumbsOnHome", false);
  string DnnEditModeCssPaneMinHeight = GetAccuThemeString("DnnEditModeCssPaneMinHeight", "8rem");

  Accu.Dev.Log("pageId", pageId);
  Accu.Dev.Log("isHome", isHome);
  Accu.Dev.Log("isEditMode", isEditMode);
  Accu.Dev.Log("BreadCrumbsEnabled", BreadCrumbsEnabled);
  Accu.Dev.Log("BreadCrumbsOnHome", BreadCrumbsOnHome);
  Accu.Dev.Log("DnnEditModeCssPaneMinHeight", DnnEditModeCssPaneMinHeight);
  string ctl = Request.QueryString["ctl"];
  Accu.Dev.Log("ctl", ctl);
  // Accu.Dev.Log(".IsAdminTab", PortalSettings.ActiveTab.IsSuperTab);
  // Accu.Dev.Log(".IsAdminTab", PortalSettings.Mode);
  // Accu.Dev.Log(".UserMode", .ToString());
  Accu.Dev.Log("AccuTheme.SkinJsPath", AccuTheme.SkinJsPath);
%>
<% if (isDebug) { %>
<div class="text-2xl p-3" style="font-size: 1.5rem;line-height: 2rem;padding: 0.75rem;"><%=Accu.Dev.GetLog() %></div>
<% } %>

<script runat="server">
  private static System.Collections.Generic.Dictionary<string, string> _accuThemeSettings;

  private void EnsureAccuThemeSettings()
  {
    if (_accuThemeSettings != null)
      return;

    _accuThemeSettings = new System.Collections.Generic.Dictionary<string, string>(System.StringComparer.OrdinalIgnoreCase);

    try
    {
      var configVirtual = SkinPath + "AccuTheme.config";
      var configPath = Server.MapPath(configVirtual);

      if (!File.Exists(configPath))
      {
        Accu.Dev.Log("AccuTheme.config.missing", configPath);
        return;
      }

      var json = File.ReadAllText(configPath, Encoding.UTF8);

      using (var doc = JsonDocument.Parse(json))
      {
        var root = doc.RootElement;
        JsonElement settingsElement;
        if (root.TryGetProperty("settings", out settingsElement))
        {
          foreach (var prop in settingsElement.EnumerateObject())
          {
            var name = prop.Name;
            var value = prop.Value.GetString();
            if (!_accuThemeSettings.ContainsKey(name))
              _accuThemeSettings.Add(name, value);
          }
        }
      }
    }
    catch (System.Exception ex)
    {
      Accu.Dev.Log("AccuTheme.config.error", ex.Message);
    }
  }

  private bool GetAccuThemeBool(string key, bool defaultValue)
  {
    EnsureAccuThemeSettings();

    string value;
    if (_accuThemeSettings != null && _accuThemeSettings.TryGetValue(key, out value))
    {
      bool parsed;
      if (bool.TryParse(value, out parsed))
        return parsed;
    }

    return defaultValue;
  }

  private string GetAccuThemeString(string key, string defaultValue)
  {
    EnsureAccuThemeSettings();

    string value;
    if (_accuThemeSettings != null && _accuThemeSettings.TryGetValue(key, out value))
      return value;

    return defaultValue;
  }
</script>
