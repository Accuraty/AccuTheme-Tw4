<%-- 
  EMITS THE PAGE HEADER
  By default, this is:
    - a full row across the top of the page using a grid with 3 columns
    - Desktop (wide):
      - a logo left
      - a primary nav bar in the center
      - secondary nav bits right
    - Mobile (narrow):
      - a hamburger menu left
      - a logo center
      - secondary nav bits right

  Parent: Main.ascx (default) or any other layout (skin) file
  Children: _preheader.ascx, _logo.ascx, _nav-mobile.ascx

  Examples of available tools/utilities:
  <%=AccuTheme.BootstrapIcon("Star fill") %>
  <%=AccuTheme.AccuIcon("Facebook") %>
--%>

<!--#include file="_preheader.ascx"-->
 
<header 
  class="pointer-events-none relative z-50 flex flex-col" 
  style="height:var(--header-height);margin-bottom:var(--header-mb)"
>
  <div class="container pt-3 mx-auto px-5 w-5/6">
    <div class="grid grid-cols-2 gap-5 pt-6 pb-6 lg:flex lg:justify-between lg:pt-0 lg:pb-0">
      <!--#include file="_logo.ascx"-->
      <!--#include file="_nav-mobile.ascx"-->

      <nav id="primary-navigation" class="col-span-full items-center hidden lg:!flex" aria-label="Primary navigation">

        <%-- Primary Nav --%>
        <%-- TODO add TabId of SITE page to ExcludeNodes (replace 9999) --%>
        <dnn:MENU
          MenuStyle="menus/NavPrimary"
          NodeSelector=""
          IncludeNodes=""
          ExcludeNodes="34" 
          runat="server"
        ></dnn:MENU>

      </nav>

      <%-- Site Menu --%>
      <%-- TODO add TabId of SITE page to IncludeNodes (replace 9999) --%>
      <dnn:MENU
        MenuStyle="menus/SiteMenu"
        IncludeNodes="34" 
        runat="server"
      ></dnn:MENU>

    </div>
  </div>
</header>
