# Create a GeoMapProject file for stream reaches for the Poudre Basin
# - read the previously downloaded layer file
# - output to the web folder for use by the InfoMapper
# - layer view groups are added from 1st drawn (bottom) to last drawn (top)
#
# Define properties to control processing.
# - use relative paths so that the command file is portable
# - AssetsFolder is where map files exist for the InfoMapper tool
SetProperty(PropertyName="AppFolder",PropertyType="str",PropertyValue="../../../web")
SetProperty(PropertyName="MapsFolder",PropertyType="str",PropertyValue="${AppFolder}/data-maps")
SetProperty(PropertyName="MapFolder",PropertyType="str",PropertyValue="${MapsFolder}/BasinEntities/Physical-StreamReaches")
#
# Create a single map project and map for that project.
# - GeoMapProjectID:  StreamReachesProject
# - GeoMapID:  StreamReachesMap
CreateGeoMapProject(NewGeoMapProjectID="StreamReachesProject",ProjectType="SingleMap",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="author:'Open Water Foundation',specificationFlavor:'',specificationVersion:'1.0.0'")
CreateGeoMap(NewGeoMapID="StreamReachesMap",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",CRS="EPSG:4326",Properties="extentInitial:'ZoomLevel:-105.5,40.7,10',docPath:stream-reaches-map.md")
AddGeoMapToGeoMapProject(GeoMapProjectID="StreamReachesProject",GeoMapID="StreamReachesMap")
# = = = = = = = = = =
# Background layers:  read layers and add a layer view group
# GeoLayerViewGroupID: BackgroundGroup
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/masforce/cjs108qje09ld1fo68vh7t1he/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFzZm9yY2UiLCJhIjoiY2pzMTA0bmR5MXAwdDN5bnIwOHN4djBncCJ9.ZH4CfPR8Q41H7zSpff803g",GeoLayerID="MapBoxTopographicLayer",Name="Topographic (MapBox)",Description="Topographic background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxSatelliteLayer",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreetsLayer",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/v4/mapbox.streets-satellite/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreets&SatelliteLayer",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
AddGeoLayerViewGroupToGeoMap(GeoMapID="StreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",Name="Background Layers",Description="Background maps from image servers.",Properties="isBackground: true, selectedInitial: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxTopographicLayer",GeoMapID="StreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxTopographicLayerView",Name="Topographic (MapBox)",Description="Topographic Map",Properties="selectedInitial: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxSatelliteLayer",GeoMapID="StreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxSatelliteLayerView",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="selectedInital: false")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreetsLayer",GeoMapID="StreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxStreetsLayerView",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="selectedInitial: false")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreets&SatelliteLayer",GeoMapID="StreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxStreets&SatelliteLayerView",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="selectedInitial: false")
# = = = = = = = = = =
# Water district 3:  read layer and add to layer view group.
# GeoLayerViewGroupID: WaterDistrictsGroup
CopyFile(SourceFile="../Administration-CoDwrWaterDistricts/layers/co-dwr-water-district-3.geojson",DestinationFile="layers/co-dwr-water-district-3.geojson")
CopyFile(SourceFile="../Administration-CoDwrWaterDistricts/layers/co-dwr-water-district-3-classify-district.csv",DestinationFile="layers/co-dwr-water-district-3-classify-district.csv")
ReadGeoLayerFromGeoJSON(InputFile="layers/co-dwr-water-district-3.geojson",GeoLayerID="WaterDistrictLayer",Name="CO DWR Water District 3",Description="Water District 3 boundary from the Colorado Division of Water Resources.")
AddGeoLayerViewGroupToGeoMap(GeoMapID="StreamReachesMap",GeoLayerViewGroupID="WaterDistrictsGroup",Name="CO DWR Water Districts",Description="Water District boundaries from the Colorado Division of Water Resources.",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="WaterDistrictLayer",GeoMapID="StreamReachesMap",GeoLayerViewGroupID="WaterDistrictsGroup",GeoLayerViewID="WaterDistrictLayerView",Name="CO DWR Water District 3",Description="Water District 3 boundary from the Colorado Division of Water Resources",InsertPosition="Top")
SetGeoLayerViewCategorizedSymbol(GeoMapID="StreamReachesMap",GeoLayerViewGroupID="WaterDistrictsGroup",GeoLayerViewID="WaterDistrictLayerView",Name="Colorize district",Description="Show Water District 3 in black.",ClassificationAttribute="DISTRICT",Properties="classificationFile:layers/co-dwr-water-district-3-classify-district.csv")
# = = = = = = = = = =
# Stream reaches:  read layer and add to a layer view group.
# GeoLayerViewGroupID: StreamReachesGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/stream-reaches.geojson",GeoLayerID="StreamReachesLayer",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches")
AddGeoLayerViewGroupToGeoMap(GeoMapID="StreamReachesMap",GeoLayerViewGroupID="StreamReachesGroup",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="StreamReachesLayer",GeoMapID="StreamReachesMap",GeoLayerViewGroupID="StreamReachesGroup",GeoLayerViewID="StreamReachesLayerView",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="docPath:layers/stream-reaches-doc/stream-reaches.md")
SetGeoLayerViewSingleSymbol(GeoMapID="StreamReachesMap",GeoLayerViewGroupID="StreamReachesGroup",GeoLayerViewID="StreamReachesLayerView",Name="Poudre Stream Reaches",Description="Poudre Stream Reaches",Properties="color:#6297f7")
# SetGeoLayerViewCategorizedSymbol(GeoMapID="StreamReachesMap",GeoLayerViewGroupID="StreamReachesGroup",GeoLayerViewID="StreamReachesLayerView",Name="Poudre Stream Reaches",Description="Show stream reaches is blue lines",ClassificationAttribute="county",Properties="classificationType:'SingleSymbol'")
# = = = = = = = = = =
# Write the map project file and copy layers to the location needed by the web application.
# - follow InfoMapper conventions
WriteGeoMapProjectToJSON(GeoMapProjectID="StreamReachesProject",Indent="2",OutputFile="stream-reaches-map.json")
CreateFolder(Folder="${MapFolder}/layers",CreateParentFolders="True",IfFolderExists="Ignore")
CopyFile(SourceFile="stream-reaches-map.json",DestinationFile="${MapFolder}/stream-reaches-map.json")
CopyFile(SourceFile="stream-reaches-map.md",DestinationFile="${MapFolder}/stream-reaches-map.md")
#
CopyFile(SourceFile="layers/co-dwr-water-district-3.geojson",DestinationFile="${MapFolder}/layers/co-dwr-water-district-3.geojson")
CopyFile(SourceFile="layers/co-dwr-water-district-3-classify-district.csv",DestinationFile="${MapFolder}/layers/co-dwr-water-district-3-classify-district.csv")
#
CopyFile(SourceFile="layers/stream-reaches.geojson",DestinationFile="${MapFolder}/layers/stream-reaches.geojson")
CreateFolder(Folder="${MapFolder}/layers/stream-reaches-doc",CreateParentFolders="True",IfFolderExists="Ignore")
CopyFile(SourceFile="layers/stream-reaches-doc/stream-reaches.md",DestinationFile="${MapFolder}/layers/stream-reaches-doc/stream-reaches.md")
