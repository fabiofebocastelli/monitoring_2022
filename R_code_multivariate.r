# R code for measuring community interactions

setwd("C:/lab/")

#use load function to load tha Rdata 
load("biomes_multivar.RData")

ls() #you will see all the objects you have stored in R
# you get [1] "biomes"       "biomes_types" "cl"  

biomes # and you get all the data in the file, basically a matrix of plots versus species (number of individuals for each species in each plot)

multivar <- decorana(biomes) #Detrended correspondence analysis (DCA) , it's for a multivariate analysis
multivar # Rescaling of axes with 4 iterations.
#the first axes DCA1 and the second one DCA2 have the major part of diversity (that's alway true 'cause that's how the method works).. we can use them to make a plot:

plot(multivar)
 
# I want to use a dataset, I can attach it with attach function:
#let's take a look at the grouping of species. Are them in the same biome?
attach(biomes_types)
#to have ellipses in the plot that show us the link between data..
ordiellipse(multivar, type,  col=c("black","red","green","blue"), kind = "ehull", lwd=3) #type is the type of biome, kind is the kind of ellipse we want, lwd= width of the lines

ordispider(multivar, type, col=c("black","red","green","blue"), label = T) # to see the links (lines) between the single plots and the biome they are part of, label = T is for
                                                                           # seeing the labels
# that is usefull too see how different organisms are related to each other!!!

-----switching to the population ecology------

