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
  Children: preheader.ascx, logo.ascx, nav-mobile.ascx

  Examples of available tools/utilities:
  // TODO add examples of using Icons via AccuLadder
  <%=Accu.Icon... ("Star fill") %>
  <%=Accu.Icon... ("Facebook") %>
--%>

<!--#include file="preheader.ascx"-->

<header class="bg-white shadow-sm">

  <%-- Navbar --%>
  <nav id="primary-navigation" class="flex max-w-7xl items-center justify-between text-10rem mx-auto px-6 lg:px-8" aria-label="Primary navigation">
    
    <%-- Brand + Navigation --%>
    <div class="flex items-center gap-x-6">
    
      <%-- Logo --%>
      <!--#include file="logo.ascx"-->

      <%-- Mobile Menu --%>
      <%-- // TODO need to get Tailwind's mobile menu working still - 20250416 BEM --%>
      <%--
      <div class="mr-2 -ml-2 flex items-center md:hidden">
        <!--#include file="nav-mobile.ascx"-->
      </div>
      --%>

      <%-- Primary Navigation --%>
      <%-- TODO add TabId of SITE page to ExcludeNodes (replace 9999) --%>
      <%-- Below, ExcludeNodes currently includes 21 for the Welcome/Home on ACCU4.COM, remove it!! --%>
      <dnn:MENU
        MenuStyle="menus/NavPrimary"
        NodeSelector=""
        IncludeNodes=""
        ExcludeNodes="21,39" 
        runat="server"
      ></dnn:MENU>
    
    </div>

    <%-- Nav Search + CTA Button --%>
    <div class="flex items-center gap-x-6">

      <%-- Search --%>
      <div>
        <button type="button" class="relative rounded-full bg-white p-1 text-gray-400 hover:text-gray-500 focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:outline-hidden">
          <span class="absolute -inset-1.5"></span>
          <span class="sr-only">Search website</span>
          <svg xmlns="http://www.w3.org/2000/svg" class="size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" data-slot="icon">
            <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
          </svg>
        </button>
      </div>

      <%-- Button --%>
      <div>
        <a href="#" class="rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-xs hover:bg-blue-500">
        Log in
        </a>
      </div>

    </div>

  </nav>

  <%-- Site Menu --%>
  <%-- TODO add TabId of SITE page to IncludeNodes (replace 9999) --%>
  <dnn:MENU
    MenuStyle="menus/NavSite"
    IncludeNodes="39" 
    runat="server"
  ></dnn:MENU>

</header>
