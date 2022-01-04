### tentativo 1 con il CORINE_LAND_COVER 


> setwd("C:/lab/clc_ al/")
> clc90 <- raster("CLC2000ACC_V2018_20.tif.ovr") 
> clc90
class      : RasterLayer 
dimensions : 23000, 32500, 747500000  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 32500, 0, 23000  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : CLC2000ACC_V2018_20.tif.ovr 
names      : CLC2000ACC_V2018_20.tif 
values     : -32768, 32767  (min, max)

> plot(clc90)
> 
> plot(clc90)
> plot(clc90, xlim=c(15000, 2200), ylim=c(2500,10000)
+ )
Errore in .plotraster2(x, col = col, maxpixels = maxpixels, add = add,  : 
  invalid xlim
> plot(clc90, xlim=c(15000, 22000), ylim=c(2500,10000))
> plot(clc90, xlim=c(15000, 21000), ylim=c(2500,9000))
> plot(clc90, xlim=c(17000, 19000), ylim=c(5000,7000))
> plot(clc90, xlim=c(18000, 18500), ylim=c(6000,6500))
> plot(clc90, xlim=c(18200, 18500), ylim=c(6100,6400))
> plot(clc90, xlim=c(15000, 22000), ylim=c(2500,10000))
> plot(clc90, xlim=c(18200, 18500), ylim=c(6100,6400))
> plot(clc90, xlim=c(15000, 22000), ylim=c(2500,10000))
> clc00 <- raster("CLC2000ACC_V2018_20.tif.ovr")
> clc00
class      : RasterLayer 
dimensions : 23000, 32500, 747500000  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 32500, 0, 23000  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : CLC2000ACC_V2018_20.tif.ovr 
names      : CLC2000ACC_V2018_20.tif 
values     : -32768, 32767  (min, max)

> plot(clc00)
> plot(clc00, xlim=c(15000, 22000), ylim=c(2500,10000))
> nial <- clc00 == 211
> plot(nial)
> forest_cover00 <- clc == 311 + 312 + 313 + 321 + 322 + 323 + 324
Errore: oggetto 'clc' non trovato
> forest_cover00 <- clc00 == 311 + 312 + 313 + 321 + 322 + 323 + 324
> plot(forest_cover00)
> forest_cover00 <- clc00 == 312
> plot(forest_cover00)


> clc = raster("./CLC2000ACC_V2018_20.tif"
+ )
> clcl
Errore: oggetto 'clcl' non trovato
> clc
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : CLC2000ACC_V2018_20.tif 
names      : CLC2000ACC_V2018_20 
values     : -32768, 32767  (min, max)

> clc <- raster("CLC2018ACC_V2018_20.tif")
> clc
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : CLC2018ACC_V2018_20.tif 
names      : CLC2018ACC_V2018_20 
values     : -32768, 32767  (min, max)

> clc00 <- raster(""CLC2000ACC_V2018_20.tif)

> 

> clc00 <- raster("CLC2000ACC_V2018_20.tif")
> clc00
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : CLC2000ACC_V2018_20.tif 
names      : CLC2000ACC_V2018_20 
values     : -32768, 32767  (min, max)

> clc00 <- raster("CLC2000ACC_V2018_20.tif")
> clc00
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

> plot(clc00)
> forest_cover00 <- clc00 == 312

