# R code for uploading and visualizing Coprnicus data in R
install.packages("ncdf4")
library(ncdf4)

# Set the working directory. As we created a new folder for the new file downloaded from copernicus, the code is different:
setwd("C:/lab/copernicus/")
#now we can upload our data, it's a single layer so the raster function can be used:
library(raster)
NDVI20210110 <- raster("c_gls_NDVI300_202101010000_GLOBE_PROBAV_V1.0.1(2).nc") # Put inside the quotation marks the name of the file downloaded from Copernicus
NDVI20210110 #the number of pixels is huge: in my case is 5.689.958.400 
plot(NDVI20210110)

## DAY2 ##

# we continue from where we left..

cl <- colorRampPalette(c('dark blue', 'blue', 'light blue'))(100)
plot(NDVI20210110, col=cl)
#remember to use the colors that can be distinguished by colorblind people too. For example viridis palette is colorblind friendly :)
#in order to change colors: 
install.packages("viridis")
library(viridis)
library(RStoolbox)
library(ggplot2)

#let's make a ggplot
ggplot() + geom_raster(NDVI20210110, mapping= aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.333M))     #geom_raster is for chosing the geometry
                                                                                                                   # fill= nome del file
#to see how may layers are inside a "nc" object you can use brick function

# ggplot with viridis:
ggplot() + geom_raster(NDVI20210110, mapping= aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.333M)) + scale_fill_viridis(option="cividis") #cividis is the legend we choose
ggplot() + geom_raster(NDVI20210110, mapping= aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.333M)) + scale_fill_viridis(option="cividis") + 
ggtitle("cividis palette")

## DAY 3 ##

# importing all the data together with the lapply function. 3 steps: 1-list the files 2- apply the raster function to the list 3- make a stack:
rlist <- list.files(pattern="c_gls_NDVI300")
rlist
list_rast <- lapply(rlist, raster)
NDVIstack <- stack(list_rast)
NDVIstack

NDVI2020 <- NDVIstack$Normalized.Difference.Vegetation.Index.333M.1
NDVI2021 <- NDVIstack$Normalized.Difference.Vegetation.Index.333M.2

#in this case it's not that usefull to stack and than unstack the files.. in fact it's just an exemples to let us know what to do in case of several files!


