# Navigation and site features

## DDR menus

The skin includes DDR menu templates in `menus/`: `NavPrimary`, `NavSite`, `NavMobile`, and `NavCards`. Each has a `menudef.xml` and a Razor template. The header currently invokes `NavSite` and `NavPrimary` through `dnn:MENU`; it contains hard-coded `IncludeNodes` and `ExcludeNodes` values from an existing site. Replace or remove these according to the new site's DNN page IDs and navigation design.

`NavMobile` is present, but the mobile include in the current header is commented out. `NavCards` is an additional example, not necessarily active in the default layout. Test menu depth, visibility, permissions, keyboard interaction, and responsive behavior against the actual page tree. Individual menu folders contain further notes.

## Breadcrumbs and shared markup

The main layouts conditionally include `includes/breadcrumb.ascx` using `BreadCrumbsEnabled` and `BreadCrumbsOnHome` from the skin configuration. Header, logo, social links, footer, and social metadata are also implemented as includes. The default content and links need project-specific review.

## Site-level files

The `dnn/` tree includes `robots.txt`, `sitemap.xml`, `sitemap-custom.xml`, `llms.txt`, and analytics configuration examples. `README--SiteMaps.md` describes an intended sitemap-index workflow incorporating DNN's generated `SiteMap.aspx` and optionally curated or generated sitemaps. Review URLs, domains, crawler directives, and the actual files for the target site before publishing them; the README's example filename differs from the checked-in `sitemap-custom.xml`.
