#  This is my first code in github!

# Here are the input data
# c(100, 200, 300, 400, 500) is an array (the R data objects which can store data in more than two dimensions)

# Costanza data on streams
water <- c(100, 200, 300, 400, 500) #we assign a name to the array with <- #the space between the comma and the next number is not mandatory, it's just for show
water # the output of the above code is: [1] 100 200 300 400 500

# Marta data on fishes genomes
fishes <- c(10, 50, 60, 100, 200)
fishes

# plot the diversity of fishes (Y) versus the amount of water (X) #Generic X-Y plotting
# a function is used with arguments inside! 
plot(water, fishes) # that's the plot function with which you get a graph

# the data we developed can be stored in a table. A table in R is called data frame

streams <- data.frame(water, fishes) # data.frame function
streams # and you get the table of five rows and two columns

# From now on, we are going to import and/or export data!

# For widows user, to set the working directory (which is a file path on your computer that sets the default location of any files you read into R, or save out of R.):
setwd("C:/lab/")

# Let's export our table! use write.table function for Data Output (https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/write.table)
write.table(streams, file="my_first_table.txt")

# now let's suppose that some colleagues did send us a table. How to import it in R?
read.table("my_first_table.txt") #we are going outside R so we need to use quotes ""
# let's assign it to an object inside R
ducciotable <- read.table("my_first_table.txt") # N.B. tables are called data frame

# now we want some statistics, in order to do that quickly I'll use the summary function putting the object inside the brackets
summary(ducciotable) # and we get the summary of the main statistics

# Let's suppose we only want data from one variable.. 
# Es. Marta wants to get info only on fishes
# we have to link the table to the variable we want to have info on by using $ symbol
summary(ducciotable$fishes)

# if I want to have these values as a histogram:
hist(ducciotable$fishes)
hist(ducciotable$water) # and you get the histogram graph!





