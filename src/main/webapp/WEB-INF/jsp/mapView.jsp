<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

--%>

<!-- required includes -->
<jsp:directive.include file="/WEB-INF/jsp/include.jsp"/>
<portlet:defineObjects/>

<c:set var="n"><portlet:namespace/></c:set>
<c:set var="apiUrl">${ portalProtocol }://maps.google.com/maps/api/js?sensor=true</c:set>
<c:if test="${ not empty apiKey }">
    <c:set var="apiUrl">${ apiUrl }&amp;key=${ apiKey }</c:set>
</c:if>
<script src="${apiUrl}"></script>
<c:set var="usePortalJsLibs" value="${ false }"/>
<rs:aggregatedResources path="${ usePortalJsLibs ? '/skin-shared.xml' : '/skin.xml' }"/>

<script type="text/javascript"><rs:compressJs>
    var ${n} = ${n} || {};
    <c:choose>
        <c:when test="${!usePortalJsLibs}">
            ${n}.jQuery = jQuery.noConflict(true);
            ${n}.fluid = fluid;
            fluid = null; 
            fluid_1_4 = null;
        </c:when>
        <c:otherwise>
            <c:set var="ns"><c:if test="${ not empty portalJsNamespace }">${ portalJsNamespace }.</c:if></c:set>
            ${n}.jQuery = ${ ns }jQuery;
            ${n}.fluid = ${ ns }fluid;
        </c:otherwise>
    </c:choose>
    if (!map.initialized) map.init(${n}.jQuery, ${n}.fluid, google);
    ${n}.map = map;

    ${n}.jQuery(document).ready(function () { 

        var $ = ${n}.jQuery;
        
        mapOptions = {
            zoom: ${ zoom },
            mapTypeControl: ${ mapTypeControl },
            mapTypeControlOptions: {
                style: google.maps.MapTypeControlStyle.DEFAULT
            },
            panControl: ${ panControl },
            zoomControl: ${ zoomControl },
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.SMALL
            },
            scaleControl: ${ scaleControl },
            streetViewControl: ${ streetView },
            rotateControl: ${ rotateControl },
            overviewMapControl: ${ overviewControl },
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        map.CampusMap($("#${n}map"), {
            defaultCoordinates: { latitude: ${ latitude }, longitude: ${ longitude } },
            location: '${ location }',
            mapOptions: mapOptions,
            mapDataUrl: '<portlet:resourceURL/>'
        });
    });

</rs:compressJs></script>

<div id="${n}map" class="portlet"> 

    <div class="map-search-form">
        <div data-role="header" class="titlebar portlet-titlebar">
            <a data-role="button" data-icon="back" data-inline="true" class="map-browse-link" id="${n}gridViewLink" href="javascript:;">Browse</a>
            <h2>Search</h2>
        </div>
        <div class="portlet-content" data-role="content">
            <input class="map-search-input" autocomplete="off" type="text" size="10" name="search" title="search"/>
        </div>
    </div>
    
    <div class="map-search-results" style="display:none">
        <div class="portlet-content" data-role="content">
            <ul data-role="listview">
                <li class="map-search-result">
                    <a href="javascript:;" class="map-search-result-link"></a>
                </li>
            </ul>
        </div>
    </div>
    
    <div class="map-categories" style="display:none">
        <div data-role="header" class="titlebar portlet-titlebar">
            <a data-role="button" data-icon="back" data-inline="true" class="map-search-link" id="${n}gridViewLink" href="javascript:;">Search</a>
            <h2>Browse</h2>
        </div>
    
        <div class="portlet">
            <div class="portlet-content" data-role="content">
                <ul>
                    <li class="map-category">
                        <a href="javascript:;" class="map-category-link">Category Name</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="map-category-detail" style="display:none">
        
        <div data-role="header" class="titlebar portlet-titlebar search-back-div">
            <a data-role="button"  data-icon="back" data-inline="true" class="map-category-back-link" href="javascript:;">Back</a>
            <h2 class="map-location-name">Location</h2>
        </div>
    
        <div class="portlet">
            <div class="portlet-content" data-role="content">
                <h3 class="map-category-name"></h3>
                <ul>
                    <li class="map-location">
                        <a href="javascript:;" class="map-location-link">Location Name</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="map-location-detail portlet" style="display:none">
    
        <div data-role="header" class="titlebar portlet-titlebar search-back-div">
            <a data-role="button"  data-icon="back" data-inline="true" class="map-location-back-link" href="javascript:;">Back</a>
            <h2 class="map-location-name">Location</h2>
        </div>

        <div class="portlet">        
            <div class="portlet-content" data-role="content">
                <h3 class="map-location-name"></h3>
                <p class="map-location-description"></p>
                <p class="map-location-address"></p>
                <p><a class="map-location-directions-link" href="javascript:;">Get Directions</a>
                <p><a class="map-location-map-link" href="javascript:;">View in Map</a>
                <p><img class="map-location-image"/></p>
            </div>
        </div>
    </div>

    <div class="map-container">
        <div class="portlet-content" data-role="content">
            <div class="map-display" style="width: 100%; height: 500px;"></div>
        </div>
    </div>    
    
</div> 
