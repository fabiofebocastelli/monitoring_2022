library(raster)
setwd("C:/lab/")

# first: list the files available 
rlist <- list.files(pattern="defor") # "defor" is the common part of the two files we want to take from lab folder
rlist # the output is "defor1_.png" "defor2_.png"

# second: use lapply function (apply a function to a list): lapply(X, FUN, …)
# the X is the name of the list wich in this case is rlist, and the FUN is the the function to be applied to each element of X (brick function in this case)
listrast <- lapply(rlist, brick) # listrast is a name, you can choose any other if you like
listrast # and you get all the infos on the two files source
# we don't make a stack since we have two different images we want to treat separately
plot(listrast[[1]]) # the output is the 3 images of defor1_.1, defor1_.2, defor1_.3 

# the 3 defor layers correspond to the 3 different wavelenght reflectances respectively : NIR 1, RED 2, GREEN 3
plotRGB(listrast[[1]], r=1, g=2, b=3, stretch="lin") # the output is just one image of defor1_.png file with its 3 layers (bands) overlapped
# you can re-assign a name 
l1992 <- listrast[[1]]
# so that we can just do:
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
# now the same with the second file:
l2006 <- listrast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# if you want to estime the change in time in terms of amount of forest which has been lost between 1992 and 2006:
# unsupervised classification to make R know where is forest and where is not. For instance to make R able to distinguish between forests and field crop
library(RStoolbox) # for classification
# make use of unsuperClass function
l1992c <- unsuperClass(l1992, nClasses=2) # nClasses is an integer, it's the number of classes.
l1992c # and you get the new infos summary: now the values are just either 1 or 2
plot(l1992c$map) # forest is linked to value 1 and field crops and water to value 2 (green color)

# now let's check the frequencies of the pixels.. how many pixels inside my maps are forest? and how many are field crops?
# use freq function 
freq(l1992c$map) # and you get the count
total <-  341292 # these are the total amount of pixels in l1992 file
# we want to check the proportion..
propforest <-  308561/total
propagri <- 32731/total
propforest # [1] 0.9040968
propagri # [1] 0.09590321 
# in 1992 the 90% of the evaluated area was covered by forest

# now let's build a dataframe with those values:
cover <- c("Forest", "Agriculture") # N.B. this is an array!
prop1992 <- c(0.9040968, 0.09590321)
# or even better:
prop1992 <- c(propforest, propagri) # in that way you avoid to write numbers which is always a GOOD THING with R!

proportion1992 <- data.frame(cover, prop1992)
proportion1992 # and you get the table (data frame)

# now let's plot the data with ggplot2
library(ggplot2)

ggplot(proportion1992, aes(x=cover, y= prop1992, color= cover))
# we want to have an histogram: geom_bar function 
ggplot(proportion1992, aes(x=cover, y= prop1992, color= cover)) + geom_bar(stat="identity", fill="white") # "identity" means we want to use the values as they are
# fill is for chosing the colour inside the bars of the histogram

## DAY 2 ##

# recall all the previous things 
library(raster)
library(RStoolbox) 
library(ggplot2)
setwd("C:/lab/") 

# list the files available
rlist <- list.files(pattern="defor")
rlist
list_rast <- lapply(rlist, brick) # lapply(x, FUN)
list_rast
l1992 <- list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# unsupervised classification: unsuperClass function 
# we shift from a rasterbrick to a single raster layer
l1992c <- unsuperClass(l1992, nClasse=2)
# no more continuous values (0-255) but only 2 values (1 or 2)
# let's plot the map
plot(l1992c$map)
# let's compute the frequencies 
freq(l1992c$map)
# let's get the proportions...
# build a dataframe..

# classification of 2006
# unsupervised classification (again)
l2006 <- list_rast[[2]]
l2006c <- unsuperClass(l2006, nClasses=2) # unsuperClass(x, nClasses) 
l2006c
# frequencies
# proportions
total <- 342726
propagri2006 <- 164759/total
propforest2006 <- 177967/total
# dataframe 
prop2006 <-c(propforest2006, propforest2006)
proportion <- data.frame(cover, prop1992, prop2006)
proportion # and you get:  cover   prop1992  prop2006
                          #Forest 0.90409679 0.5214508
                          #Agric  0.09590321 0.5214508

# than plot with ggplot:
ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

# now plot everyting altogether with:
library(gridExtra) # Provides a number of user-level functions to work with "grid" graphics, notably to arrange multiple grid-based plots on a page, and draw tables
# let's make use of grid.arrange function
# first rename the two ggplot:
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")
p1 <- ggplot(proportion, aes(x=cover, y= prop1992, color= cover)) + geom_bar(stat="identity", fill="white")
# now, the easiest approach to assemble multiple plots on a page is to use the grid.arrange() function from the gridExtra package, so:
grid.arrange(p1, p2, nrow=1) # and you get both histograms together
# to change te width of the hist line:
ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

## DAY3 ##

library(patchwork) # The goal of patchwork is to make it easier to combine separate ggplots into the same graphic

# plot two graphs with patchwork package 
p1+p2
p1/p2 # to have one plot on top of the other

# patchwork is working also with raster data
# instead of using plotRGB we can use ggRGB:
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
# or
ggRGB(l1992, r=1, g=2, b=3) # with this one you also have coordinates
# let's play a bit with "stretch" 
ggRGB(l1992, r=1, g=2, b=3, stretch="lin") # no capital letter for "lin" here
ggRGB(l1992, r=1, g=2, b=3, stretch="hist") # N.B. "hist" in lower case again..
# you can see more things: e.g. the lines of the scanner of the satallite
ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt") # here you are compacting the data, usefull to remove extreme data
ggRGB(l1992, r=1, g=2, b=3, stretch="log")

# and now let's do a patchwork:
gp1 <- ggRGB(l1992, r=1, g=2, b=3, stretch="lin") 
gp2 <- ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
gp3 <- ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
gp4 <- ggRGB(l1992, r=1, g=2, b=3, stretch="log")

gp1 + gp2 + gp3 + gp4 # and you get 4 graphs together

# multitemporal patchwork 

gp1 <- ggRGB(l1992, r=1, g=2, b=3)
gp5 <- ggRGB(l2006, r=1, g=2, b=3)
 
gp1 + gp5
# or
gp1/gp5





