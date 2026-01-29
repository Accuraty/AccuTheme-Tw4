<%-- 
  TODO REWRITE THIS FOR EACH NEW PROJECT DESIGN
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

  <%-- Main Header row --%>
  <nav id="primary-navigation" class="max-w-7xl flex justify-between items-center text-base mx-auto py-8 px-3" aria-label="Primary navigation">
    
    <%-- Brand + Navigation --%>
    <div class="flex items-center gap-x-6">
      <%-- Logo --%>
      <!--#include file="logo.ascx"-->
    </div>

    <%-- Nav Search + CTA Button --%>
    <div class="flex items-center gap-x-4 lg:gap-x-6">

      <%-- Search - should the href be /tabid/NN or the expected page name or ?? --%>
      <%-- <div>
        <a type="button" href="/search-results"
          class="">
          <span class="sr-only">Search website</span>
          <svg xmlns="http://www.w3.org/2000/svg" class="size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" data-slot="icon">
            <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
          </svg>
        </a>
      </div> --%>

      <%-- Primary Navigation --%>
      <%-- TODO add TabId of SITE page to ExcludeNodes (replace 9999) --%>
      <%-- Below, ExcludeNodes currently includes 21 for the Welcome/Home on ACCU4.COM, remove it!! --%>
      <dnn:MENU
        MenuStyle="menus/NavPrimary"
        NodeSelector=""
        IncludeNodes=""
        ExcludeNodes="21,39" 
        runat="server"
      >
        <%-- <TemplateArguments> 
          <dnn:TemplateArgument Name="AddWrapperClass" Value="AccuWrapper" />
        </TemplateArguments>
        <ClientOptions> 
          <dnn:ClientString Name="AccuType" Value="site" />
          <dnn:ClientNumber Name="MinHeight" Value="10" />
          <dnn:ClientBoolean Name="UseShadows" Value="true" />
        </ClientOptions> --%>
      </dnn:MENU>

      <%-- Button - should the href be /tabid/NN or the expected page name or ?? --%>
      <%-- <div class="hidden lg:flex lg:flex-1 lg:justify-end">
        <a href="/authenticate" class="rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-xs hover:bg-blue-500">
        Log in
        </a>
      </div>  --%>

      <%-- Language Selector - default is little flags --%>
      <%-- TODO needs Tailwind styling and testing --%>
      
      <%-- <div class="language">
        <dnn:LANGUAGE CssClass="inline-block *:flex *:items-center *:gap-1" ID="LANGUAGE1" ShowMenu="False" ShowLinks="True" runat="server" />
      </div> --%>
      
    </div>

  </nav>

  <!-- Mobile menu, show/hide based on menu open state -->
  <%-- <!--#include file="nav-mobile.ascx"--> --%>

  <!-- Tailwind Play example -->
  <!-- Comment out everything above expect for the header tag, and uncomment this to see a working mobile menu with elements -->
  <%-- <nav aria-label="Global" class="mx-auto flex max-w-7xl items-center justify-between p-6 lg:px-8">
    <div class="flex items-center gap-x-12">
      <a href="#" class="-m-1.5 p-1.5">
        <span class="sr-only">Your Company</span>
        <img src="https://tailwindcss.com/plus-assets/img/logos/mark.svg?color=indigo&shade=600" alt="" class="h-8 w-auto" />
      </a>
      <div class="hidden lg:flex lg:gap-x-12">
        <a href="#" class="text-sm/6 font-semibold text-gray-900">Product</a>
        <a href="#" class="text-sm/6 font-semibold text-gray-900">Features</a>
        <a href="#" class="text-sm/6 font-semibold text-gray-900">Marketplace</a>
        <a href="#" class="text-sm/6 font-semibold text-gray-900">Company</a>
      </div>
    </div>
    <div class="flex lg:hidden">
      <button type="button" command="show-modal" commandfor="mobile-menu" class="-m-2.5 inline-flex items-center justify-center rounded-md p-2.5 text-gray-700">
        <span class="sr-only">Open main menu</span>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" data-slot="icon" aria-hidden="true" class="size-6">
          <path d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" stroke-linecap="round" stroke-linejoin="round" />
        </svg>
      </button>
    </div>
    <div class="hidden lg:flex">
      <a href="#" class="text-sm/6 font-semibold text-gray-900">Log in <span aria-hidden="true">&rarr;</span></a>
    </div>
  </nav>
  <el-dialog>
    <dialog id="mobile-menu" class="backdrop:bg-transparent lg:hidden">
      <div tabindex="0" class="fixed inset-0 focus:outline-none">
        <el-dialog-panel class="fixed inset-y-0 right-0 z-50 w-full overflow-y-auto bg-white p-6 sm:max-w-sm sm:ring-1 sm:ring-gray-900/10">
          <div class="flex items-center justify-between">
            <a href="#" class="-m-1.5 p-1.5">
              <span class="sr-only">Your Company</span>
              <img src="https://tailwindcss.com/plus-assets/img/logos/mark.svg?color=indigo&shade=600" alt="" class="h-8 w-auto" />
            </a>
            <button type="button" command="close" commandfor="mobile-menu" class="-m-2.5 rounded-md p-2.5 text-gray-700">
              <span class="sr-only">Close menu</span>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" data-slot="icon" aria-hidden="true" class="size-6">
                <path d="M6 18 18 6M6 6l12 12" stroke-linecap="round" stroke-linejoin="round" />
              </svg>
            </button>
          </div>
          <div class="mt-6 flow-root">
            <div class="-my-6 divide-y divide-gray-500/10">
              <div class="space-y-2 py-6">
                <a href="#" class="-mx-3 block rounded-lg px-3 py-2 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Product</a>
                <a href="#" class="-mx-3 block rounded-lg px-3 py-2 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Features</a>
                <a href="#" class="-mx-3 block rounded-lg px-3 py-2 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Marketplace</a>
                <a href="#" class="-mx-3 block rounded-lg px-3 py-2 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Company</a>
              </div>
              <div class="py-6">
                <a href="#" class="-mx-3 block rounded-lg px-3 py-2.5 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Log in</a>
              </div>
            </div>
          </div>
        </el-dialog-panel>
      </div>
    </dialog>
  </el-dialog> --%>

</header>
