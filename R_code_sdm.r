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

## 10/01 LESSON ##

library(sdm)
library(raster) # predictors
library(rgdal) # species: an array of x,y points x0,y0, x1y1 (coordinates) to xn,yn

# species data
file <- system.file("external/species.shp", package="sdm")
file # and you get the path to wich you ar pointing at
     # we are going to use a shape file
species <- shapefile(file) # exatcly as the raster function for raster files
species # each row of the table is a point
species$Occurrence # and you get presence/absence data for each point
# if you want to count the number of the presences? a.k.a. how many occurrences are there? we need to Subset a DataFrame:
presences <- species[species$Occurrence == 1,] # controlo simbol is , (to stop the query)
presences # and you get all the infos on occurrencies 
absences <- species[species$Occurrence == 0,]
abences
# now let's plot these data:
plot(species, pch=19) # pch code stands for the symbol type in the plot
# plot only the occurrencies
plot(presences, pch=19, col="blue")
# in order to have also the absences data in the same plot, use points function:
points(absences, pch=19, col="red") # and you get the dots of the 2 types of data with different colors

# now let's look at the predictors:
path <- system.file("external", package="sdm")
lst <- list.files(path, pattern='asc', full.names=T)  # asc is the common part of the files inside the object "path" that we want to use
lst # and you get the list of the predictors: the environmental variables
# you can use the lapply function with the raster function but in this case it is not needed since the data are inside the package and they have an asc extension
preds <- stack(lst)
preds
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl) # you can see the values of the different "preds" showed by different colors

# now let's plot just a single variable overlapping it with the occurrencies data:
plot(preds$elevation, col=cl)
points(presences, pch=19)

# the same with the other variables:
plot(preds$temperature, col=cl)
points(presences, pch=19)

plot(preds$vegetation, col=cl)
points(presences, pch=19)

plot(preds$precipitation, col=cl)
points(presences, pch=19)

