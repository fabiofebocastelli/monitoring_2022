#R code for chemical cycling study
#time series of NO2 change in Europe during lockdown
#set the workinfg directory 
setwd("C:/lab/en/")
library(raster)
en01 <- raster("EN_0001.png")

#what is the range of data?

cl <- colorRampPalette(c('red','orange','yellow'))(100) #cambio colori, uso il giallo per le parti più inquinanti

# plot the NO2 calues of Jen 2020 

plot(EN01, col=cl)

#import the end of March NO2 and plot it

en13 <- raster("EN_0013.png")
plot(en13, col=cl)

#2 row 1 column. build a multiframe window of 2 rows and 1 column 
par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)

#import all the images

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


#plot all the data together 
#13 immagini quindi 4x4
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

@several layers all together uso stack and rename it
EN <- stack(EN01,EN02,EN03,EN04,EN05,EN06,EN07,EN08,EN09,EN10,EN11,EN12,EN13) #it could be also "=" instead "<-"
#plot the stack altogether
plot(EN, col=cl)

#plot only th first image from the stack
#check the stack names, devi prendere il nome originale!!!
plot(EN$EN_0001, col=cl)

# let's plot a rgb space, the function in plotRGB
plotRGB(EN, r=1, g=7, b=13, stretch="lin")     #EN è il nome che abbiamo dato allo stack

#29/11 -DAY 2-

#first of all name the list, bulding the list explaining to the softwer what are the images we want to import
#function is the list.files + the pattern
rlist <- list.files(pattern="EN")
#first remember to recall the library raster!!!
#then setwd("C:/lab/en/")
list.files(pattern="EN") #(EN is the part in common among all the images so I use it) #stiamo uscendo da R quindi ci servono le ""
#then we assign a name to the list
rlist <- list.files(pattern="EN")
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
