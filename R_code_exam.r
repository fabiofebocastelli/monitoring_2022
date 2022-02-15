### Corine Land Cover Accounting Layers ###

install.packages('terra', repos='https://rspatial.r-universe.dev')
install.packages('raster')
install.packages('RStoolbox')
install.packages('ggplot2')
install.packages('rgdal')
install.packages('sp')
install.packages('mapview')
install.packages('gridExtra')
install.packages('patchwork')
install.packages("rnaturalearthdata")
install.packages("devtools") 
install.packages("rnaturalearth") 
install.packages("viridis") 
install.packages("gridBase") 
install.packages("grid") 


library(raster) 
library(RStoolbox) 
library(ggplot2) 
library(rgdal) 
library(sp)
library(gridExtra)
library(patchwork)
library(rnaturalearthdata)
library(devtools)
library(rnaturalearth)
library(viridis)
library(gridBase)
library(grid)
library(mapview) 

setwd("C:/lab/clc_ al/")
clc00 <- raster("CLC2000ACC_V2018_20.tif")

clc00
# class      : RasterLayer 
# dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
# resolution : 100, 100  (x, y)
# extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
# crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
# source     : CLC2000ACC_V2018_20.tif 
# names      : CLC2000ACC_V2018_20 
# values     : 111, 999  (min, max)
# attributes :
#         ID  COUNT CLC_CODE              LABEL1       LABEL2                  LABEL3   R   G   B      RED GREEN     BLUE
#  from: 111 777883      111 Artificial surfaces Urban fabric Continuous urban fabric 230   0  77 0.901961     0 0.301961
#   to : 999  40471      999        999 (Nodata) 999 (Nodata)            999 (Nodata) 255 255 255 1.000000     1 1.000000

#  the original file is too big, let's use of crop() function to crop the study area
ext <- c(4e+06, 5200000, 1400000, 2800000)
clc00cropped <- crop(clc00, ext)

# use of %in% operator to subset data
forest_ID <- c(311, 312, 313, 321, 322, 323, 324)
clc_forest00 <- clc00cropped%in%forest_ID

clc_forest00
# class      : RasterLayer 
# dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell) # 2.99e+09 = 2,990,000,000
# resolution : 100, 100  (x, y)
# extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
# crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
# source     : r_tmp_2022-02-02_152455_11840_94056.grd 
# names      : layer 
# values     : 0, 1  (min, max)

plot(clc_forest00)
# or even better with ggplot, make use of colorblind friendly color scale!
ggplot() + geom_raster(clc_forest00, mapping = aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option="cividis") + ggtitle("forest land cover in 2000") 

# I want to know for how many pixels value=1 is TRUE in clc_forest00
# got some tips from: https://gis.stackexchange.com/questions/422711/how-to-get-the-number-of-pixel-with-a-given-value-from-a-rasterlayer-in-r/422713#422713
sum(values(clc_forest00), na.rm=TRUE): # I got "Error: cannot allocate vector of size ...Mb"
memory.limit(size=56000) # I need to increase memory available to R processes. Set the limit size to 56000 Mb
sum(values(clc_forest00), na.rm=TRUE) # sum() function doesn’t give desired output if NAs are present in the vector. so it has to be handled by using na.rm=TRUE
[1] 34635333
forest_cover00 <- sum(values(clc_forest00), na.rm=TRUE)
forest_cover00
[1] 34635333 # that's the amount of pixels corresponding to my IDs of interest in 2000! 


# now let's do the same for 2018:

clc18 <- raster("CLC2018ACC_V2018_20.tif")
clc18
# class      : RasterLayer 
# dimensions : 46000, 65000, 2.99e+09  (nrow, ncol, ncell)
# resolution : 100, 100  (x, y)
# extent     : 9e+05, 7400000, 9e+05, 5500000  (xmin, xmax, ymin, ymax)
# crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
# source     : CLC2018ACC_V2018_20.tif 
# names      : CLC2018ACC_V2018_20 
# values     : 111, 999  (min, max)
# attributes :
#         ID  COUNT CLC_CODE              LABEL1       LABEL2                  LABEL3   R   G   B      RED GREEN     BLUE
#  from: 111 791482      111 Artificial surfaces Urban fabric Continuous urban fabric 230   0  77 0.901961     0 0.301961
#   to : 999  40471      999        999 (Nodata) 999 (Nodata)            999 (Nodata) 255 255 255 1.000000     1 1.000000


# crop again:
ext <- c(4e+06, 5200000, 1400000, 2800000)
clc18cropped <- crop(clc18, ext)

# subset again:
forest_ID <- c(311, 312, 313, 321, 322, 323, 324)
clc_forest18 <- clc18cropped%in%forest_ID
clc_forest18
# class      : RasterLayer 
# dimensions : 14000, 12000, 1.68e+08  (nrow, ncol, ncell)
# resolution : 100, 100  (x, y)
# extent     : 4e+06, 5200000, 1400000, 2800000  (xmin, xmax, ymin, ymax)
# crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
# source     : r_tmp_2022-02-10_122900_9068_66440.grd 
# names      : layer 
# values     : 0, 1  (min, max)

