# R code for chemical cycling study

# time series of NO2 change in Europe during lockdown
# set the new working directory:
setwd("C:/lab/en/")
library(raster)
en01 <- raster("EN_0001.png") # raster function is used to create a RasterLayer object, that is to "take" and create just a single layer and not all of them as..
                              # ..with the brick function

# what is the range of data? it is 0-255 as there are 256 sequencies of bit

cl <- colorRampPalette(c('red','orange','yellow'))(100) # choose yellow color for the most relevant parts!

# plot the NO2 values of Jenuary 2020 
plot(EN01, col=cl)

# EXERCISE: import the end of March NO2 and plot it

en13 <- raster("EN_0013.png")
plot(en13, col=cl)

# build a multiframe window with 2 rows and 1 column with the par function
par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)

# import all the images

EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")


# plot all the data together 
# we have 13 images therefore we need a 4x4 mfrow
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)

# nice! but how to do if you don't want to plot each image singularly?
# to plot several layers altogether use stack function and rename it:
EN <- stack(EN01,EN02,EN03,EN04,EN05,EN06,EN07,EN08,EN09,EN10,EN11,EN12,EN13) # N.B. it could be also "=" instead "<-"
# plot the stack altogether
plot(EN, col=cl) # the output is the same as before but the process was way faster!

# plot only the first image from the stack
# check the stack names, you must use the original name!!!
plot(EN$EN_0001, col=cl)

# let's plot a rgb space, the function in plotRGB
plotRGB(EN, r=1, g=7, b=13, stretch="lin") # EN is the name we assigned to the stack
# you get an image with red, green and blue colors only

## DAY 2 ##

# importing all the data together with the lapply function

# remember to recall the library raster!
library(raster)
# then set the wd
setwd("C:/lab/en/")

# first, set the list up explaining to the softwer what are the images we want to import
# the function is list.files + the pattern
list.files(pattern="EN") # EN is the part in common between all the images so I use it. N.B. we are leaving R so we need to use ""
# then we assign a name to the list:
rlist <- list.files(pattern="EN")
rlist # the output is the list of all the files with "EN" in their names in the "en" folder 

#lapply(X, FUN, …) x is the list and FUN is the fucntion we want to apply to the list (these are the arguments!)
list_rast <- lapply(rlist, raster) #list_rast is a random name we choose
list_rast 
#poi uniamo tutti i file con STACK function
ENstack <- stack(list_rast)
cl <- colorRampPalette(c('red','orange','yellow'))(100) # before plotting chose a set of colors
plot(ENstack, col=cl)
#se vogliamo plottare solo la prima immagine
plot(ENstack$EN_0001, col=cl)
# to make the difference
ENdif <- ENstack$EN_0001 - ENstack$EN_0013
cldif <- colorRampPalette(c('blue','white','red'))(100) # 
plot(ENdif, col=cldif)
#how to use code without copypaste it to speed up the work...use the sourse function
#creo uno script in un file word poi lo salvo nella cartella en in lab #source function 
source("script_R")
