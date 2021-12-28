# R code for estimating energy in ecosystems

#https://earthobservatory.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil

# set the working directory
setwd("C:/lab/")  

# let's install a new package:
install.packages("rgdal")
library(rgdal)

# how to import data in R? create a rasterbrick: 
l1992 <- brick("defor1_.jpg") # or, if it doesn't work:
l1992 <- brick("defor1_.png") # image of 1992 imported
l1992 # and you get all the infos about the file 

# the name of the three bands are: defor1_.1, defor1_.2, defor1_.3

plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") # if you would to change colors: g=1 o b=1 (for instance)
plotRGB(l1992, r=2, g=3, b=1, stretch="Lin")

## DAY 2 ##

l1992
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") # you get the image of the situation in 1992 

# now let's import the satellite image file of the same area in 2006:
l2006 <- brick("defor2_.png")
l2006
# plot the new image:
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin") 
# let's take a look at the Rio Pixoto: the amount of debris inside the river is smaller -> is blue and not white as the 1992 pic..
# ..If it was black that'd mean it's pure water

# to get one image above the other use par function with 2 rows and one column
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin") # very usefull for graphic comparison!

# now let's calculate energy in 1992

# "dev.off" to close the plotting device
dev.off()

# the layers with the different colors reflectance (NIR, red, green) are called respectively defor1_.1, defor1_.2, defor1_.3 
# N.B. healthy plants reflect little red light and have high reflectance in the near-infrared
dvi1992 <- l1992$defor1_.1-l1992$defor1_.2 # N.B. DVI index is a measure of the difference between near-infrared light and red light reflected, healthy leaf
# differences are computed for each pair of pixels of the images
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi1992, col=cl) # and you get the image with the DVI in 1992
# red color stands for high DVI levels, yellow color stands for intermediate and low DVI levels

# calculate energy in 2006 
dev.off()
dvi2006 <- l2006$defor2_.1-l2006$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) #per scegliere i colori 
plot(dvi2006, col=cl)

#monitoriamo la situazione non solo nel momento corrente ma anche lungo il tempo
#facciamo la differenza tra i due anni presi come riferimento 1992 e 2006
dvidif <- dvi1992 - dvi2006
#associamo le differenti funzioni ad oggetti, cosi da poterli usare in analisi successive...
#scegliamo una nuova colorramppallet cld <- colorRampPalette(c('blue','white','red'))(100)
#plot the results 
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvidif, col=cld)

#final plot: original images, DVIs, final DVI difference with "par" function 
#3 row and 2 columns
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
#per farne un pdf 
pdf("energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off() #needed to close the pdf file.
