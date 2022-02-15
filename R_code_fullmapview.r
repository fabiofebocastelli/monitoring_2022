setwd("C:/lab/clc_ al/")
clc00 <- raster("CLC2000ACC_V2018_20.tif")
clc18 <- raster("CLC2018ACC_V2018_20.tif")

forest_ID <- c(311, 312, 313, 321, 322, 323, 324)

clc_f00 <- clc00%in%forest_ID
clc_f18 <- clc18%in%forest_ID
nfdiff = clc_f18 - clc_f00
mapview(nfdiff)

