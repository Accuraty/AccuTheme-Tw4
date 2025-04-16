<%-- Don't render any HTML unless at least one pane has content. --%>
<% if (Col1Pane.Visible == true || Col2Pane.Visible == true || Col3Pane.Visible == true) { %>
  <div class="grid grid-cols-12 gap-8 lg:gap-16 xl:gap-24 mt-8">
    <div
      id="Col1Pane"
      class="col-span-12 md:col-span-4 bg-zinc-200 inline-block"
      visible="false"
      runat="server"
    ></div>
    <div
      id="Col2Pane"
      class="col-span-12 md:col-span-4 bg-slate-200 inline-block"
      visible="false"
      runat="server"
    ></div>
    <div
      id="Col3Pane"
      class="col-span-12 md:col-span-4 bg-stone-200 inline-block"
      visible="false"
      runat="server"
    ></div>    
  </div>
<% } %>
