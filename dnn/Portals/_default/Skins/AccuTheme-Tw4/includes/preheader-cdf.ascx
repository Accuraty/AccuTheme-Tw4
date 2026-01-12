<%-- namespaces --%>
<%-- some common ones commented out for your reference pleasure...
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Text.Json" %>
<%@ Import Namespace="System.Collections.Generic" %>
--%>

<%@ Import Namespace="Microsoft.Extensions.DependencyInjection" %>
<%@ Import Namespace="DotNetNuke.Common.Extensions" %>
<%@ Import Namespace="DotNetNuke.Abstractions" %>
<%@ Import Namespace="DotNetNuke.Abstractions.ClientResources" %>
<%@ Import Namespace="DotNetNuke.Web.Client.ResourceManager" %>
<%@ Import Namespace="Accuraty.Libraries.AccuLadder" %>

<script runat="server">

  private IClientResourceController _clientResourceController;

  protected override void OnLoad(EventArgs e)
  {
      base.OnLoad(e);
      Accu.Dev.Debug = true;
      Accu.Dev.Log("AddJs() start");
      AddJs();
      Accu.Dev.Log("AddJs() end");
      // AddOpenGraph();
  }

  private void AddJs()
  {
    // TODO foreach
    IServiceScope currentScope = HttpContext.Current.GetScope();
    IServiceProvider serviceProvider = currentScope.ServiceProvider;
    this._clientResourceController = serviceProvider.GetRequiredService<IClientResourceController>(); 
    Accu.Dev.Log(this._clientResourceController.GetType().ToString());


    if ( false && !AccuTheme.skinFileExists(AccuTheme.SkinPath, "common.bundle.js") ) 
    { 
      // Accu.Dev.Log("AddJs() - file skipped", "common.bundle.js");
      return;
    }
    // Accu.Dev.Log("AddJs() - skinFileExists", "common.bundle.js");

    // TESTING Fluent CDF
    var cssAuth = _clientResourceController.CreateStylesheet("SkinAuth.css", PathNameAlias.SkinPath)
      .SetProvider(ClientResourceProviders.DnnFormBottomProvider)
      .SetPriority(FileOrder.Css.SkinCss)
    ;

    Accu.Dev.Log("PRE  - Skin code, .ResolvedPath", cssAuth?.ResolvedPath);
    _clientResourceController.AddStylesheet(cssAuth);
    Accu.Dev.Log("POST - Skin code, .ResolvedPath", cssAuth?.ResolvedPath);
    
    cssAuth = _clientResourceController.CreateStylesheet("ReSkinAuth.css", PathNameAlias.SkinPath)
      .SetProvider(ClientResourceProviders.DnnFormBottomProvider)
      .SetPriority(FileOrder.Css.SkinCss)
    ;

    Accu.Dev.Log("PRE  - ReSkin code, .ResolvedPath", cssAuth?.ResolvedPath);
    _clientResourceController.AddStylesheet(cssAuth);
    Accu.Dev.Log("POST - ReSkin code, .ResolvedPath", cssAuth?.ResolvedPath);
    

    var fontyBoldo = _clientResourceController.CreateStylesheet("pathto/fonty-boldo.woff2", PathNameAlias.SkinPath)
      .SetPreload()
      .AddAttribute("as", "font")
      .AddAttribute("type", "font/woff2")
      .SetPriority(7)
      .SetProvider(ClientResourceProviders.DnnPageHeaderProvider)
      .SetCrossOrigin(CrossOrigin.Anonymous)
    ;

    Accu.Dev.Log("PRE  - fontyBoldo code, .ResolvedPath", fontyBoldo?.ResolvedPath);
    _clientResourceController.AddStylesheet(fontyBoldo);
    Accu.Dev.Log("POST - fontyBoldo code, .ResolvedPath", fontyBoldo?.ResolvedPath);


    var fontoBoldy = _clientResourceController.CreateFont("dist/fonts/fonto-boldy.woff2", PathNameAlias.SkinPath)
      .SetProvider(ClientResourceProviders.DnnPageHeaderProvider)
      .SetPriority(99)
      .SetPreload()
      // .AddAttribute("as", "font")
      // .AddAttribute("type", "font/woff2")
      .SetCrossOrigin(CrossOrigin.Anonymous)
    ;

    Accu.Dev.Log("PRE  - fontoBoldy.ResolvedPath", fontoBoldy?.ResolvedPath);
    _clientResourceController.AddFont(fontoBoldy);
    Accu.Dev.Log("POST - fontoBoldy.ResolvedPath", fontoBoldy?.ResolvedPath);

    _clientResourceController.CreateFont("dist/fonts/foobolda.woff2", PathNameAlias.SkinPath)
      .SetProvider(ClientResourceProviders.DnnPageHeaderProvider)
      .SetPriority(89)
      .SetCrossOrigin(CrossOrigin.Anonymous)
      .AddAttribute("TEST", "VALUE3")
      .AddAttribute("Test", "Value2")
      .AddAttribute("test", "value1")
      .Register()
    ;
  }

</script>


<%-- Meta tags --%>
<%-- Stylesheets --%>
<%-- Scripts --%>

<%-- CDF testing --%>
<%-- 
<dnn:DnnCssInclude
  FilePath="pathto/fonty-boldo.woff2"
  PathNameAlias="SkinPath"
  ForceProvider="DnnPageHeaderProvider"
  HtmlAttributesAsString="rel:preload,as:font,type:font/woff2,crossorigin:anonymous"
  Priority="7"
  runat="server"
/>
--%>

<%-- 
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fancyapps/ui@4/dist/fancybox.css" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@fancyapps/ui@4/dist/fancybox.umd.js" crossorigin="anonymous"></script>
--%>
