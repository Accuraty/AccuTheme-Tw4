<%--
  This is abstracted to its own include so it can be reused. By default, it
  is included in `header.ascx` and `footer.ascx`**. We prefer to use SVG files
  and also prefer to inject.

  ** TODO - unresolved problem with duplicate IDs 
  --%>

<%-- 1. RECOMMENDED - use DNN settings and inject
Generally we should do it the Dnn-way first, 
note that around Dnn 9.4 the InjectSvg option was added
IMPORTANT: using this version requires changing header.ascx so we 
are not already wrapped in an A tag (since Dnn emits one) 
--%>

<dnn:LOGO 
  CssClass=""
  LinkCssClass="w-40"
  InjectSvg="true"
  runat="server"
  alt="Your Company"
/>

