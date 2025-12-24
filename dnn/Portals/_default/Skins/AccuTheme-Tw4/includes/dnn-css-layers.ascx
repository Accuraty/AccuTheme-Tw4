<%-- DNN CSS Cascade Layers Hack

Until DNN natively supports and uses CSS Layers, we are responsible 
for removing the default DNN versions and adding modified versions 
that put all DNN CSS into a layer named "dnn". 202512 JRF

Note: we should not have to replace well-written non-leaky (hi Josh!)
CSS that stays contained to its targets (e.g. has a wrapper, nested)

STEPS
1. exclude the default
2. include a well-named modified version of same

================================================== --%>

<%-- DNN Default (see /Resources/Shared/stylesheets/...) --%>
<dnn:DnnCssExclude Name="dnndefault" runat="server" />
<dnn:DnnCssInclude
  FilePath="dist/layers/default.10.02.00.css"
  PathNameAlias="SkinPath"
  ForceProvider="DnnPageHeaderProvider"
  Priority="5"
  runat="server"
/>

<%-- DNN Admin (see /Portals/_default/admin.css) --%>
<dnn:DnnCssExclude Name="/Portals/_default/admin.css" runat="server" />
<dnn:DnnCssInclude
  FilePath="dist/layers/admin.10.02.00.css"
  PathNameAlias="SkinPath"
  ForceProvider="DnnPageHeaderProvider"
  HtmlAttributesAsString=""
  Priority="6"
  runat="server"
/>

<%-- DNN portal.css (see /Portals/0/portal.css) --%>
<dnn:DnnCssExclude Name="/Portals/0/portal.css" runat="server" />
<%-- >> no replacement, but it can be enabled if its the right solution for an issue --%>

<%-- 
  DNN code example for adding stuff in head see DNN 10+'s 
  Aperture theme, partials/_includes.ascx (adding fonts) --%>

<%-- 
  Leave this in the Tw4 template, fee free to DELETE THIS FROM A NEW PROJECT

  I'd love to remove the `default.css` stylesheet, but many of the styles are
  used for DNN edit controls. Probably going to leave it as is (and continue
  overriding these styles) instead of writing them from scratch. But keeping
  this tag here for reference just in case. 2019?? CML --%>
  