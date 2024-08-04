<%--
  This is abstracted to its own include so it can be reused. By default, it
  is included in `_header.ascx` and `_footer.ascx`**. We prefer to use SVG files
  and also prefer to inject.

  ** TODO - unresolved problem with duplicate IDs 
  --%>
<div class="inline-flex flex-none items-center">

<%-- 1. RECOMMENDED - use DNN settings and inject
Generally we should do it the Dnn-way first, 
note that around Dnn 9.4 the InjectSvg option was added
IMPORTANT: using this version requires changing _header.ascx so we 
are not already wrapped in an A tag (since Dnn emits one) 
--%>
  <dnn:LOGO 
    CssClass="w-[12rem] max-w-[180px] lg:max-w-[250px] xl:max-w-none" 
    LinkCssClass="inline-flex rounded focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-primary" 
    InjectSvg="true" 
    runat="server"  
  />


<%-- 2. ALT - hard-coded IMG tag, still using Dnn Settings
  <a
    class="inline-flex rounded focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-primary"
    href="/"
    aria-label="_xx___CLIENT_NAME___xx_"
  >
    <img
      class="max-w-[180px] lg:max-w-[250px] xl:max-w-none"
      src="<%=PortalSettings.HomeDirectory %><%=PortalSettings.LogoFile %>"
      alt="_xx___CLIENT_NAME___xx_ logo"
    /> 
  </a>
--%>

<%-- 3. DEFAULT - just include the AccuTheme SVG 
<!--#include file="../dist/media/svg/AccuTheme-logo.svg"-->
--%>

</div>
