<%-- Moved all notes/planning to __debug-README.ascx 
     Reminder: do not use string interpolation 
--%>
<script runat="server">
  // STEP 1.0: add this file to theme/includes/, then add to footer.ascx and test 

  // STEP 1.1: set these environment values to match your site/theme/etc
  const string ENV_ThemeNameRoot = "AccuTheme"; // the name of the theme
  const string ENV_ThemeFlavor = "Tw4"; // the flavor of the theme (GitHub repo suffix)
  const string ENV_ThemeFlavorVersion = "4.0.1"; // the version of TailWind used
  
  // in production (live), set to false 
  const bool isDebug = false; // disable debug output // stuff only useful while developing
  const bool showAllForSuper = false; // show all details and debug for SuperUsers
  const string debugVersion = "WIP.2025.01.21";

  string ENV_Theme_GitHubRepo = ENV_ThemeNameRoot + "-" + ENV_ThemeFlavor; // the GitHub repo name

  // STEP 1: UPDATE THESE VALUES TO MATCH YOUR SITE AND ENVIRONMENT (then delete this comment)
  public partial class DebugSettings // ? rename to DebugDetails or ??
  {
    public static string FrameworkVersion = ENV_ThemeFlavor + " v" + ENV_ThemeFlavorVersion; // set this to match actual (usually via package.json)
    // final fallback list if remote/local locations fail
    public static List<string> AllowedIpsListFallback = new List<string> { 
      "127.0.0.1", 
      "140.141.191.145" 
    }; 
    // details about where to try and load the JSON file from 
    public static string JsonDefaultFilename = "accu-settings.json"; // if not specified
    public static string JsonElementNameAllowedIps = "AllowedIps"; // the name of the node containing the array of IPs
    public static string JsonLocalFailoverPath = "/Portals/_default/"; // relative to root
    // we will try these in order until one works (or all fail):
    public static List<string> JsonFileLocations = new List<string>() { 
      // if the filename is not specified, JsonDefaultFilename will be appended
      "https://accuraty.com/Portals/_default/" + JsonDefaultFilename, // primary
      "HostPath", // special; will load via file system (path + default filename)
      "https://www.accu4.com/Portals/_default",
    }; 
    // we use DNN's cache to store the list of allowed IPs
    public static int CacheTimeout = 60; // minutes
    public static string CacheKeyAllowedWanIps = "FooterDebug-AllowedWanIps";
    // setup your optional special URL parameter add on to trigger debug output (e.g. ?debug=on or /debug/on)
    public static string SpecialUrlOutputName = "details"; // default
    public static string SpecialUrlOutputValue = "on"; // default; shows only details
    public static string SpecialUrlDebugValue = "debug"; // shows only debug info (logged)
    public static string SpecialUrlAllValue = "all"; // shows both details and debug info
    public static string SpecialUrlOffValue = "off"; // turns off all debug output
  }
</script>

