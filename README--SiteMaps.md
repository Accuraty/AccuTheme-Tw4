# Better SiteMaps - New Default Setup and Optional Long-Term Curation

Both last 10+ years of Google's search-crawler indexing changes AND the rise of A.I. aggressively crawling for data 2023-25+ 
have lead us to needing a better initial set up as well as providing the ability for a site's manager to TLC there way to 
better SEO, SERP, and AEO/GEO when needed.
 
## See the GitHub Issue [#75](https://github.com/Accuraty/AccuTheme-Tw4/issues/75) for the initial details and examples.
  
In brief, DNN automatically provides /SiteMap.aspx. Its delivered with the XML MIME Type and works well enough, though 
less so moving forward. AccuTheme now includes `dnn/sitemap.xml` which is a `<sitemapindex>` and contains pointers to 
additional sitemap files. The first entry in the list is always the DNN generated `/SiteMap.aspx`.
 
Important: when registering the (new) site in GSC, the intention is to now provide the sitemap index, so in GSC you would 
add `clientdomain.com/sitemap.xml`, NOT the DNN generated .aspx version!

### This Paves the Way for Two Options

In the VS Code managed project (AccuTheme-Tw4), usually ABBV2026-Tw4, 

1. Manually TLC/Curate a `dnn/site-custom.xml` to handle any (landing) pages or URLs that are not properly exposed 
by DNN in the default generated SiteMap.aspx. Don't forget to ensure its in the sitemap index!
 
2. Hook up Generated sitemaps! Add `sitemap-generated.xml` to the index. As a possible example, imagine adding a feature 
to either EasyDNNnews module or 2sxc News app where you generate and enhance/perfect sitemap pages list from the actual 
articles and meta data.
 
From controlling the <lastmod> dates to carefully curating your URLs in association with your Canonicals, you now have 
the tools in place to do a good, better, or best job based on your efforts.

### Don't forget about SiteMap Extensions

Sitemap Extensions (like [News Sitemaps](https://developers.google.com/search/docs/crawling-indexing/sitemaps/news-sitemap)) are a great way to tell Google about the different kinds of content and their metadata that you're using on your site. There are definitions for News, Image, and Video sitemaps 
and they can be combined.