plot(clc_forest18)
#or
ggplot() + geom_raster(clc_forest18, mapping = aes(x=x, y=y, fill=layer)) + scale_fill_viridis() + ggtitle("forest land cover in 2018")

# to get them together:
f1 <- ggplot() + geom_raster(clc_forest00, mapping = aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option="cividis") + ggtitle("forest land cover in 2000") 
f2 <- ggplot() + geom_raster(clc_forest18, mapping = aes(x=x, y=y, fill=layer)) + scale_fill_viridis() + ggtitle("forest land cover in 2018")
grid.arrange(f1, f2, ncol=2)

# how many pixels for which values=1 is True?  
forest_cover18 <- sum(values(clc_forest18), na.rm=TRUE)
[1] 34574143 # is lower than in 2018!
diff_forest_cover <- forest_cover00 - forest_cover18
[1] 61190 #  total forest cover loss of 61190 pixels (1.8 %) 
# resolution is 100 meters (https://sdi.eea.europa.eu/catalogue/srv/eng/catalog.search#/metadata/5a5f43ca-1447-4ed0-b0a6-4bd2e17e4f4d), so: 
100*61190
[1] 6119000 # sq. meters of forest cover loss. 6,2 sq. km 

# I want to get histograms:
reference_years <- c("2000", "2018")
number_of_pixels <- c(forest_cover00, forest_cover18)
forest_change <- data.frame(reference_years, number_of_pixels) # create a dataframe:
forest_change
#   reference_years forest_change
# 1            2000      34635333
# 2            2018      34574143

# histograms with ggplot:
ggplot(forest_change, aes(x=reference_years, y= number_of_pixels, color= reference_years)) + geom_bar(stat="identity", fill="white") + ggtitle ("CLCAL: 1.8 % of forest cover loss between 2000 and 2018") 

# histogroms with converted values to better notice the change:

fcsqKm00 <- 3464
fcsqKm18 <- 3457
sqKm_forest <- c(fcsqKm00, fcsqKm18)
sqKm_forest_change <- data.frame(reference_years, sqKm_forest)
ggplot(sqKm_forest_change, aes(x=reference_years, y= sqKm_forest, color= reference_years)) + geom_bar(stat="identity", fill="white") + ggtitle ("CLCAL: 1.8 % of forest cover loss between 2000 and 2018: 6.5 Km^2")

# use of grid.extra to get all the histograms in the same image
# assign the ggplots to an object

p1 <- ggplot(forest_change, aes(x=reference_years, y= number_of_pixels, color= reference_years)) + geom_bar(stat="identity", fill="white") + ggtitle ("CLCAL: 1.8 % of forest cover loss between 2000 and 2018")
p2 <- ggplot(kmforest_change, aes(x=reference_years, y= Kmqforest, color= reference_years)) + geom_bar(stat="identity", fill="white") + ggtitle ("CLCAL: 1.8 % of forest cover loss between 2000 and 2018: 6.5 Km^2")

# now, the easiest approach to assemble multiple plots on a page is to use the grid.arrange() function from the gridExtra package, so:
grid.arrange(p1, p2, nrow=1) # and you get both histograms together

# now let's get the difference between the two rasters:
fdiff = clc_forest18 - clc_forest00
fdiff
# class      : RasterLayer 
# dimensions : 16000, 12000, 1.92e+08  (nrow, ncol, ncell)
# resolution : 100, 100  (x, y)
# extent     : 4e+06, 5200000, 1200000, 2800000  (xmin, xmax, ymin, ymax)
# crs        : +proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs 
# source     : r_tmp_2022-02-04_121500_4288_88587.grd 
# names      : layer 
# values     : -1, 1  (min, max)

# plotting the difference:
cl <- colorRampPalette(c("red","white","blue"))(100)
plot(fdiff, col=cl)

# add the boundaries:
# first I need to reProject:
sldf_countries = rnaturalearth::ne_countries()
countries_sldf = spTransform(sldf_countries, projection(fdiff))

cl <- colorRampPalette(c("red","white","blue"))(100)
plot(fdiff, col=cl)
plot(countries_sldf, add=TRUE)

# let's get some stats:
table(values(fdiff))

#       -1         0         1 
#   184463 191692264    123273   # 123273 è il numero di pixels in cui è avvenuto rimboschimento: 12,3 Kmq. 1.233 ettari

mapview(fdiff) # beautiful interactive map


#############################################################################################################################################################################


# codes to export graphs in png format:

png('C:/lab/clc_ al//name_of_the_file')

# plot code

dev.off()

#############################################################################################################################################################################


                                                                                ### THE END ###


