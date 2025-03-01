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
 
<header 
  class="bg-white shadow-sm" 
  <%-- style="height:var(--header-height);margin-bottom:var(--header-mb)" --%>
>
  <%-- Navbar --%>
  <nav id="primary-navigation" class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8" aria-label="Primary navigation">
    <div class="flex h-16 justify-between">

      <%-- Brand + Navigation --%>
      <div class="flex">

        <%-- Mobile Menu --%>
        <div class="mr-2 -ml-2 flex items-center md:hidden">
          <!--#include file="nav-mobile.ascx"-->
        </div>

        <%-- Logo --%>
        <div class="flex shrink-0 items-center">
          <!--#include file="logo.ascx"-->
        </div>

        <%-- Primary Nav --%>
        <%-- TODO add TabId of SITE page to ExcludeNodes (replace 9999) --%>
        <%-- Below, ExcludeNodes currently includes 21 for the Welcome/Home on ACCU4.COM, remove it!! --%>
        <dnn:MENU
          MenuStyle="menus/NavPrimary"
          NodeSelector=""
          IncludeNodes=""
          ExcludeNodes="21,34" 
          runat="server"
        ></dnn:MENU>
      </div>
      <%-- End of Brand + Navigation --%>

      <%-- Search Icon + Call to Action --%>
      <div class="flex items-center">
        
        <%-- Search Icon --%>
        <div class="hidden md:mr-4 md:flex md:shrink-0 md:items-center">
          <button type="button" class="relative rounded-full bg-white p-1 text-gray-400 hover:text-gray-500 focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:outline-hidden">
            <span class="absolute -inset-1.5"></span>
            <span class="sr-only">Search website</span>
            <svg xmlns="http://www.w3.org/2000/svg" class="size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" data-slot="icon">
              <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
            </svg>
          </button>
        </div>

        <%-- Call to Action --%>
        <div class="shrink-0">
          <button type="button" class="relative inline-flex items-center gap-x-1.5 rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
            <!-- Uncomment for an icon -->
            <!-- <svg class="-ml-0.5 size-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" data-slot="icon">
              <path d="M10.75 4.75a.75.75 0 0 0-1.5 0v4.5h-4.5a.75.75 0 0 0 0 1.5h4.5v4.5a.75.75 0 0 0 1.5 0v-4.5h4.5a.75.75 0 0 0 0-1.5h-4.5v-4.5Z" />
            </svg> -->
            Call to Action
          </button>
        </div>
      </div>
      <%-- End of Search Icon + Call to Action --%>

    </div>
  </nav>

  <%-- Site Menu --%>
  <%-- TODO add TabId of SITE page to IncludeNodes (replace 9999) --%>
  <dnn:MENU
    MenuStyle="menus/NavSite"
    IncludeNodes="34" 
    runat="server"
  ></dnn:MENU>

</header>
