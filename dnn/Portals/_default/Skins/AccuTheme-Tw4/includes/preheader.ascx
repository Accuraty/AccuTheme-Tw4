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

  I'd love to remove the `default.css` stylesheet, but many of the styles are
  used for DNN edit controls. Probably going to leave it as is (and continue
  overriding these styles) instead of writing them from scratch. But keeping
  this tag here for reference just in case.
--%>
  <dnn:DnnCssExclude Name="dnndefault" runat="server" />


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

<%-- Tailwind UI, getting set up (if you have a tailwindui license)
https://tailwindui.com/documentation
--%>

<%-- Tailwind UI, Optional: Add the Inter font family
https://rsms.me/inter/
<link rel="stylesheet" href="https://rsms.me/inter/inter.css">
--%>
<dnn:DnnCssInclude
  FilePath="https://rsms.me/inter/inter.css"
  Priority="9"
  HtmlAttributesAsString="async:async,defer:defer"
  runat="server"
/>




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
  HtmlAttributesAsString="async:async,defer:defer"
  runat="server"
/>
--%>
<%-- RESULT:
<script src="URL_TO_FILE_HERE.js" async="async" defer="defer" type="text/javascript"></script>

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
<dnn:DnnJsInclude
  FilePath="dist/js/skin.bundle.js"
  PathNameAlias="SkinPath"
  ForceProvider="DnnFormBottomProvider"
  HtmlAttributesAsString = "async:async,defer:defer,crossorigin:anonymous"
  Priority="104"
  runat="server"
/>

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
