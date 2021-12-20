# Ice melt in Greenland
# proxy: LST
setwd("C:/lab/greenland")

# reupload the data inside R:
# list f files:
rlist <- list.files(pattern="lst") #the pattern is the common part of the names
rlist
library(raster)
import <- lapply(rlist,raster) #the files are single layers so we can use raster function
import
tgr <- stack(import) #TGr= temperature of greenland
tgr
plot(tgr)

library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)

# ggplot of first and dinale images 2000 vs 2015:
ggplot() + 
geom_raster(tgr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) + 
scale_fill_viridis(option="magma") +
ggtitle("LST in 2000")

ggplot() +
geom_raster(tgr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")

#now let's plot them together:

p1 <- ggplot() + 
geom_raster(tgr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) + 
scale_fill_viridis(option="magma") +
ggtitle("LST in 2000")

p2 <- ggplot() +
geom_raster(tgr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")

p1/p2
#or
p1 + p2

#plotting freq. distributions:
hist(tgr$lst_2000)
hist(tgr$lst_2015)
#then 2 plot together: 
par(mfrow=c(1,2))
hist(tgr$lst_2000)
hist(tgr$lst_2015)

#then altogether:
par(mfrow=c(2,2))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)

# plotting two values on a piano cartesiano in order to have the values and a curve: abline function (N.B. Y= mX + c)
dev.off()
plot(tgr$lst_2010, tgr$lst_2015)
abline(0,1,col="red")
# to see the red line, change the values..
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")

# make a plot with all the histogram and all the regressions for all the values: use of pairs function
pairs(tgr)


