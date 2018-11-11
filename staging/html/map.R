# Create leaflet map of MOF

library(mapview)
library(sf)

mapviewOptions(basemaps = mapviewGetOption("basemaps")[c(3, 1:2, 4:5)])
m = mapview(breweries)

## create standalone .html
mapshot(m, url = "map.html")


