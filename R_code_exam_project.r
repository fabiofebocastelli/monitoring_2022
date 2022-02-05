### Corine Land Cover Accounting Layers ###

install.packages('terra', repos='https://rspatial.r-universe.dev')
install.packages('raster')
install.packages('RStoolbox')
install.packages('ggplot2')
install.packages('rgdal')
install.packages('sp')
install.packages('mapview')

library(raster) 
library(RStoolbox) 
library(ggplot2) 
library(rgdal) 
library(sp)
# interessante : library(mapview) 

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

#  uso crop function per diminuire l'area di studio alla sola Italia:
ext <- c(4e+06, 5200000, 1200000, 2800000)
clc00cropped <- crop(clc00, ext)

forest_ID <- c(311, 312, 313, 321, 322, 323, 324)
clc_forest00 <- clc00cropped%in%forest_ID

clc_forest00:
class      : RasterLayer 
dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell) # 2.99e+09 = 2,990,000,000
resolution : 100, 100  (x, y)
extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : r_tmp_2022-02-02_152455_11840_94056.grd 
names      : layer 
values     : 0, 1  (min, max)

plot(clc_forest00)
# quanti sono i pixel in cui values=1 is True?
# prendo consigli da: https://gis.stackexchange.com/questions/422711/how-to-get-the-number-of-pixel-with-a-given-value-from-a-rasterlayer-in-r/422713#422713
sum(values(clc_forest00), na.rm=TRUE):
[1] 34635333
forest_cover00 <- sum(values(clc_forest00), na.rm=TRUE)
forest_cover00
[1] 34635333 # ho trovato il numero dei pixel corrispondenti ai miei ID di interesse nel 2000!!!

# ORA FACCIO LO STESSO CON IL 2018:

clc18 <- raster("CLC2018ACC_V2018_20.tif")
#  uso crop function per diminuire l'area di studio alla sola Italia:
ext <- c(4e+06, 5200000, 1200000, 2800000)
clc18cropped <- crop(clc18, ext)
forest_ID <- c(311, 312, 313, 321, 322, 323, 324)
clc_forest18 <- clc18cropped%in%forest_ID
plot(clc_forest18)
# quanti sono i pixel in cui values=1 is True?
# prendo consigli da: https://gis.stackexchange.com/questions/422711/how-to-get-the-number-of-pixel-with-a-given-value-from-a-rasterlayer-in-r/422713#422713
forest_cover18 <- sum(values(clc_forest18), na.rm=TRUE)
[1] 34574143 # è minore del 2018
diff_forest_cover <- forest_cover00 - forest_cover18
[1] 61190 # c'è stata una diminuzione della copertura forestale complessiva di 61190 pixel, ovvero del 1.8 % 
# la risoluzione è di 100 m (https://sdi.eea.europa.eu/catalogue/srv/eng/catalog.search#/metadata/5a5f43ca-1447-4ed0-b0a6-4bd2e17e4f4d)
10000*61190
[1] 6119000 # sono i mq complessivbi persi di superfice boschiva. 6,2 kmq (il centro di bologna è 4,5 kmq), 612 ettari

# cerco di ottenere un grafico con gli istogrammi 
reference_years <- c("2000", "2018")
number_of_pixels <- c(forest_cover00, forest_cover18)
forest_change <- data.frame(reference_years, number_of_pixels) # creo un dataframe:
forest_cover_change
  reference_years forest_change
1            2000      34635333
2            2018      34574143

# ottengo gli istogrammi dei due anni:
ggplot(forest_change, aes(x=reference_years, y= number_of_pixels, color= reference_years)) + geom_bar(stat="identity", fill="white") 
+ ggtitle ("Corine Land Cover Accounting Layers: 1.8 % of forest cover reduction between 2000 and 2018") 

# 2 nuovi istogrammi con i kmq per apprezzare meglio il cambiamento :

