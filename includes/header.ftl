<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
<#assign docLangAttr = locale.toString()?replace("_", "-")>
<#assign langDir = "ltr">
<#if "ar.iw"?contains(docLangAttr?substring(0, 2))>
    <#assign langDir = "rtl">
</#if>
<html lang="${docLangAttr}" dir="${langDir}" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>${layoutSettings.companyName}: <#if (page.titleProperty)?has_content>${uiLabelMap[page.titleProperty]}<#else>${(page.title)!}</#if></title>
    <#if layoutSettings.shortcutIcon?has_content>
      <#assign shortcutIcon = layoutSettings.shortcutIcon/>
    <#elseif layoutSettings.VT_SHORTCUT_ICON?has_content>
      <#assign shortcutIcon = layoutSettings.VT_SHORTCUT_ICON.get(0)/>
    </#if>
    <#if shortcutIcon?has_content>
      <link rel="shortcut icon" href="<@noerpContentUrl>${StringUtil.wrapString(shortcutIcon)}</@noerpContentUrl>" />
    </#if>
	<#if layoutSettings.VT_HDR_JAVASCRIPT?has_content>
        <#list layoutSettings.VT_HDR_JAVASCRIPT as javaScript>
            <script src="<@noerpContentUrl>${StringUtil.wrapString(javaScript)}</@noerpContentUrl>" type="text/javascript"></script>
        </#list>
    </#if>
    <#if layoutSettings.javaScripts?has_content>
        <#--layoutSettings.javaScripts is a list of java scripts. -->
        <#-- use a Set to make sure each javascript is declared only once, but iterate the list to maintain the correct order -->
        <#assign javaScriptsSet = Static["org.noerp.base.util.UtilMisc"].toSet(layoutSettings.javaScripts)/>
        <#list layoutSettings.javaScripts as javaScript>
            <#if javaScriptsSet.contains(javaScript)>
                <#assign nothing = javaScriptsSet.remove(javaScript)/>
                <script src="<@noerpContentUrl>${StringUtil.wrapString(javaScript)}</@noerpContentUrl>" type="text/javascript"></script>
            </#if>
        </#list>
    </#if>
	<#if layoutSettings.VT_STYLESHEET?has_content>
        <#list layoutSettings.VT_STYLESHEET as styleSheet>
            <link rel="stylesheet" href="<@noerpContentUrl>${StringUtil.wrapString(styleSheet)}</@noerpContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.styleSheets?has_content>
        <#--layoutSettings.styleSheets is a list of style sheets. So, you can have a user-specified "main" style sheet, AND a component style sheet.-->
        <#list layoutSettings.styleSheets as styleSheet>
            <link rel="stylesheet" href="<@noerpContentUrl>${StringUtil.wrapString(styleSheet)}</@noerpContentUrl>" type="text/css"/>
        </#list>
    </#if>
	<#if !userLogin?has_content>
        <link rel="stylesheet" href="/flatgrey/css/login.css" type="text/css"/>
    </#if>
    <#if layoutSettings.rtlStyleSheets?has_content && langDir == "rtl">
        <#--layoutSettings.rtlStyleSheets is a list of rtl style sheets.-->
        <#list layoutSettings.rtlStyleSheets as styleSheet>
            <link rel="stylesheet" href="<@noerpContentUrl>${StringUtil.wrapString(styleSheet)}</@noerpContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.VT_RTL_STYLESHEET?has_content && langDir == "rtl">
        <#list layoutSettings.VT_RTL_STYLESHEET as styleSheet>
            <link rel="stylesheet" href="<@noerpContentUrl>${StringUtil.wrapString(styleSheet)}</@noerpContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.VT_EXTRA_HEAD?has_content>
        <#list layoutSettings.VT_EXTRA_HEAD as extraHead>
            ${extraHead}
        </#list>
    </#if>
    <#if lastParameters??><#assign parametersURL = "&amp;" + lastParameters></#if>
    <#if layoutSettings.WEB_ANALYTICS?has_content>
      <script language="JavaScript" type="text/javascript">
        <#list layoutSettings.WEB_ANALYTICS as webAnalyticsConfig>
          ${StringUtil.wrapString(webAnalyticsConfig.webAnalyticsCode!)}
        </#list>
      </script>
    </#if>
	<script type="text/javascript">
        var contextUrl = "${StringUtil.wrapString(request.getContextPath())}";
    </script>
