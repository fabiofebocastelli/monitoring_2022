# R code for species distribution modelling, namely the distribution of individuals in a certain area

install.packages("sdm") # sdm= species distribution modelling
library(sdm)
library(rgdal) # for the species (when we have points and not layers)
library(raster)

file <- system.file("external/species.shp", package="sdm") # shp extention is called shape file. "external/species.shp" is the name of file we want to use 
file # and you get [1] "C:/Users/fabio/Desktop/programmini/R-4.1.2/library/sdm/external/species.shp" (you have the path in which you have the data)
# you can use it to find a certain file quickly by copypasting it in the windows folder bar.

# now let's plot the species data:

species <- shapefile(file) # exactly as the raster function for raster files!
species

plot(species, pch=19, col="red") #pch is the kind of "point" you want to see
# you get all the species points scattered in an area
