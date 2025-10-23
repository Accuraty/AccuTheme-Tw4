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

  Parent: Main.ascx (default) or any other theme (skin) file
  Children: preheader.ascx, logo.ascx, nav-mobile.ascx

  Examples of available tools/utilities:
  // TODO add examples of using Icons via AccuLadder
  <%=Accu.Icon... ("Star fill") %>
  <%=Accu.Icon... ("Facebook") %> 
--%>

<!--#include file="preheader.ascx"-->
<!--#include file="__notice.ascx"-->

<header class="bg-white relative shadow-sm inline">

  <%-- Site Menu --%>
  <%-- TODO add TabId of SITE page to IncludeNodes (replace 9999) --%>
  <dnn:MENU
    MenuStyle="menus/NavSite"
    IncludeNodes="39" 
    runat="server"
  ></dnn:MENU>

  <%-- Navbar --%>
  <nav id="primary-navigation" class="max-w-7xl flex justify-between items-center text-base mx-auto py-8 px-3" aria-label="Primary navigation">
    
    <%-- Brand + Navigation --%>
    <div class="flex space-x-12 items-center">
    
      <%-- Logo --%>
      <!--#include file="logo.ascx"-->

      <%-- Mobile Menu - Hamburger Menu --%>
      <div class="flex lg:hidden">
        <button type="button" class="-m-2.5 inline-flex items-center justify-center rounded-md p-2.5 text-gray-700">
          <span class="sr-only">Open main menu</span>
          <svg class="size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" data-slot="icon">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
          </svg>
        </button>
      </div>

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

      <%-- Search - should the href be /tabid/NN or the expected page name or ?? --%>
      <div>
        <a type="button" href="/search-results"
          class="relative rounded-full bg-white p-1 text-gray-400 
          hover:text-gray-500 focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:outline-hidden">
          <span class="absolute -inset-1.5"></span>
          <span class="sr-only">Search website</span>
          <svg xmlns="http://www.w3.org/2000/svg" class="size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" data-slot="icon">
            <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
          </svg>
        </a>
      </div>

      <%-- Button - should the href be /tabid/NN or the expected page name or ?? --%>
      <div class="hidden lg:flex lg: flex-1 lg:justify-end">
        <a href="/authenticate" class="rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-xs hover:bg-blue-500">
        Log in
        </a>
      </div>

      <%-- Language Selector - default is little flags --%>
      <%-- TODO needs Tailwind styling and testing
      <div class="language">
        <dnn:LANGUAGE CssClass="inline-block *:flex *:items-center *:gap-1" ID="LANGUAGE1" ShowMenu="False" ShowLinks="True" runat="server" />
      </div>
      -- %>
      
    </div>

  </nav>

  <!-- Mobile menu, show/hide based on menu open state -->
  <%-- <!--#include file="nav-mobile.ascx"--> --%>

</header>
