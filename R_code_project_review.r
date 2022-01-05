setwd("C:/lab/clc_ al/") # Corine land cover Accounting Layers folder

# per sicurezza li carico tutti:
library(raster) 
library(viridis) 
library(RStoolbox) 
library(ggplot2) 
library(patchwork) 
library(rgdal) 
library(vegan)
library(mapview) 

#importo il file raster per l'anno 2000:

clc00 <- raster("CLC2000ACC_V2018_20.tif")
clc00 # e ti ritorna:
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
  
# faccio lo stesso per l'anno 2018:
clc18 <- raster("CLC2018ACC_V2018_20.tif")
clc18

class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : aaaCLC2018ACC_V2018_20.tif 
names      : aaaCLC2018ACC_V2018_20 
values     : 111, 999  (min, max)
attributes :
        ID  COUNT CLC_CODE              LABEL1       LABEL2                  LABEL3   R   G   B      RED GREEN     BLUE
 from: 111 791482      111 Artificial surfaces Urban fabric Continuous urban fabric 230   0  77 0.901961     0 0.301961
  to : 999  40471      999        999 (Nodata) 999 (Nodata)            999 (Nodata) 255 255 255 1.000000     1 1.000000


# non ho ancora le idee molto chiare su come fare ma l'intento è quello di estrapolare sia quantitativamente che graficamente la differenza relativa a diversi
# tipi di land cover legati all'abbandono dei campi coltivati (questo il link con i codici:
# https://image.discomap.eea.europa.eu/arcgis/rest/services/Corine/CLC1990_WM/MapServer/legend), così da estrarre le zone dove c'è stato un aumento.

# volevo procedere con una cosa tipo quella fatta alla lezione sul Ice melting in Greenland, Time series analysis, Greenland increase of temperature..
# quindi una cosa tipo: 

rlist <- list.files(pattern="lst") 
rlist
import <- lapply(rlist,raster) #
import 
tgr <- stack(import) 
tgr 
plot(tgr) 

# e qui arriva il mio problema, quando vado a fare il list.files() e cerco un pattern non riesco a trovare cosa mettere tra le virgolette
# perchè qualsiasi cosa metto mi ritorna o che non è possibile aprirlo o un altro tipo di file, ad esempio, se modifico il nome di quelli che sembrano
# essere i 2 file da importare [le due immagini TIFF con nome CLC2000ACC_V2018_20.tif e CLC2018ACC_V2018_20.tif (i nomi li ho presi dalle proprietà dei file 
# perchè questi nomi sarebbero anche quelli dei due file XML da 1 Kb)] : 
rlist <- list.files(pattern="abc") 
rlist
# [1] "abcCLC2000ACC_V2018_20.tif" "abcCLC2018ACC_V2018_20.tif"
import <- lapply(rlist,raster)
import

[[1]]
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : abcCLC2000ACC_V2018_20.tif 
names      : abcCLC2000ACC_V2018_20 
values     : -32768, 32767  (min, max)


[[2]]
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : abcCLC2018ACC_V2018_20.tif 
names      : abcCLC2018ACC_V2018_20 
values     : -32768, 32767  (min, max)

# vedi che i files sono diversi!? ad esempio il range dei values non è più tra 111 e 999 !! 
# non so perchè ma questo succede anche quando importo il singolo file .tif con raster() quando non è nella stessa cartella del file tif-aux da 19 Kb.
# è come se questi due dovessero stare nella stessa cartella.. ma allora se provo a rinominare tutti e 4 i fale .tif e .tif.aux in modo da avere un pattern comune:
rlist <- list.files(pattern="aaa") 
rlist
[1] "aaaCLC2000ACC_V2018_20.tif"         "aaaCLC2000ACC_V2018_20.tif.aux.xml" "aaaCLC2018ACC_V2018_20.tif"         "aaaCLC2018ACC_V2018_20.tif.aux.xml"
import <- lapply(rlist,raster)
# mi ritorna : Error in .local(.Object, ...) : 

Errore in .rasterObjectFromFile(x, band = band, objecttype = "RasterLayer",  : 
  Cannot create a RasterLayer object from this file.

import

[[1]]
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : abcCLC2000ACC_V2018_20.tif 
names      : abcCLC2000ACC_V2018_20 
values     : -32768, 32767  (min, max)


[[2]]
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : abcCLC2018ACC_V2018_20.tif 
names      : abcCLC2018ACC_V2018_20 
values     : -32768, 32767  (min, max)

# e ho ancora i file strani! Qualche idea sul perchè?
