# Create a GeoMapProject file for District 3 Ditch service areas
# - read the previously downloaded layer file
# - output to the dist/info-mapper folder for use by the InfoMapper
# - layer view groups are added from 1st drawn (bottom) to last drawn (top)
#
# Define properties to control processing.
# - use relative paths so that the command file is portable
# - AssetsFolder is where map files exist for the InfoMapper tool
SetProperty(PropertyName="AppFolder",PropertyType="str",PropertyValue="../../../web")
SetProperty(PropertyName="MapsFolder",PropertyType="str",PropertyValue="${AppFolder}/data-maps")
SetProperty(PropertyName="MapFolder",PropertyType="str",PropertyValue="${MapsFolder}/BasinEntities/Agriculture-Ditches")
#
# Create a single map project and map for that project.
# - GeoMapProjectID:  DitchesProject
# - GeoMapID:  DitchesMap
CreateGeoMapProject(NewGeoMapProjectID="DitchesProject",ProjectType="SingleMap",Name="District 3 Ditch Service Areas",Description="District 3 Ditch Service Areas.",Properties="author:'Open Water Foundation',specificationVersion:'1.0.0'")
CreateGeoMap(NewGeoMapID="DitchesMap",Name="District 3 Ditch Service Areas",Description="District 3 Ditch service areas from CDSS.",CRS="EPSG:4326",Properties="extentInitial:'ZoomLevel:-105.5,40.7,10'")
AddGeoMapToGeoMapProject(GeoMapProjectID="DitchesProject",GeoMapID="DitchesMap")
# = = = = = = = = = =
# Background layers:  read layers and add a layer view group
# GeoLayerViewGroupID: BackgroundGroup
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/masforce/cjs108qje09ld1fo68vh7t1he/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFzZm9yY2UiLCJhIjoiY2pzMTA0bmR5MXAwdDN5bnIwOHN4djBncCJ9.ZH4CfPR8Q41H7zSpff803g",GeoLayerID="MapBoxTopographicLayer",Name="Topographic (MapBox)",Description="Topographic background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxSatelliteLayer",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreetsLayer",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/v4/mapbox.streets-satellite/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreets&SatelliteLayer",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
AddGeoLayerViewGroupToGeoMap(GeoMapID="DitchesMap",GeoLayerViewGroupID="BackgroundGroup",Name="Background Layers",Description="Background maps from image servers.",Properties="isBackground: true, selectedInitial: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxTopographicLayer",GeoMapID="DitchesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxTopographicLayerView",Name="Topographic (MapBox)",Description="Topographic Map",Properties="selectedInitial: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxSatelliteLayer",GeoMapID="DitchesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxSatelliteLayerView",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="selectedInital: false")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreetsLayer",GeoMapID="DitchesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxStreetsLayerView",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="selectedInitial: false")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreets&SatelliteLayer",GeoMapID="DitchesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxStreets&SatelliteLayerView",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="selectedInitial: false")
# = = = = = = = = = =
# Ditch service areas
# - select the most recent for initial view
# = = = = = = = = = =
# Ditch service areas (1956):  read layer and add to a layer view group.
# - color is yellow
# GeoLayerViewGroupID: DitchServiceAreasGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/ditch-service-areas-1956.geojson",GeoLayerID="DitchServiceAreas1956Layer",Name="District 3 Ditch Service Areas",Description="Ditch service areas (1956) for District 3 from Colorado's Decision Support Systems.")
# The following layer view group is used for all years
AddGeoLayerViewGroupToGeoMap(GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",Name="District 3 Ditch Service Areas",Description="Ditch service areas for District 3 from from Colorado's Decision Support System.",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="DitchServiceAreas1956Layer",GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas1956LayerView",Name="District 3 Ditch Service Areas (1956)",Description="Ditch service areas (1956) from CDSS",InsertPosition="Top",Properties="selectedInitial:true")
SetGeoLayerViewSingleSymbol(GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas1956LayerView",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="color:#ffff00,opacity:1.0,fillColor:#ffff00,fillOpacity:0.3,weight:2")
# = = = = = = = = = =
# Ditch service areas (1976):  read layer and add to a layer view group.
# - color is orange
# GeoLayerViewGroupID: DitchServiceAreasGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/ditch-service-areas-1976.geojson",GeoLayerID="DitchServiceAreas1976Layer",Name="District 3 Ditch Service Areas (1976)",Description="Ditch service areas (1976) for District 3 from Colorado's Decision Support Systems.")
AddGeoLayerViewToGeoMap(GeoLayerID="DitchServiceAreas1976Layer",GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas1976LayerView",Name="District 3 Ditch Service Areas (1976)",Description="Ditch service areas (1976) from CDSS",InsertPosition="Top",Properties="selectedInitial:true")
SetGeoLayerViewSingleSymbol(GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas1976LayerView",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="color:#ff6600,opacity:1.0,fillColor:#ff6600,fillOpacity:0.3,weight:2")
# = = = = = = = = = =
# Ditch service areas (1987):  read layer and add to a layer view group.
# - color is cyan
# GeoLayerViewGroupID: DitchServiceAreasGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/ditch-service-areas-1987.geojson",GeoLayerID="DitchServiceAreas1987Layer",Name="District 3 Ditch Service Areas (1987)",Description="Ditch service areas (1987) for District 3 from Colorado's Decision Support Systems.")
AddGeoLayerViewToGeoMap(GeoLayerID="DitchServiceAreas1987Layer",GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas1987LayerView",Name="District 3 Ditch Service Areas (1987)",Description="Ditch service areas (1987) from CDSS",InsertPosition="Top",Properties="selectedInitial:true")
SetGeoLayerViewSingleSymbol(GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas1987LayerView",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="color:#00ffff,opacity:1.0,fillColor:#00ffff,fillOpacity:0.3,weight:2")
# = = = = = = = = = =
# Ditch service areas (2001):  read layer and add to a layer view group.
# - color is light green
# GeoLayerViewGroupID: DitchServiceAreasGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/ditch-service-areas-2001.geojson",GeoLayerID="DitchServiceAreas2001Layer",Name="District 3 Ditch Service Areas (2001)",Description="Ditch service areas (2001) for District 3 from Colorado's Decision Support Systems.")
AddGeoLayerViewToGeoMap(GeoLayerID="DitchServiceAreas2001Layer",GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas2001LayerView",Name="District 3 Ditch Service Areas (2001)",Description="Ditch service areas (2001) from CDSS",InsertPosition="Top",Properties="selectedInitial:true")
SetGeoLayerViewSingleSymbol(GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas2001LayerView",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="color:#b3ff66,opacity:1.0,fillColor:#b3ff66,fillOpacity:0.3,weight:2")
# = = = = = = = = = =
# Ditch service areas (2005):  read layer and add to a layer view group.
# - color is green
# GeoLayerViewGroupID: DitchServiceAreasGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/ditch-service-areas-2005.geojson",GeoLayerID="DitchServiceAreas2005Layer",Name="District 3 Ditch Service Areas (2005)",Description="Ditch service areas (2005) for District 3 from Colorado's Decision Support Systems.")
AddGeoLayerViewToGeoMap(GeoLayerID="DitchServiceAreas2005Layer",GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas2005LayerView",Name="District 3 Ditch Service Areas (2005)",Description="Ditch service areas (2005) from CDSS",InsertPosition="Top",Properties="selectedInitial:true")
SetGeoLayerViewSingleSymbol(GeoMapID="DitchesMap",GeoLayerViewGroupID="DitchServiceAreasGroup",GeoLayerViewID="DitchServiceAreas2005LayerView",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="color:#33cc33,opacity:1.0,fillColor:#33cc33,fillOpacity:0.3,weight:2")
# = = = = = = = = = =
# Write the map project file and copy layers to the location needed by the web application.
# - follow InfoMapper conventions
WriteGeoMapProjectToJSON(GeoMapProjectID="DitchesProject",Indent="2",OutputFile="ditches-map.json")
CreateFolder(Folder="${MapFolder}/layers",CreateParentFolders="True",IfFolderExists="Ignore")
CopyFile(SourceFile="ditches-map.json",DestinationFile="${MapFolder}/ditches-map.json")
CopyFile(SourceFile="layers/ditch-service-areas-1956.geojson",DestinationFile="${MapFolder}/layers/ditch-service-areas-1956.geojson")
CopyFile(SourceFile="layers/ditch-service-areas-1976.geojson",DestinationFile="${MapFolder}/layers/ditch-service-areas-1976.geojson")
CopyFile(SourceFile="layers/ditch-service-areas-1987.geojson",DestinationFile="${MapFolder}/layers/ditch-service-areas-1987.geojson")
CopyFile(SourceFile="layers/ditch-service-areas-2001.geojson",DestinationFile="${MapFolder}/layers/ditch-service-areas-2001.geojson")
CopyFile(SourceFile="layers/ditch-service-areas-2005.geojson",DestinationFile="${MapFolder}/layers/ditch-service-areas-2005.geojson")
# CopyFile(SourceFile="layers/ditch-service-areas-classify-croptype.csv",DestinationFile="${MapFolder}/layers/ditch-service-areas-classify-croptype.csv")