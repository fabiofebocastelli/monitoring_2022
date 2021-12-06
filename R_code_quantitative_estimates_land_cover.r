library(raster)
setwd("C:/lab/")
# brick
# first: list the files available 
rlist <- list.files(pattern="defor") #defor is the common part of the two files
# con rlist #esce fuori "defor1_.png" "defor2_.png"

#use lapply function lapply(X, FUN, …)
# second: lapply, apply a function to a list
#the X is the name of the list wich is rlist, and the FUn is the brick function
listrast <- lapply(rlist, brick) #listrast is a name, you can choose any other if u want
listrast
#we not make a stack since we have two different images we want to treat separeted
plot(listrast[[1]])

# defor: NIR 1, RED 2, GREEN 3
plotRGB(listrast[[1]], r=1, g=2, b=3, stretch="lin")
#we can re-assign a name 
l1992 <- listrast[[1]]
#so we can just do 
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
l2006 <- listrast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

#unsupervised classification 
library(RStoolbox) # classification
l1992c <- unsuperClass(l1992, nClasse=2)
plot(l1992c$map)
# value 1 = is forest and value 2= water and agriculture
#new let's check the frequencies of the pixels.. how many pixels inside my maps are forest? and how many are field crops?
# use freq function 
freq(l1992c$map)
total <-  341292 #these are the total amount of pixels in l1992 file
# we want to check the proportion..
propforest <-  308561/total
propagri <- 32731/total
propforest
propagri

#build a dataframe 
cover <- c("Forest", "Agriculture") # this is an array!
prop1992 <- c(0.9040968, 0.09590321)
#or even better..
prop1992 <- c(propforest, propagri) #in that way you avoid to write numbers wich is always a GOOD THING WITH R!

proportion1992 <- data.frame(cover, prop1992)

#plot the data with ggplot2
library(ggplot2)

ggplot(proportion1992, aes(x=cover, y= prop1992, color= cover))
#we want to have an histogram: geom_bar function 
ggplot(proportion1992, aes(x=cover, y= prop1992, color= cover)) + geom_bar(stat="identity", fill="white") #identity means we want to use the values as they are
#fill is for chosing the colour inside the bars of the histogram

 ## day 2 ##
#mi si è bloccato il pc..
recall all the past things .
library(raster)
library(RStoolbox) 
library(ggplot2)

# setwd("C:/lab/") # Windows

# 1 list the files available

rlist <- list.files(pattern="defor")

rlist
list_rast <- lapply(rlist, brick) # lapply(x, FUN)

list_rast
l1992 <- list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# unsupervised classification:  unsuperClass function 
#we shift from a rasterbrick to a single raster layer
l1992c <- unsuperClass(l1992, nClasse=2)
# no more continuous values (0-255) but only 2 values (1 or 2)
#let's plot the map
plot(l1992c$map)
#let's compute the frequencies 
freq(l1992c$map)
#let's get the proportions...
# build a dataframe..

# classification of 2006
# unsupervised classification (again)
l2006 <- list_rast[[2]]
l2006c <- unsuperClass(l2006, nClasses=2) # unsuperClass(x, nClasses) 
l2006c
#frequencies
#proportions
total <- 342726
propagri2006 <- 164759/total
propforest2006 <- 177967/total
#dataframe 
prop2006 <-c(propforest2006, propforest2006)
proportion <- data.frame(cover, prop1992, prop2006)
proportion # and you get:  cover   prop1992  prop2006
                          #Forest 0.90409679 0.5214508
                          #Agriculture 0.09590321 0.5214508

#than plot with:
ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

#now plot everyting altogether with:
library(gridExtra) # Provides a number of user-level functions to work with "grid" graphics, notably to arrange multiple grid-based plots on a page, and draw tables.
#use grid.arrange func
# first rename the two ggplot
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")
p1 <- ggplot(proportion, aes(x=cover, y= prop1992, color= cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrows=1) #and you get both histograms together
#to change te width of the hist line:
ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)




