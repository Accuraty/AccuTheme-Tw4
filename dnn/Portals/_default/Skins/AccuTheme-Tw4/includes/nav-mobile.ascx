<el-dialog>
  <dialog id="mobile-menu" class="backdrop:bg-transparent lg:hidden">
    <div tabindex="0" class="fixed inset-0 focus:outline-none">
      <el-dialog-panel class="fixed inset-y-0 right-0 z-50 w-full overflow-y-auto bg-white p-6 sm:max-w-sm sm:ring-1 sm:ring-gray-900/10">
        
        <div class="flex items-center justify-between">
          <%-- Logo --%>
          <!--#include file="logo.ascx"-->

          <%-- Close button --%>
          <button type="button" command="close" commandfor="mobile-menu" class="-m-2.5 rounded-md p-2.5 text-gray-600">
            <span class="sr-only">Close menu</span>
            <svg class="size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" data-slot="icon">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <%--TODO - update the ExcludeNodes --%>
        <%-- Mobile menu links --%>
        <div class="mt-6 flow-root">
          <div class="-my-6 divide-y divide-gray-500/10">
            <dnn:MENU
              MenuStyle="menus/NavMobile"
              NodeSelector=""
              IncludeNodes=""
              ExcludeNodes="21,39"
              runat="server"
            ></dnn:MENU>
          </div>
        </div>

        <!-- Search and Login-->
        <div class="flex justify-between">
          <div class="py-6">
            <a href="#" class="-mx-3 block rounded-lg px-3 py-2.5 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Log in</a>
          </div>
          <div class="flex items-center">
            <a type="button" href="/search-results" class="">
              <span class="sr-only">Search website</span>
              <svg xmlns="http://www.w3.org/2000/svg" class="size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" data-slot="icon">
                <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"></path>
              </svg>
            </a>
          </div>
        </div>

      </el-dialog-panel>
    </div>
  </dialog>
</el-dialog>
