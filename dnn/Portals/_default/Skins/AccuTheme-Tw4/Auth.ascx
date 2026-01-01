<%-- 
This started as a copy of AccuTheme-Bs4's Authenticate.ascx
and  
--%>

<!-- #include file="includes/vars.ascx" --> 
<% 
  Accu.Dev.Debug = isDebug;
%>
<div id="page-skin-<%=pageId %>" 
  class=""
>
  <%-- Reminder, nested includes: header < preheader < registers  --%>
  <!--#include file="includes/header.ascx"-->

  <%-- this js file doesn't exist here... yet? 
    if we need it, consider renaming to auth.bundle.js
  --%>
  <dnn:DnnJsInclude
    FilePath="dist/auth.bundle.js"
    PathNameAlias="SkinPath"
    ForceProvider="DnnFormBottomProvider"
    Priority="106"
    runat="server"
  />

  <main
    id="main-<%=pageId %>"
    class="h-full"
    role="main"
    data-component="DnnAuthForm"
  >
    <section class="flex min-h-full flex-col justify-center bg-blue-50 py-12 px-2 sm:px-6 lg:px-8">

      <%-- Note the use of Scale, the Login gets larger on big screens - just delete the xl: and 3xl: classes below if you are not a fan --%>
      <div class="mt-10 w-full sm:mx-auto sm:max-w-md xl:scale-110 xl:mb-10 3xl:scale-125 3xl:mb-25" data-authentication-form>
        <%-- Heading Option 1 --%>
        <div class="flex flex-row-reverse justify-between px-11.5 sm:mx-auto">
          <svg class="text-blue size-16"><use href="#svg-auth-icon"></use></svg>
          <h2 class="mt-6 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Sign in</h2>
        </div>
        <%-- Heading Option 2 --%>
        <%--
        <div
          id="HeaderPane"
          class="w-sm mx-auto"
          visible="false"
          runat="server"
        ></div>
        --%>
        <div class="bg-white shadow-sm rounded-lg  p-9">
          <div
            id="ContentPane"
            class="p-2.5"
            visible="false"
            runat="server"
          ></div>
        </div>
      </div>
    </section>

    <%-- Important: include a link to where you got the SVG from or leave an author credit --%>
    <!-- fa-building-lock from !Font Awesome Free v7.1.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
    <svg class="hidden">
      <symbol class="" fill="currentColor" stroke="" viewBox="0 0 640 640" aria-hidden="true" data-slot="icon" data-chevron=""
        id="svg-auth-icon" 
      >
        <path d="M64 128C64 92.7 92.7 64 128 64L384 64C419.3 64 448 92.7 448 128L448 249.3C401.1 268.3 368 314.3 368 368L368 392.4C348.4 410 336 435.5 336 463.9L336 559.9C336 565.4 336.5 570.8 337.3 576L128 576C92.7 576 64 547.3 64 512L64 128zM208 448L208 528L288 528L288 463.9C288 450.2 289.9 436.9 293.5 424.3C287.8 419.1 280.3 416 272 416L240 416C222.3 416 208 430.3 208 448zM339 288.3C338 288.1 337 288 336 288L304 288C295.2 288 288 295.2 288 304L288 336C288 344.8 295.2 352 304 352L320.7 352C322.8 329.2 329.1 307.7 339 288.3zM176 160C167.2 160 160 167.2 160 176L160 208C160 216.8 167.2 224 176 224L208 224C216.8 224 224 216.8 224 208L224 176C224 167.2 216.8 160 208 160L176 160zM288 176L288 208C288 216.8 295.2 224 304 224L336 224C344.8 224 352 216.8 352 208L352 176C352 167.2 344.8 160 336 160L304 160C295.2 160 288 167.2 288 176zM176 288C167.2 288 160 295.2 160 304L160 336C160 344.8 167.2 352 176 352L208 352C216.8 352 224 344.8 224 336L224 304C224 295.2 216.8 288 208 288L176 288zM528 368.1C528 350.4 513.7 336.1 496 336.1C478.3 336.1 464 350.4 464 368.1L464 416L528 416L528 368.1zM384 464C384 443.1 397.4 425.3 416 418.7L416 368.1C416 323.9 451.8 288.1 496 288.1C540.2 288.1 576 323.9 576 368.1L576 418.7C594.6 425.3 608 443.1 608 464L608 560C608 586.5 586.5 608 560 608L432 608C405.5 608 384 586.5 384 560L384 464z"/>
      </symbol>
    </svg>

  </main>

  <!--#include file="includes/footer.ascx"-->
</div>

