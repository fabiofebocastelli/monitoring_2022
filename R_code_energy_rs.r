# R code for estimating energy in ecosystems

# set working directory
#serve per legare una cartella ad R da cui recuperare i dati 
#https://earthobservatory.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil

#  setwd("C:/lab/")  # windows
#how to updat data to r?
#create a rasterbrick 
l1992 <- brick("defor1_.jpg") #image of 1992 importing
#install.packages("rgdal")
#library(rgdal)
l1992 <- brick("defor1_.png") # image of 1992
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
#se voglio cambiare il colore cambio ad esempio g=1 o b=1

