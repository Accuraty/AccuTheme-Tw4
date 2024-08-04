/* SITE MENU

See SiteMenu.cshtml, to handle dropdowns we add a data-target-id attribute 
(see example below) to the item that gets clicked to open the dropdown and 
its value is the #id of the container of the submenu to unhide.

Example:
  <a class="..." href="#" data-target-id="submenuOfButton-36" ... >
    Theme Reference
  </a>
  <div id="submenuOfButton-36" class="hidden ..." ... >

*/
document.addEventListener("DOMContentLoaded", () => {
  /* Handle dropdowns */
  const items = document.querySelectorAll("[data-target-id]");
  items.forEach((item) => {
    item.addEventListener("click", () => {
      const targetId = item.getAttribute("data-target-id")!;
      if (targetId != null) {
        document.getElementById(targetId)?.classList.toggle("hidden");
      }
      item.classList.toggle("bg-blue-500/10");
    });
    item.addEventListener("blur", () => {
      const targetId = item.getAttribute("data-target-id")!;
      if (targetId != null) {
        document.getElementById(targetId)?.classList.add("hidden");
      }
      item.classList.remove("bg-blue-500/10");
    });
  });
});
