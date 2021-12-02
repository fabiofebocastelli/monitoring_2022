# R code for remote sensing data analysis in ecosystem monitoring

library(raster)
library(RStoolbox)

# no library?
# install.packages(c("raster","RStoolbox"))

#how to make R know where the data we want to import is.. set the working directory!
setwd("C:/lab/")  

#use brick function which is part of the raster package.. to import satallite image data

l2011 <- brick("p224r63_2011_masked.grd") #rename it (object in R can't be numbers!)

l2011 # I have a lot of infos about several layers (rasters) altogether..7 layers with more than 4 million pixels each (every pixel is 4x4 meters)

plot(l2011)

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band

cl <- colorRampPalette(c('black','grey','light grey'))(100) # 100 means how many tones you have of every colour you use (es. from black to grey)
plot(l2011, col=cl) # all of the object which are absorbing blue, green or red (depending on wich band we are checking) are in black and those that are reflecting..
                    # .. those wavelight is in lightgrey

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") # we have 3 channels: red, green and blue that we match with the 3 bands 
                                             
                    


par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)

# Exercise: plot the final band, namely the NIR, band number 4
# red, orange, yellow
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=clnir)

# dev.off()
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#

par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
