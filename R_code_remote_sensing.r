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
                                             
                    
## day 2 ##

setwd("C:/lab/") #setting the wd for windows..

l2011 <- brick("p224r63_2011_.grd") #assign the function to an object
l2011 #you have all the infos, you have several bands (layers). The image is called landsat (7 levels), each leyers we are recording the reflectance of each object
#how to plot every single band:

#let's plot only the green band. what's the name of the band n. 2?  B2_sre (spectral reflectance) ehich is inside the object "l2001"
plot(l2011$B2_sre) # $ is for linking. plot is the function, inside the () is the argument. Pay attention to the capital letters! 
#you get an image, but the color are meaningless so..

cl <- colorRampPalette(c("black","grey","light grey"))(100) # we can change the colours
plot(l2011$B2_sre, col=cl) # now we get the new image with the color we chose from black to light grey

# EXERCISE: change the colorRampPalette with dark green, green, and light green, e.g. clg 
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# do the same for the blue band using "dark blue", "blue", and "light blue"
# B1
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb) # in this case we use B1_sre, the band of blue wavelength

# plot both images in just one multiframe graph
# par function: can be used to set or query graphical parameters.
par(mfrow=c(1,2)) # the first number is the number of rows in the multiframe, while the second one is the number of columns
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# exercise: plot both images in just one multiframe graph with two rows and just one column
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

## DAY 3 ##

setwd("C:/lab/") 
#plot only the blue band
plot(l2011$B1_sre)
# plot the blue band using a blue colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

#let's build a multiframe (again as the past lecture)
par(mfrow=c(1,2)) #(rows, columns)

# ex.:plot the blue and the green besides, with different colorRampPalette

clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# Exercirse: put the plots one on top of the other
# invert the number of rows and the number of columns

par(mfrow=c(2,1))

# Exercise: plot the first four bands with two rows and two columns
par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) 
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow"))(100)
plot(l2011$B4_sre, col= clnir)

# clean our window with dev.off() function 
 dev.off()

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  # natural colours (this is how a human eye see the world), stretch is used to see the colours better (make the gap wider)
# we joined each band with the relative colorchannel of RGB 
# with healthy leafs there is a high reflectance of the NIR wavelenght, we can use that by 
# we need to remove one band to make room for the NIR band, for ex by switching from bands 1,2,3 to bands, 2,3,4:
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  # false colours, we have a lot of red because we put on top of the r component of thee RGB the NIR!
#also we can put the NIR in the green band:
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")  # false colours
#or in the blue component:
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")  # false colours, the yellow parts are spot's where the vegetetion has been cut down.
# N.B. in monitornig ec. the first step is to have an idea of what is the current status, the second step is the multitemporal analysis (how the status changed during time)

## DAY 4 ##

library(raster)
setwd("C:/lab/") 

l2011 <- brick("p224r63_2011.grd") 
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  #stretch for a better use of the image
#there are several way to stretch: Lin, Hist..
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist") #to enhance the differences among the 2 extremes values

l1988 <- brick("p224r63_1988.grd")  
l1998  #to see how the file is composed 

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") 

# Put the NIR in the blue channel
plotRGB(l1988, r=2, g=3, b=4, stretch="Lin")  
plotRGB(l2011, r=2, g=3, b=4, stretch="Lin") 
