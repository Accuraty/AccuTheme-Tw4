<!--#include file="registers.ascx"-->

<%-- Meta tags 
================================================== --%>

<%@ Register TagPrefix="accu" TagName="MetaTags" src="../controls/meta.ascx" %>
<accu:MetaTags runat="server" />


<%-- Stylesheets

CSS priorities and suggested order (note that * denotes a core DNN file):

  1.    Font API links (e.g., Google Fonts, Typekit)
  5.    Default CSS*
  6-9.  Vendor CSS (e.g., Tailwind)
  10.   Module CSS*
  15.   Skin CSS*
  16.   Custom CSS: `public/YOUR_FILE_HERE`
  20.   Specific Skin CSS
  25.   Container CSS*
  30.   Specific Container CSS*
  35.   Portal CSS*

Reference: http://www.dnnsoftware.com/wiki/client-resource-management-api
========================================================================== --%>

<%-- YOU CAN DELETE THIS FROM A NEW PROJECT

  I(CML)'d love to remove the `default.css` stylesheet, but many of the styles are
  used for DNN edit controls. Probably going to leave it as is (and continue
  overriding these styles) instead of writing them from scratch. But keeping
  this tag here for reference just in case.
--%>

<% if (!isEditMode) { %>
  <dnn:DnnCssExclude Name="dnndefault" runat="server" />
<% 
  Accuraty.Libraries.AccuLadder.Accu.Dev.Log("Note: DnnCssExclude dnndefault happened");
  } 
%>

<%-- FontAwesome Pro, Kits are managed here; https://fontawesome.com/kits 
- Note: switched from v6 to v7 20250806 JRF
- <script src="https://kit.fontawesome.com/c968ea8bda.js" crossorigin="anonymous"></script>
--%>
<dnn:DnnJsInclude
  FilePath="https://kit.fontawesome.com/c968ea8bda.js"
  ForceProvider="DnnFormBottomProvider"
  HtmlAttributesAsString="async defer crossorigin:anonymous" 
  Priority="42"
  runat="server"
/>

<%-- STYLESHEET FROM A CDN

--%>
<%--
<dnn:DnnCssInclude
  FilePath="URL_TO_YOUR_FILE_HERE"
  Priority="1"
  runat="server"
/>
--%>

<%-- STYLESHEET FROM THE SKIN DIRECTORY
<dnn:DnnCssInclude
  FilePath="public/YOUR_FILE_HERE"
  PathNameAlias="SkinPath"
  Priority="16"
  runat="server"
/>
--%>

<%-- 1. TYPEKIT example, steps to use:
1. update the [KitId] 
2. uncomment it 
3. delete this comment so future you (or someone) is not confused
--%>
<%-- Adobe Fonts (TypeKit)
- https://fonts.adobe.com/my_fonts#web_projects-section
- kit includes FONT NAMES, needs to be updated once fonts are final
--%>
<%-- 
<dnn:DnnCssInclude
  FilePath="https://use.typekit.net/[KitId].css"
  HtmlAttributesAsString="async defer crossorigin:anonymous"
  Priority="1"
  runat="server"
/>
--%>

<%-- 1. Google Fonts example, steps to use:
1. Copy the contents from Google, should look like the below links but with the [font-name] in place
2. Uncomment the dnn:DnnCssInclude below (line 99-106)
3. Leave lines 92-98 commented
4. Delete this comment so future you (or someone) is not confused
--%>
<%-- Copied contents from Google for [ font name ]
https://fonts.google.com/share?selection.family=[font-name]

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=[font-name]&display=swap" rel="stylesheet">
--%>
<%--
<dnn:DnnCssInclude
  FilePath="https://fonts.googleapis.com/css2?family=[font-name]&display=swap"
  Priority="1"
  ForceProvider="DnnPageHeaderProvider"
  runat="server"
/>
--%>

<%-- Tailwind UI, getting set up (if you have a tailwindui license)
https://tailwindui.com/documentation
--%>

<%-- Tailwind UI, Optional: Add the Inter font family, https://rsms.me/inter/
<link rel="stylesheet" href="https://rsms.me/inter/inter.css">
--%>
<dnn:DnnCssInclude
  FilePath="https://rsms.me/inter/inter.css"
  Priority="9"
  HtmlAttributesAsString="async defer crossorigin:anonymous"
  runat="server"
/>


<%-- Tailwind CSS custom load for AccuTheme --%>
<%-- <!-- AccuTheme.IsUnCacheEnabled: <%=AccuTheme.IsUnCacheEnabled() %> --> --%>
<%--
  string cssPath = $"{AccuTheme.SkinPath}AccuTheme-Tw4.css";
  cssPath = AccuTheme.IsUnCacheEnabled() ? $"{cssPath}?nocache={DateTime.Now.Ticks}" : cssPath;
  ClientResourceManager.RegisterStyleSheet(
    page: this.Page, 
    filePath: cssPath,
    priority: 7,
    provider: "DnnPageHeaderProvider" 
  );
