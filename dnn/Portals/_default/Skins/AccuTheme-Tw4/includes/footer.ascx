<%-- Before edits - default --%>
<%-- if footer bg is white than remove the py-10 on line 4 and replace with pb-10 --%>
<footer class="bg-gray-100 mt-20 lg:mt-32">
  <div class="max-w-7xl mx-auto py-8">
    <div class="xl:grid xl:grid-cols-2 xl:gap-8">

      <%-- Brand + Mission --%>
      <div class="space-y-5 justify-items-center">
        
        <%-- LOGO --%>
        <div class="max-w-7xl flex flex-col justify-between items-center mx-auto px-4 lg:flex-row sm:px-6 lg:px-0">
          <!--#include file="logo.ascx"-->
        </div>

        <%-- Mission Statment --%>
        <div class="text-sm/6 text-balance text-center text-gray-600 mb-6 max-sm:px-4 xl:text-left">
          Making the world a better place by carefully crafting websites that are original, useful, elegant, functional, and have an overdose of Accuraty-approved awesome.
        </div>
      </div>

      <%-- Social + Nav --%>
      <div class="grid grid-cols-1 gap-5 justify-self-center mb-6 xl:justify-self-end">

        <%-- Social Media --%>
        <!--#include file="social-media.ascx"-->

        <%-- Footer Nav --%>
        <%-- 
        <div class="flex mb-6 xl:mb-0">
          <div class="max-w-7xl overflow-hidden">
            <dnn:MENU
              MenuStyle="menus/NavPrimary"
              NodeSelector=""
              IncludeNodes=""
              ExcludeNodes="21,34" 
              runat="server"
            ></dnn:MENU>
          </div>
        </div>  
        --%>
      </div>
    </div>

    <%-- META - Copyright + Credits --%>
    <div class="border-t border-gray-900/10">
      <div class="flex flex-wrap justify-center xl:justify-between gap-x-12 gap-y-3 text-sm/6 text-gray-600">
        <%-- Copyright + Legal --%>
        <div class="max-w-7xl grid grid-cols-4 lg:flex gap-6 text-center mt-6 max-md:mx-auto lg:text-left">
          <div class="col-span-4 md:col-span-2"><dnn:COPYRIGHT id="dnnCopyright" runat="server" /></div>
          <div class="col-span-2 md:col-span-1 font-semibold text-gray-600 hover:text-gray-900"><dnn:TERMS id="dnnTerms" Text="Terms" runat="server" /></div>
          <div class="col-span-2 md:col-span-1 font-semibold text-gray-600 hover:text-gray-900"><dnn:PRIVACY id="dnnPrivacy" Text="Privacy" runat="server" /></div>
        </div>
        <%-- Credits --%>
        <div class="text-sm/6 text-center text-gray-600 mt-6">Development and hosting by 
          <a class="font-semibold text-gray-600 hover:text-gray-900" href="https://accuraty.com" target="_blank" rel="nofollow noopener noreferrer">
            Accuraty Solutions
          </a>
        </div>
      </div>
    </div>

  </div>
</footer>

<!--#include file="__debug.ascx"-->