fckmq00 <- 3464
fckmq18 <- 3457
Kmqforest <- c(fckmq00, fckmq18)
kmforest_change <- data.frame(reference_years, Kmqforest)
ggplot(kmforest_change, aes(x=reference_years, y= Kmqforest, color= reference_years)) + geom_bar(stat="identity", fill="white") + ggtitle ("CLC Accounting Layers: 1.8 % of forest cover reduction between 2000 and 2018: 6.5 Km^2")


fdiff = clc_forest18 - clc_forest00
fdiff
class      : RasterLayer 
dimensions : 16000, 12000, 1.92e+08  (nrow, ncol, ncell)
resolution : 100, 100  (x, y)
extent     : 4e+06, 5200000, 1200000, 2800000  (xmin, xmax, ymin, ymax)
crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
source     : r_tmp_2022-02-04_121500_4288_88587.grd 
names      : layer 
values     : -1, 1  (min, max)



table(values(fdiff))

       -1         0         1 
   184463 191692264    123273   # 123273 è il numero di pixels in cui è avvenuto rimboschimento: 12,3 Kmq. 1.233 ettari


# metto i due grafici insieme con par function 

par(mfrow=c(1,2))
plot(clc_forest00)
plot(clc_forest18)

# faccio plot della differenza 
plot(fdiff)

# suddivido l'immagine in 3 sottoimmagini per aumentare la risoluzione
ext <- c(4e+06, 5200000, 2250000, 2800000)
fdiff_north <- crop(fdiff, ext)
cl <- colorRampPalette(c("red","white","blue"))(100)
plot(fdiff_north, col=cl)
summary(fdiff_north)
 layer
Min.       -1
1st Qu.     0
Median      0
3rd Qu.     0
Max.        1
NA's        0



# provo ad importare limmagine con i confine dell europa:
eu_coastline <- raster("Europe_coastline.shp") # non va
eu_coastline <- raster("Europe_coastline_poly.shp")
eu_coastline <- raster("HYP_50M_SR_W.tif")
#non riesco a caricare questi file 


### TENTATIVI RANDOM ###

plotRGB(fdiff, r=3, g=2, b=1, stretch="Lin") # non si può usare

#provo a mettere la coastline:
install.packages("rnaturalearthdata")
library("rnaturalearthdata")
install.packages("devtools") 
devtools::install_github("ropensci/rnaturalearthhires")
library("rnaturalearthhires")

 #funzione trovata su internet:
if (requireNamespace("rnaturalearthdata")) {
sldf_coast <- ne_coastline()
if (require(sp)) {
plot(sldf_coast)}}

# capisco che c'è bisogno di una Raster reProjection:

# Download global coastlines
download.file("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_coastline.zip",destfile = 'coastlines.zip')
# Unzip the downloaded file
unzip(zipfile = "coastlines.zip",exdir = 'ne-coastlines-10m')
# Load global coastline shapefile 
coastlines= readOGR("ne-coastlines-10m/ne_10m_coastline.shp",verbose = FALSE)
cl <- colorRampPalette(c("red","white","blue"))(100)
plot(fdiff_north, col=cl)
plot(coastlines, add=TRUE)      # non si aggiunge la coastline, probabilmente per crs non uguali, allora probabilmente prima devo fare il reproject:

crs(coastlines): +proj=longlat +datum=WGS84 +no_defs 
rfdiff_north <- projectRaster(fdiff_north, crs = crs(coastlines)) # ma mi da: Errore: non è possibile allocare un vettore di dimensione 4.6 Gb
# e se facessi il contrario?
rcoastlines <- projectRaster(coastlines, crs = crs(fdiff_north))

# tentativi vari:

rfdiff_north <- projectRaster(fdiff_north, crs=+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0))

sr <- "+proj=longlat +datum=WGS84 +no_defs " 
rfdiff_north <- projectRaster(fdiff_north, crs = sr)


#nuovo tentativo: 
rfdiff_north = spTransform(fdiff_north, projection(coastlines))
plot(rfdiff_north) # mi da la coastline del mondo e basta