--%>
<%-- <!-- cssPath: <%=cssPath %> --> --%>


<%-- Scripts

JS priorities and suggested order (note that * denotes a core DNN file):

  5.    jQuery*
  10.   jQuery UI*
  100.  Default*
  101.  Runtime: Code needed for Webpack to execute
  102.  Vendors: Node modules (bundled by Webpack)
  103.  Skin: Global scripts (bundle by Webpack)

Reference: http://www.dnnsoftware.com/wiki/client-resource-management-api
========================================================================== --%>

<%-- SCRIPT WITH ASYNC AND DEFER FROM A CDN
<dnn:DnnJsInclude
  FilePath="URL_TO_FILE_HERE.js"
  Priority="100"
  HtmlAttributesAsString="async defer crossorigin:anonymous"
  runat="server"
/>
--%>
<%-- RESULT:
<script src="URL_TO_FILE_HERE.js" async defer crossorigin="anonymous" type="text/javascript"></script>

Reference: https://docs.dnncommunity.org/content/tutorials/client-resources/index.html#additional-attributes
========================================================================== --%>

<%-- example of conditionally loading a script, IF the file exists --%>
<% 
if ( AccuTheme.skinFileExists(AccuTheme.SkinJsPath, "common.bundle.js") ) 
{ 
  ClientResourceManager.RegisterScript(
    this.Page, 
    AccuTheme.SkinJsPath + "/" + "common.bundle.js", 
    103,
    "DnnFormBottomProvider"
  );
}
%>
<%--
<dnn:DnnJsInclude
  FilePath="dist/common.bundle.js"
  PathNameAlias="SkinPath"
  ForceProvider="DnnFormBottomProvider"
  Priority="103"
  runat="server"
/>
--%>

<%-- future: transpile/bundle these as type="module" // HtmlAttributesAsString = "type:module, --%>
<%
if ( AccuTheme.skinFileExists(AccuTheme.SkinJsPath, "skin.bundle.js") ) 
{ 
  string bundle = $"{AccuTheme.SkinJsPath}/skin.bundle.js";
  IDictionary<string, string> attribs = new Dictionary<string, string>();
  attribs.Add("async defer crossorigin", "anonymous");
  ClientResourceManager.RegisterScript(
    page: this.Page, 
    filePath: bundle, 
    priority: DotNetNuke.Web.Client.FileOrder.Js.DefaultPriority,
    provider: "DnnFormBottomProvider"
  );
  Accuraty.Libraries.AccuLadder.Accu.Dev.Log(".SkinJsPath+", bundle);
}
%>
<%--
<dnn:DnnJsInclude
  FilePath="dist/skin.bundle.js"
  PathNameAlias="SkinPath"
  ForceProvider="DnnFormBottomProvider"
  HtmlAttributesAsString = "async defer crossorigin:anonymous"
  Priority="104"
  runat="server"
/>
--%>

<%-- Tailwind CSS Intersection Plugin. https://github.com/heidkaemper/tailwindcss-intersect 
<script defer src="https://unpkg.com/tailwindcss-intersect@1.x.x/dist/observer.min.js"></script>
--%>
<dnn:DnnJsInclude
  FilePath="https://unpkg.com/tailwindcss-intersect@1.x.x/dist/observer.min.js"
  HtmlAttributesAsString = "defer crossorigin:anonymous"
  Priority="107"
  runat="server"
/>

<%-- AlpineJS core. https://alpinejs.dev/essentials/installation --%>
<dnn:DnnJsInclude
  FilePath="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"
  HtmlAttributesAsString = "defer crossorigin:anonymous"
  Priority="106"
  runat="server"
/>
<%-- AlpineJS plugins, https://alpinejs.dev/plugins/persist 
  NOTE: in Alpine, plugins are loaded BEFORE the core, so... Priority.
--%>
<dnn:DnnJsInclude
  FilePath="https://cdn.jsdelivr.net/npm/@alpinejs/persist@3.x.x/dist/cdn.min.js"
  HtmlAttributesAsString = "defer crossorigin:anonymous"
  Priority="105"
  runat="server"
/>
<%-- DNN NOTE: above is a non-standard trick with HtmlAttributesAsString. 

  HtmlAttributesAsString is a string of key:value pairs separated by commas. 
  https://docs.dnncommunity.org/content/tutorials/client-resources/
  
  However, in modern HTML it is common practice with 'defer' and 'async' to 
  not include a value (defer="true" is implied). But if you do no value, 
  e.g. 'defer,crossorigin...', the result will be a non-working attribute, 
  "defer,crossorigin ...". To get around this, above, we instead use a space 
  after defer. This is a hack, in reality what DNN is doing is setting the 
  Name to "defer crossorigin" with a Value of "anonymous". 
  
  So, just beware or be aware. This also means, at least as of DNN 9.11.x, 
  that you cannot put defer (or async) at the end of the list of 
  attributes (as it will become part of the value).
--%>
