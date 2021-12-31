### tentativo 1 con il CORINE_LAND_COVER cha 

setwd("C:/lab/CORINE_LAND_COVER/")

rlist <- list.files(pattern="cha") # the pattern is the common part of the names of the files we want to work with
rlist
library(raster)
import <- lapply(rlist,raster) 
import
corine <- stack(import) 
corine
plot(corine) 

library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)

p1 <- ggplot() + 
geom_raster(corine$corine_cha_1990, mapping = aes(x=x, y=y, fill=corine_cha_1990)) + 
scale_fill_viridis(option="magma") +
ggtitle("corine in 1990")

p2 <- ggplot() +
geom_raster(corine$corine_cha_2018, mapping = aes(x=x, y=y, fill=corine_cha_2018)) +
scale_fill_viridis(option="magma") +
ggtitle("corine in 2018")
p1/p2


### tentativo 2 con il fcover 1 Km

library(raster)
setwd("C:/lab/fcover1km/")
rlist <- list.files(pattern="FCOVER") # "defor" is the common part of the two files we want to take from lab folder
rlist
listrast <- lapply(rlist, brick) # listrast is a name, you can choose any other if you like
listrast
plot(listrast[[1]]) 



### tentativo 3 con il dvi 1 Km

library(raster)
setwd("C:/lab/NDVI/")
rlist <- list.files(pattern="h5") 
rlist
listrast <- lapply(rlist, brick) # listrast is a name, you can choose any other if you like






