<%-- 
  /** << this triggers Better Comments extension

  BUG showDebug is not working as expected due to "scope-confusion", see logDebug (~line 196 in __debug.ascx)
   >> un-confusion: https://stackoverflow.com/questions/28573445/script-runat-server-vs
  
  BUG with details/on or all, the debug output shows but not the details when NOT at an allowed IP?

  TODO need a method (bool) to recognize staging/dev vs. production/live 
  TODO on older projects with old DNN versions, we may need to add add DLLs for System.Text.Json? 
       ? >>> NO, undoing that, we'll use Newtonsoft.Json since its already in DNN v8-9.12, v8.00.04 has v7.0.1
  TODO convert the Key DLLs to a List<string> in DebugSettings and loop through them to GetVersion()s
  TODO synthesise the JsonFileLocations? see notes/ideas in LoadAllowedIps() after if (loc.StartsWith("http")) {
  TODO (started) show DNN security-related settings; PB ... More Security Settings, Show Critical Errors, Debug Mode
  TODO this could be more helpful if there was an ENV or global setting showing if the site is in production (live) or not; e.g. certain settings could become warnings
  
  DONE add option to add URL that will not process or show debug output (e.g. ?details=off or /details/off)
  DONE update WebClient() to System.Net.Http.HttpClient() (async/await) for LoadAllowedIps()
  DONE with Session and Persistence, show whether or not DNN has Enable Remember on or off (Security/More)
  
  ? "DebugSettings" is poor name choice now that its functionality is fleshed out, maybe "DebugInfo" or "DebugDetails" or "DebugOutput" 
  ? Maybe this project needs an AccuName, how about AccuDetails, AccuSummary, AccuGlance, Accu??

  future/other things:
  ? clean up and remove all the old stuff and anything unused
  ? add (an option?) to show things grouped by headings in an accordion (use <details>?) and set which ones are open by default
  ? other admins/agencies might have different needs (than Accuraty), so maybe make it more configurable
  ? Re-write again as an installable extension? how to we hook to the end of the page/footer?
  
  * RE-WRITE - slow experimental/learning re-write of __debug.ascx started 20230709-0729 JRF
  ! Primary goal is to be able to drop in and use in any project with no (minimal?) changes 
  Self contained, single file, no dependencies (on AccuKit, AccuTheme, etc. Well, except Bootstrap (for now))  
  Functions used from other places: isIpSpecial(), isUrlSpecial(), GetVersion(), GetIpAddress() << at bottom of this file
  Functions new to this version: GetAuthTimeout(), GetPersistentTimeout() (both from web.config)
  Added DebugSettings static class to make it easier to update settings to match the project/site and environment
  Added loading of AllowedIps from remote or local JSON file with caching, failover, and final fallback (AllowedIpsListFallback)
  Tested and adjusted the flow of loading the JSON from locations and caching, then failover
  Add debugOutput and lots of comments that make the flow easier to follow
  Added indicator to show when login is regular or persistent 

  Also, for compatibility with older DNN sites (without CodeDom updated):
  - removed Interpolations ($"{var}") 
  - moved TryParse _out_ type to separate line ( can't do double.TryParse(mins, out double result) )
  -------------------------------------------------------------------------------^^
  * there is probably (compatibility-wise) more that we haven't encountered or thought of (yet)

  **/
--%>
