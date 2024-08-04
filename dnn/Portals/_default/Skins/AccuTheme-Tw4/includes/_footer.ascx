
<footer class="relative z-10 mt-auto flex flex-none items-center py-10 lg:py-20 2xl:py-48">
  <div class="container mx-auto px-5 flex-none">
    <div class="flex flex-col items-start justify-start gap-y-6">  

      <%-- LOGO --%>
      <div class="flex-none">
        <dnn:LOGO 
          ID="logoFooter"
          CssClass="w-[10rem] max-w-[180px] lg:max-w-[275px]"
          LinkCssClass="inline-flex rounded focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-primary" 
          InjectSvg="true" 
          runat="server"  
        />
      </div>

      <%-- META: MINI-ABOUT --%>
      <div class="flex-none">
        <div class="prose prose-sm max-w-[482px]">
          <p><%=PortalSettings.ActiveTab.Description %></p>
        </div>
      </div>
      
      <%-- META: COPYRIGHT --%>
      <div class="flex-none">
        <div><dnn:COPYRIGHT id="dnnCopyright" runat="server" /></div>
        <div><dnn:TERMS id="dnnTerms" Text="Terms" runat="server" /></div>
        <div><dnn:PRIVACY id="dnnPrivacy" Text="Privacy" runat="server" /></div>
      </div>

      <%-- META: CREDITS --%>
      <div class="flex-none">
        <p class="font-mono text-xs">Development and hosting by 
          <a href="https://accuraty.com" target="_blank" rel="nofollow noopener noreferrer">
            Accuraty Solutions
          </a>
        </p>
      </div>

    </div>
  </div>
</footer>

<!--#include file="__debug.ascx"-->
