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


