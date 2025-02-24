<%-- Before edits - default --%>
<footer class="bg-white">
  <div class="mx-auto max-w-7xl px-6 pt-12 pb-8 lg-px-8">
    <div class="md:grid md:grid-cols-3 gap-8 md:gap-12 lg:gap-8 mb-12">  

      <%-- Brand + Mission --%>
      <div class="space-y-6 mb-8">
        <%-- LOGO --%>
        <!--#include file="logo.ascx"-->

        <%-- META: Mission Statment/About --%>
        <p class="text-sm/6 text-balance text-gray-600">Making the world a better place one website at a time.</p>
      </div>

        <%-- Quick Links --%>
        <div class="space-y-6 mb-8">
          <h4 class="text-sm/6 font-semibold text-gray-900">Quick Links</h4>
          <p class="text-sm/6 text-pretty text-gray-600">We should make a custom NavFooter for all projects and this will auto populate certain pages. Use AHRMA as an example.</p>
        </div>

        <%-- Social Media --%>
        <div class="space-y-6 flex flex-col justify-start lg:items-end">
          <h4 class="text-sm/6 font-semibold text-gray-900">Follow Us</h4>
          <!--#include file="social-media.ascx"-->
        </div>

    </div>

          <%-- META - Copyright + Credits --%>
      <div class="grid md:grid-cols-2 md:gap-8 xl:col-span-2">
        
        <%-- META - Copyright--%>
        <div class="md:grid md:grid-col-2 md:gap-8 mb-8 md:mb-0">
          <div class="flex gap-x-6 text-xs">
            <div><dnn:COPYRIGHT id="dnnCopyright" runat="server" /></div>
            <div><dnn:TERMS id="dnnTerms" Text="Terms" runat="server" /></div>
            <div><dnn:PRIVACY id="dnnPrivacy" Text="Privacy" runat="server" /></div>
          </div>
        </div>

        <%-- META - Credits --%>
        <div class="">
          <p class="text-xs lg:text-right">Development and hosting by 
            <a href="https://accuraty.com" target="_blank" rel="nofollow noopener noreferrer">
              Accuraty Solutions
            </a>
          </p>
        </div>

      </div>

  </div>
</footer>

<!--#include file="__debug.ascx"-->
