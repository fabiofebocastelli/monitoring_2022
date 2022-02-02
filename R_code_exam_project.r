### Corine Land Cover Accounting Layers ###

library(raster) 
library(viridis) 
library(RStoolbox) 
library(ggplot2) 
library(patchwork) 
library(rgdal) 
library(vegan)
library(mapview) 

setwd("C:/lab/clc_ al/")
clc00 <- raster("CLC2000ACC_V2018_20.tif")

clc00:
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : CLC2000ACC_V2018_20.tif 
names      : CLC2000ACC_V2018_20 
values     : 111, 999  (min, max)
attributes :
        ID  COUNT CLC_CODE              LABEL1       LABEL2                  LABEL3   R   G   B      RED GREEN     BLUE
 from: 111 777883      111 Artificial surfaces Urban fabric Continuous urban fabric 230   0  77 0.901961     0 0.301961
  to : 999  40471      999        999 (Nodata) 999 (Nodata)            999 (Nodata) 255 255 255 1.000000     1 1.000000

forest_ID <- c(311, 312, 313, 321, 322, 323, 324)
clc_forest00 <- clc00%in%forest_ID

clc_forest00:
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell) # 2.99e+09 = 2,990,000,000
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : r_tmp_2022-02-02_152455_11840_94056.grd 
names      : layer 
values     : 0, 1  (min, max)

# quanti sono i pixel in cui values=1 is True?
# prendo consigli da: https://gis.stackexchange.com/questions/422711/how-to-get-the-number-of-pixel-with-a-given-value-from-a-rasterlayer-in-r/422713#422713
freq(clc_forest00) # troppo pesante non va..
sum(values(clc_forest00), na.rm=TRUE)
# è troppo pesante, cerco di croppare ottenendo solo l'italia, decido di lavorare solo su questo pezzo di file:
# prendo consigli da:  https://gis.stackexchange.com/questions/229356/crop-a-raster-file-in-r
crop_ita00 <- as(extent(6.37, 18.31, 35.29, 47.5), 'SpatialPolygons') # estremi dell'italia 
crs(crop_ita00) <- "+proj=longlat +datum=WGS84 +no_defs"
crop_ita00forest <- crop(clc_forest00, crop_ita00)

# e mi esce:
Errore in .local(x, y, ...) : extents do not overlap  