</head>
<#if layoutSettings.headerImageLinkUrl??>
  <#assign logoLinkURL = "${layoutSettings.headerImageLinkUrl}">
<#else>
  <#assign logoLinkURL = "${layoutSettings.commonHeaderImageLinkUrl}">
</#if>
<#assign organizationLogoLinkURL = "${layoutSettings.organizationLogoLinkUrl!}">
<body>
  <div id="wait-spinner" style="display:none">
    <div id="wait-spinner-image"></div>
  </div>
  <div class="page-container">
  <div class="hidden">
    <a href="#column-container" title="${uiLabelMap.CommonSkipNavigation}" accesskey="2">
      ${uiLabelMap.CommonSkipNavigation}
    </a>
  </div>
  <div id="masthead">
    <ul>
      <#if layoutSettings.headerImageUrl??>
        <#assign headerImageUrl = layoutSettings.headerImageUrl>
      <#elseif layoutSettings.commonHeaderImageUrl??>
        <#assign headerImageUrl = layoutSettings.commonHeaderImageUrl>
      <#elseif layoutSettings.VT_HDR_IMAGE_URL??>
        <#assign headerImageUrl = layoutSettings.VT_HDR_IMAGE_URL.get(0)>
      </#if>
      <#if headerImageUrl??>
        <#if organizationLogoLinkURL?has_content>
            <li class="org-logo-area"><a href="<@noerpUrl>${logoLinkURL}</@noerpUrl>" title="Biological Information Management Suite"><img alt="${layoutSettings.companyName}" src="<@noerpContentUrl>${StringUtil.wrapString(organizationLogoLinkURL)}</@noerpContentUrl>"></a></li>
        <#else>
            <li class="logo-area"><a href="<@noerpUrl>${logoLinkURL}</@noerpUrl>" title="Biological Information Management Suite"><img alt="${layoutSettings.companyName}" src="<@noerpContentUrl>${StringUtil.wrapString(headerImageUrl)}</@noerpContentUrl>"/></a></li>
        </#if>
      </#if>
      <li class="preference-area">
          <ul>
          <#if userLogin??>
            <#if layoutSettings.topLines?has_content>
              <#list layoutSettings.topLines as topLine>
                <#if topLine.text??>
                  <li>${topLine.text}<a href="${StringUtil.wrapString(topLine.url!)}${StringUtil.wrapString(externalKeyParam)}">${topLine.urlText!}</a></li>
                <#elseif topLine.dropDownList??>
                  <li><#include "component://common/webcommon/includes/insertDropDown.ftl"/></li>
                <#else>
                  <li>${topLine!}</li>
                </#if>
              </#list>
            <#else>
              <li>${userLogin.userLoginId}</li>
            </#if>
			<#if layoutSettings.middleTopMessage1?has_content && layoutSettings.middleTopMessage1 != " ">
			<!--
        	<li>
		        <div class="last-system-msg">
		        	<span>${layoutSettings.middleTopHeader!}</span>
			        <a href="${layoutSettings.middleTopLink1!}">${layoutSettings.middleTopMessage1!}</a><br/>
			        <a href="${layoutSettings.middleTopLink2!}">${layoutSettings.middleTopMessage2!}</a><br/>
			        <a href="${layoutSettings.middleTopLink3!}">${layoutSettings.middleTopMessage3!}</a>
		        </div>
	        </li>
	        -->
	      </#if>
            <li><a href="<@noerpUrl>logout</@noerpUrl>">${uiLabelMap.CommonLogout}</a></li>
          <#else/>
            <li>${uiLabelMap.CommonWelcome}! <a href="<@noerpUrl>${checkLoginUrl}</@noerpUrl>">${uiLabelMap.CommonLogin}</a></li>
          </#if>
          <#---if webSiteId?? && requestAttributes._CURRENT_VIEW_?? && helpTopic??-->
          <#if parameters.componentName?? && requestAttributes._CURRENT_VIEW_?? && helpTopic??>
            <#include "component://common/webcommon/includes/helplink.ftl" />
            <li><a <#if pageAvail?has_content>class="alert"</#if> href="javascript:lookup_popup1('showHelp?helpTopic=${helpTopic}&amp;portalPageId=${parameters.portalPageId!}','help' ,500,500);">${uiLabelMap.CommonHelp}</a></li>
          </#if>
          </ul>
      </li>
    </ul>
  </div>
  <#--<br class="clear" />-->