<% 
  // Check for details/off first
  if (isUrlSpecial(DebugSettings.SpecialUrlOutputName, DebugSettings.SpecialUrlOffValue)) {
    return;
  }

  bool showDetails = isIpSpecial() 
    || isUrlSpecial(DebugSettings.SpecialUrlOutputName, DebugSettings.SpecialUrlOutputValue)
    || isUrlSpecial(DebugSettings.SpecialUrlOutputName, DebugSettings.SpecialUrlAllValue)
    || currUserInfo().IsSuperUser && showAllForSuper
  ;
  bool showDebug = isDebug
    || isUrlSpecial(DebugSettings.SpecialUrlOutputName, DebugSettings.SpecialUrlDebugValue)
    || isUrlSpecial(DebugSettings.SpecialUrlOutputName, DebugSettings.SpecialUrlAllValue)
    || currUserInfo().IsSuperUser && showAllForSuper
  ;

  if ( showDetails ) { 

    //get the TabPermission for the current tab and cast from Collection to List<TabPermissionInfo>
    List<DotNetNuke.Security.Permissions.TabPermissionInfo> tabPermissionInfo = 
      DotNetNuke.Security.Permissions.TabPermissionController.GetTabPermissions(PortalSettings.ActiveTab.TabID , PortalSettings.PortalId)
        .Cast<DotNetNuke.Security.Permissions.TabPermissionInfo>()
          .ToList()
    ;

    //loop all the permissionInfo objects and check for RoleId -1 (= all users)
    bool allUsers = false;
    foreach (DotNetNuke.Security.Permissions.TabPermissionInfo pi in tabPermissionInfo)
    {
        if (pi.RoleID == -1)
        {
            allUsers = true;
        }

        //for visualization of all roles and id's for current tab
        debugOutput.AppendLine($"Role ID/Name: {pi.RoleID}/{pi.RoleName}, KeyID: {pi.KeyID}, TabID: {pi.TabID}, PermissionID: {pi.PermissionID}, AllowAccess: {pi.AllowAccess}");
    }

    // is the current page public?
    int allUsersRoleId2 = int.Parse(DotNetNuke.Common.Globals.glbRoleAllUsers); 
    int portalId2 = PortalSettings.PortalId;
    bool IsPublic2 = DotNetNuke.Security.Permissions.TabPermissionController
      .GetTabPermissions(PortalSettings.ActiveTab.TabID, portalId2)
        .ToList()
        .Any(pi => pi.RoleID == allUsersRoleId2 && pi.AllowAccess && pi.PermissionID == 3); // SYSTEM_TAB, VIEW

    debugOutput.AppendLine("--------------------");
    debugOutput.AppendLine($"IsPublic2: {IsPublic2}, AllUsers: {allUsers}");
    debugOutput.AppendLine($"allUsersRoleId2: {allUsersRoleId2}");
    debugOutput.AppendLine($"portalId2: {portalId2}");

    // is the current page public?
    // retry using PortalSettings.ActiveTab.TabPermissions
    int allUsersRoleId = int.Parse(DotNetNuke.Common.Globals.glbRoleAllUsers); 
    bool IsPublic = PortalSettings.ActiveTab
      .TabPermissions.Cast<DotNetNuke.Security.Permissions.TabPermissionInfo>()
        .Any(pi => pi.RoleID == allUsersRoleId 
          && pi.AllowAccess 
          && pi.PermissionID == 3 // 3 is SYSTEM_TAB, VIEW
        )
    ; 
    debugOutput.AppendLine("--------------------");
    debugOutput.AppendLine($"IsPublic: {IsPublic}");
    debugOutput.AppendLine($"allUsersRoleId: {allUsersRoleId}");
%>

  <div class="rounded-md bg-yellow-50 p-4" role="alert">
    <div class="flex flex-col">

      <%-- DNN / HOST --%>
      <div class="ml-3">
        <p>
          DNN <%=DotNetNuke.Application.DotNetNukeContext.Current.Application.Version.ToString(3) %> / <%=System.Environment.Version.ToString() %> / Host=<%=System.Net.Dns.GetHostName() %>, 
          DebugMode: <%=IconToggle(DotNetNuke.Entities.Host.Host.DebugMode, "xl") %>, 
          ShowCriticalErrors: <%=IconToggle(DotNetNuke.Entities.Host.Host.ShowCriticalErrors, "xl") %>
        </p>
      </div>

      <%-- THEME --%>
      <div class="ml-3">
        <p>Theme: 
          Skin: <strong><%=PortalSettings.DefaultPortalSkin.Split('/')[1].ToUpper() %></strong>, 
          Layout / Container: <span title="<%=PortalSettings.DefaultPortalSkin %>"><%=System.IO.Path.GetFileNameWithoutExtension(PortalSettings.DefaultPortalSkin) %></span>
            / <span title="<%=PortalSettings.ActiveTab.ContainerSrc %>"><%=System.IO.Path.GetFileNameWithoutExtension(PortalSettings.ActiveTab.ContainerSrc) %></span>, 
          Framework: <span title="started at Tw4.0.1"><%=DebugSettings.FrameworkVersion %></span>
          <a href="https://github.com/Accuraty/<%=ENV_Theme_GitHubRepo %>/tree/main/src/styles#tailwind" target="_blank" rel="noopener noreferrer" class="ml-1">(read me - fix me)</a>
        </p>
      </div>

      <%-- PAGE --%>
      <div class="ml-3">
        <p class="mb-1"><%=IconPagePublic() %> Page: 
          ID=<%=PortalSettings.ActiveTab.TabID %>, 
          Name=<%=PortalSettings.ActiveTab.TabName %>, 
          Title=<%=PortalSettings.ActiveTab.Title %>, 
          Layout / Container: <span title="<%=PortalSettings.ActiveTab.SkinSrc %>"><%=System.IO.Path.GetFileNameWithoutExtension(PortalSettings.ActiveTab.SkinSrc) %></span>
            / <span title="<%=PortalSettings.ActiveTab.ContainerSrc %>"><%=System.IO.Path.GetFileNameWithoutExtension(PortalSettings.ActiveTab.ContainerSrc) %></span>
        </p>
        <div class="px-3">
          <div class="mb-0">Status: 
            <span title="Display in Menus, Navigation">IsVisible <%=IconToggle(PortalSettings.ActiveTab.IsVisible, "lg") %>, </span>  
            <span>Published <%=IconToggle(PortalSettings.ActiveTab.HasBeenPublished, "lg") %> </span>
          </div>
          <p class="mb-0 text-break">
            Nav: Level=<%=PortalSettings.ActiveTab.Level %>, 
            Path=<%=PortalSettings.ActiveTab.TabPath %>, 
            <span title="Disabled in Nav/Menus (e.g. not a link, just a parent)">DisableLink <%=IconToggle(PortalSettings.ActiveTab.DisableLink, "lg") %> </span>
          </p>
          <p class="mb-0" title="What? You didn't know that tabid and language are always there?">QueryString pairs: <%=Request.QueryString.ToString().Replace("&",", ") %></p>
        </div>
      </div>
    </div>
    </div>

    <%-- DLLs --%>
    <div class="ml-3">
      <p title="AssemblyVersion: these versions are coming from the DLLs in /bin (using Reflection)">Key DLL Versions: 
        DNN: <%=GetVersion("DotNetNuke") %>, 
        MS DI: <%=GetVersion("Microsoft.Extensions.DependencyInjection") %>, 
        NewtonsoftJson: <%=GetVersion("Newtonsoft.Json") %>, 
        CodeDom: <%=GetVersion("Microsoft.CodeDom.Providers.DotNetCompilerPlatform") %>,
        <br>
        2sxc: <%=GetVersion("ToSic.Sxc") %>, 
        DNNBackup: <%=GetVersion("Evotiva.DNN.Modules.DNNBackup") %>,
        AccuLadder: <%=GetVersion("Accuraty.Libraries.AccuLadder") %>,
        Booyada: <%=GetVersion("Booyada") %> <!-- testing not found -->
      </p>
    </div>
  
    <%-- Login URL 
    <div class="mb-2">
      <p>Login URL: <%=System.Configuration.ConfigurationManager.AppSettings["loginUrl"] %></p>
    </div>
    <hr />
    --%>
    <%-- SMALL PRINT --%>
    <div class="small text-dark">
      <p class="mb-0"
        title="Current user details..."
      >Current User: <%=currUserInfo().UserID %>, <%=currUserInfo().Username %>, <%=currUserInfo().DisplayName %>, <%=currUserInfo().Email %>
      </p>
      <p class="mb-0"
        title="Current user's role details..."
      > +-- permissions are <%=currUserRoles() %>
      </p>
      <p class="mb-0"
        title="This is how long your session will last before you are logged out you are not actively using the site and do NOT check Remember."
      >Authentication Timeout: <%=GetAuthTimeout() %>
      </p>
      <p class="mb-0"
        title="This is how long your session will last before you are logged out you are not actively using the site AND check Remember."
      >PersistentCookieTimeout: <%=GetPersistentTimeout() %>, RememberCheckbox: <%=DotNetNuke.Entities.Host.Host.RememberCheckbox.ToString() %> 
      </p>
      <p class="mb-0">
        Using <code><%=System.Configuration.ConfigurationManager.AppSettings["UpdateServiceUrl"] %></code> for updates. 
        Deployed on <%=System.Configuration.ConfigurationManager.AppSettings["InstallationDate"] %> 
        at Dnn version <%=System.Configuration.ConfigurationManager.AppSettings["InstallVersion"] %>,
      </p>
      <p class="mb-0">WAN IP: <%=GetIpAddress() %>, page output <%=DateTime.Now.ToString("F") %></p>
    </div>

    <p class="small mt-2 mb-0"
      title="__debug.ascx v<%=debugVersion %>, isIpSpecial()=<%=showDetails %>, isUrlSpecial()=<%=isUrlSpecial() %>"
    >
      <span class="font-weight-bold">Debug info being output from <code>includes/_footer.ascx</code> in Skin.</span>
      This is only visible from configured WAN IP addresses or URL name/value pair. Hovering on some elements reveals more info.
    </p>

  </div>
<% } %>

<% if ( showDebug ) { %>
<div style="margin:0;padding:1rem;background-color:lightgray;">
<p style="font-size:larger;font-weight:bold;">DEBUGGING OUTPUT (showDebug is true, showDetails is <%=showDetails %>, isDebug is <%=isDebug %>), WAN IP: <%=GetIpAddress() %></p>
<pre>
debugOutput:
<%=debugOutput.ToString().Trim() %>

HttpContext
.Current.Request.IsLocal:         <%=HttpContext.Current.Request.IsLocal %>
.UserHostAddress:                 <%=HttpContext.Current.Request.UserHostAddress %>
.ServerVariables["LOCAL_ADDR"]:   <%=HttpContext.Current.Request.ServerVariables["LOCAL_ADDR"] %>
.ServerVariables["REMOTE_ADDR"]:  <%=HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] %>
.Headers["CF-Connecting-IP"]:     <%=HttpContext.Current.Request.Headers["CF-Connecting-IP"] %>
.Headers["X-Forwarded-For"]:      <%=HttpContext.Current.Request.Headers["X-Forwarded-For"] %>

GetIpAddress():                   <%=GetIpAddress() %>
</pre>
</div>
<% } %>

<script runat="server">
  // set whether to logDebug or not
  bool logDebug = isDebug;
  <%-- 
  BUG fix this, throws error due to scope of showDebug, etc.
  logDebug = logDebug 
    || isUrlSpecial(DebugSettings.SpecialUrlOutputName, DebugSettings.SpecialUrlDebugValue)
    || isUrlSpecial(DebugSettings.SpecialUrlOutputName, DebugSettings.SpecialUrlAllValue)
  ;
  --%>  
  /// <summary>Is the current page public?</summary>
  /// <returns>bool</returns>
  bool IsPublic() {
    int allUsersRoleId = int.Parse(DotNetNuke.Common.Globals.glbRoleAllUsers); 
    return PortalSettings.ActiveTab
      .TabPermissions.Cast<DotNetNuke.Security.Permissions.TabPermissionInfo>()
        .Any(pi => pi.RoleID == allUsersRoleId 
          && pi.AllowAccess 
          && pi.PermissionID == 3 // 3 is SYSTEM_TAB, VIEW
        )
    ;  
  }
  // Get the icon for the page (public or not)
  string IconPagePublic() {
    if ( !HttpContext.Current.User.Identity.IsAuthenticated ) { return ""; }
    bool isPublic = IsPublic();
    string icon = "<i class=\"fa-solid fa-lock{0}\" title=\"{1}\"></i>";
    return string.Format(icon, 
      isPublic ? "-open" : "", 
      isPublic ? "Public - page permissions allow All Users to View, so unauthenticated users can see this page" : "Private - page is NOT visible to unauthenticated users"
    );
  }
  // Get the toggle on/off icon for boolean
  string IconToggle(bool isOn, string reSize = "") {
    string icon = "<i class=\"fa-solid fa-toggle-{0}{2}\" title=\"{1}\"></i>";
    return string.Format(icon, 
      isOn ? "on" : "off", 
      isOn ? "on" : "off",
      reSize == string.Empty ? "" : " fa-" + reSize
    );
  }
  // Get the version of an installed DLL in /bin
  // expecting "ToSic.Razor" and we assume /bin and add .dll
  string GetVersion(string pathFile) {
    // should the bin/dll (path/ext) pattern be a setting?
    string addPathExt = "bin/{0}.dll";
    string target = HttpContext.Current.Server.MapPath(string.Format(addPathExt, pathFile));
    if(System.IO.File.Exists(target)) {
      return System.Reflection.Assembly.LoadFrom(target).GetName().Version.ToString();
    }
    else {
      return "Not found (/" + string.Format(addPathExt, pathFile) + ")";
    }
  }  
  // does the URL contain the expected secret?
  // do {something} only if URL has "/debug/on" or "&debug=on" added
  bool isUrlSpecial(string urlParamName = "debug", string urlParamValue = "on") {
    return urlQSParam(urlParamName, "") == urlParamValue;
  }
  // safely fetch our URL Param
  string urlQSParam(string urlParamName = "debug", string returnFalse = "") {
    if(!string.IsNullOrEmpty(Request.QueryString[urlParamName])) {
      return Request.QueryString[urlParamName];
    } else {
      return returnFalse;
    }
  }
  // Get IP address of the visitor
  string GetIpAddress() {
    string stringIpAddress;
    // is this still correct in 2023? is there a better way?
    stringIpAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
    if (stringIpAddress == null) {
      stringIpAddress = Request.ServerVariables["REMOTE_ADDR"];
    }
    return stringIpAddress;
  }
  // From web.config, get the normal login timeout (system.web/authentication) for the session
  string GetAuthTimeout() {
    System.Configuration.Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");
    System.Web.Configuration.AuthenticationSection authSection = (System.Web.Configuration.AuthenticationSection)config.GetSection("system.web/authentication");
    TimeSpan timeSpan = authSection.Forms.Timeout;
    string auth = (HttpContext.Current.User.Identity.IsAuthenticated && !IsPersistent()) ? "<<" : "";
    return string.Format("{0} (mins), which is {1} hour(s) and {2} minute(s) {3}", timeSpan.TotalMinutes, timeSpan.TotalHours, timeSpan.Minutes, auth);
  }
  // From web.config, get the persistent cookie timeout (an appSetting)
  string GetPersistentTimeout() {
    string mins = System.Configuration.ConfigurationManager.AppSettings["PersistentCookieTimeout"];
    double result; // don't move this to "out double result" (below) because we need to be compatible with C# < 7.x
    if (double.TryParse(mins, out result))
    {
      TimeSpan timeSpan = TimeSpan.FromMinutes(result);
      string auth = (HttpContext.Current.User.Identity.IsAuthenticated && IsPersistent()) ? "<<" : "";
      return string.Format("{0} (mins), which is {1} day(s) and {2} hour(s) {3}", mins, timeSpan.Days, timeSpan.Hours, auth);
    }
    else
    {
      // Handle the case where mins is not a valid number...
      return "Invalid value in AppSettings[\"PersistentCookieTimeout\"]"; 
    }    
  }
  // is the current user authenticated with a Persistence? (i.e. a persistent cookie)
  bool IsPersistent() {
    if (Request.Cookies[FormsAuthentication.FormsCookieName] != null) {
      FormsAuthenticationTicket ticket = FormsAuthentication
        .Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value);
      return ticket.IsPersistent;
    } else {
      return false;
    }
  }
  //
  // by IP, is the remote IP address a known Accuraty WAN IP?
  bool isIpSpecial() {
    if (logDebug) debugOutput.AppendLine("isIpSpecial() begins...");
    // BUG always returns true, WTF? Added Debug output for HttpContent for IPs (unfinished)
    if (HttpContext.Current.Request.IsLocal) {
      if (logDebug) debugOutput.AppendLine("isIpSpecial() Request.IsLocal is true");
      return true;
    }
    List<string> list = GetAllowedIps();
    // a lot just happened, if it was successful, we have a list of IPs, but if not...
    if (list.Count == 0) { // final fallback
      list = DebugSettings.AllowedIpsListFallback;
      // note that we do NOT cache the fallback list (caching happens only in LoadAllowedIps())
      // IDEA though there is some logic to caching the fallback with a reduced cache timeout (e.g. 2 mins?)
      if (logDebug) debugOutput.AppendLine("isIpSpecial() - list.Count == 0, so using DebugSettings.AllowedIpsListFallback <<< THIS IS BAD!");
      // TODO Send an Email to the Admins that the list of allowed IPs needs fixing?
    }
    if (logDebug) debugOutput.AppendLine("isIpSpecial() completed");
    if (logDebug) debugOutput.AppendLine("");
    return list.Contains(GetIpAddress());
  }

  // Debugging output
  StringBuilder debugOutput = new StringBuilder();
  
  // Get/Cache the JSON file that contains the list of Accuraty WAN IP addresses
  // The list of failoverUrls is defined at the top of this file

  string rawJson = string.Empty;

  // cache key and timeout defined in DebugSettings above
  List<string> GetAllowedIps() {
    if (logDebug) debugOutput.AppendLine("GetAllowedIps() begins...");
    // First. we try to load the list of AllowedIPs from DNN's cache
    List<string> allowedIps = DotNetNuke.Common.Utilities.DataCache.GetCache<List<string>>(DebugSettings.CacheKeyAllowedWanIps);
    
    if (allowedIps == null) {
      // its not in the cache, so we need to load it
      if (logDebug) debugOutput.AppendLine("GetAllowedIps() Not in cache, so we need to load it; ");
      allowedIps = LoadAllowedIps(); // this also caches it
    }
    else {
      if (allowedIps.Count > 0) {
        if (logDebug) debugOutput.Append("GetAllowedIps() Found in cache; ");
      }
      else {
        // this shouldn't happen because we don't SetCache unless the IP count > 0, but... 
        if (logDebug) debugOutput.AppendLine("GetAllowedIps() Found in cache, but list is empty; ");
        allowedIps = LoadAllowedIps();
      }
    }
    if (logDebug) {
      debugOutput.AppendLine("GetAllowedIps() completed with Count=" + allowedIps.Count + ", List: " + string.Join(", ", allowedIps));
    }
    return allowedIps;
  }

  // Load the list of Accuraty WAN IP addresses from the list of Failover URLs
  List<string> LoadAllowedIps() {
    if (logDebug) debugOutput.AppendLine("LoadAllowedIps() begins...");
    List<string> allowedIps = new List<string>();
    // we need a list of places in priority order to load the JSON settings file from; 
    // >> List<string> JsonFileLocations is defined at the top of this file

    if (logDebug) debugOutput.AppendLine("LoadAllowedIps() foreach loop begins... DebugSettings.JsonFileLocations.Count:" + DebugSettings.JsonFileLocations.Count);

    // it contains both URLs and local file paths
    int index = 0;
    foreach (string location in DebugSettings.JsonFileLocations) {
      index = DebugSettings.JsonFileLocations.IndexOf(location);
      if (logDebug) debugOutput.Append("LoadAllowedIps() " + index.ToString() + " location: " + location);
      // handle specials (initially only "HostPath")
      string loc = location;
      switch (location) {
        case "HostPath":
          // convert to DNN HostPath + default filename
          loc = DotNetNuke.Common.Globals.HostMapPath + DebugSettings.JsonDefaultFilename;
          if (logDebug) debugOutput.Append(" >> converted: " + loc);
          break;
        default:
          break;
      }

      // URL or Local path/file?
      if (loc.StartsWith("http", System.StringComparison.OrdinalIgnoreCase))
      {
        // IDEA should we try as-is first, then start mucking around?
        // is the filename included? No, so add JsonDefaultFilename
        // does the filename have an extension? No, so add "/" + JsonDefaultFilename
        // do we care if it is not .json? (could come from an API url in the future?)
        /// var afile = System.IO.Path.GetFileName(loc);
        /// if (logDebug) debugOutput.Append("[ filename: " + afile + ", " + (afile == string.Empty).ToString() + " ]");
        bool retry = false;
        try
        {
          rawJson = DownloadJson(loc);
          if (string.IsNullOrEmpty(rawJson))
          {
            if (logDebug) debugOutput.AppendLine(" << URL returned empty response");
            continue;
          }
        }
        catch (System.Exception ex)
        {
          if (logDebug) debugOutput.AppendLine(string.Format(" << URL FAILED: {0}", ex.Message));
          continue;
        }
      }
      else 
      {
        // Local path/file
        try {
          // try to get the JSON from the local file
          rawJson = System.IO.File.ReadAllText(loc);
        } catch (Exception ex) {
          // if we got an error, log it and try the next URL
          if (logDebug) debugOutput.AppendLine(string.Format(" << FILE FAILED: {0}", ex.Message));
          continue;
        }
      }
      // if we got Valid JSON and we parsed at least 1 allowed IP, break out of the foreach loop
      if (!string.IsNullOrEmpty(rawJson)) {
        if (logDebug) debugOutput.Append(" << returned something; ");
        // we got something, but is it valid JSON?
        if (IsValidJson(rawJson)) {
          if (logDebug) debugOutput.AppendLine("Valid JSON, now we parse it...");
          allowedIps = ParseAllowedIps(rawJson);
          if (allowedIps.Count > 0) {
            break;
          }
          else
          {
            if (logDebug) debugOutput.AppendLine(" ^^ JSON IS VALID, but the list is empty");
            continue;
          }
        } else {
          // not valid JSON, so try the next URL
          if (logDebug) debugOutput.AppendLine(" ^^ JSON IS NOT VALID");
          continue;
        }
      }
    }
    if (logDebug) debugOutput.AppendLine("LoadAllowedIps() foreach loop completed");
    // if we got here, we have a list of allowed IPs, or an empty list
    if (allowedIps.Count > 0)
    {
      // DNN cache the list
      if (logDebug) debugOutput.AppendLine("LoadAllowedIps() DNN SetCache-ing the list of allowed IPs");
      DotNetNuke.Common.Utilities.DataCache.SetCache(DebugSettings.CacheKeyAllowedWanIps, allowedIps, TimeSpan.FromMinutes(DebugSettings.CacheTimeout));
      // if allowedIps is > 0 and this is the first/primary location, we 
      // just re-write the secondary location (local default file) every time?
      if (index == 0) {
        // write the JSON to the local file
        // TODO only write if it is different than what is already there
        // TODO only write if the versions are different (rawJson.Version exists)
        // TODO put in a Try/Catch just in case?
        if (logDebug) debugOutput.AppendLine("LoadAllowedIps() writing the rawJson to the local file, HostPath/" + DebugSettings.JsonDefaultFilename);
        System.IO.File.WriteAllText(DotNetNuke.Common.Globals.HostMapPath + DebugSettings.JsonDefaultFilename, rawJson);
      }
    }
    if (logDebug) debugOutput.AppendLine("LoadAllowedIps() completed");
    return allowedIps;
  }

  // note that we have already done IsValidJson() on the rawJson before we got here (in LoadAllowedIps())
  List<string> ParseAllowedIps(string rawJson) {
    if (logDebug) debugOutput.AppendLine("ParseAllowedIps() begins...");
    List<string> allowedIps = new List<string>();

    using (System.Text.Json.JsonDocument document = System.Text.Json.JsonDocument.Parse(rawJson))
    {
      System.Text.Json.JsonElement root = document.RootElement;
      System.Text.Json.JsonElement allowedIpsElement;

      if (logDebug) debugOutput.AppendLine("ParseAllowedIps() expecting node named: \"" + DebugSettings.JsonElementNameAllowedIps + "\"");
      if (root.TryGetProperty(DebugSettings.JsonElementNameAllowedIps, out allowedIpsElement))
      {
        if (logDebug)
        {
          debugOutput.AppendLine("ParseAllowedIps() allowedIpsElement: found, contains:");
          debugOutput.AppendLine(Regex.Replace(allowedIpsElement.ToString(), "\\s", ""));
        }
      }
      else
      {
        if (logDebug) debugOutput.AppendLine("ParseAllowedIps() allowedIpsElement: NOT found");
      }

      if (allowedIpsElement.ValueKind == System.Text.Json.JsonValueKind.Undefined)
      {
        if (logDebug) debugOutput.AppendLine("ParseAllowedIps() allowedIpsElement: returned undefined");
      }
      else
      {
        if (allowedIpsElement.ValueKind == System.Text.Json.JsonValueKind.Array)
        {
          foreach (System.Text.Json.JsonElement ipElement in allowedIpsElement.EnumerateArray())
          {
            allowedIps.Add(ipElement.GetProperty("ip").GetString());
          }
        }
        else
        {
          if (logDebug) debugOutput.AppendLine("ParseAllowedIps() allowedIpsElement: NOT an array");
        }
      }
    }

    if (logDebug) debugOutput.AppendLine("ParseAllowedIps() completed, allowedIps.Count: " + allowedIps.Count.ToString() + "");
    return allowedIps;
  }

  // does the given string contain valid JSON (using System.Text.Json)?
  bool IsValidJson(string rawJson) {
    rawJson = rawJson.Trim();
    bool isValid = false;
    if ((rawJson.StartsWith("{") && rawJson.EndsWith("}")) // for object
        || (rawJson.StartsWith("[") && rawJson.EndsWith("]"))) // for array
    {
      try {
        using (var document = System.Text.Json.JsonDocument.Parse(rawJson)) {
          isValid = true;
        }
      } 
      catch (System.Text.Json.JsonException jex) {
        if (logDebug) debugOutput.AppendLine(string.Format("IsValidJson() FAILED: {0}", jex.Message));
      }
      catch (Exception ex) {
        if (logDebug) debugOutput.AppendLine(string.Format("IsValidJson() FAILED: {0}", ex.Message));
      }
    }
    return isValid;
  }

  private static UserInfo _userInfo = null;
  public UserInfo currUserInfo()
  {
    if (_userInfo == null
      || _userInfo != DotNetNuke.Entities.Users.UserController.Instance.GetCurrentUserInfo()
    )
    {
      _userInfo = DotNetNuke.Entities.Users.UserController.Instance.GetCurrentUserInfo();
    }
    return _userInfo;
  }
  public string currUserRoles()
  {
    StringBuilder sb = new StringBuilder();
    if (currUserInfo().IsSuperUser)
    {
      sb.Append("[SuperUser] and ");
    }
    sb.Append("Roles: ");
    foreach (string role in currUserInfo().Roles)
    {
      if (role != "Registered Users" && role != "Subscribers")
      {
        sb.Append(role + ", ");
      }
    }
    return sb.ToString().TrimEnd(new char[] { ',', ' ' });
  }

  // Add at class level
  private static readonly System.Net.Http.HttpClient httpClient = new System.Net.Http.HttpClient();

  // Synchronous wrapper method for DownloadJsonAsync
  private string DownloadJson(string url)
  {
      return System.Threading.Tasks.Task.Run(() => 
          DownloadJsonAsync(url)).GetAwaiter().GetResult();
  }  

  // Replace WebClient code with these methods
  private async System.Threading.Tasks.Task<string> DownloadJsonAsync(string url)
  {
    try
    {
      System.Net.Http.HttpResponseMessage response = await httpClient
        .GetAsync(url)
        .ConfigureAwait(false);
      
      response.EnsureSuccessStatusCode();
      return await response.Content
        .ReadAsStringAsync()
        .ConfigureAwait(false);
    }
    catch (System.Exception ex)
    {
      if (isDebug) 
      {
        debugOutput.AppendLine(string.Format("Error downloading JSON from {0}: {1}", url, ex.Message));
      }
      return string.Empty;
    }
  }

</script>