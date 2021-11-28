#  This is my first code in github!

# Here are the input data
# c(100, 200, 300, 400, 500) is an array (the R data objects which can store data in more than two dimensions.)
# Costanza data on streams
water <- c(100, 200, 300, 400, 500) #we assaign a name to the array with <- #the space between the comma and the next number is not mandatory, it's just for fashion 
water

# Marta data on fishes genomes
fishes <- c(10, 50, 60, 100, 200)
fishes

# plot the diversity of fishes (Y) versus the amount of water (X) #Generic X-Y plotting
# a funtcion is used with arguments inside! 
plot(water, fishes)

# the data we developed can be stored in a table
# a table in R is called data frame

streams <- data.frame(water, fishes)
streams


# From now on, we are going to import and/or export data!

# For Linux (Ubuntu, Fedora, Debian, Mandriva) users
setwd("~/lab/")

# setwd for Windows
# setwd("C:/lab/")

# setwd Mac
# setwd("/Users/yourname/lab/")

# Let's export our table!
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/write.table
write.table(streams, file="my_first_table.txt")

# Some colleagues did send us a table How to import it in R?
read.table("my_first_table.txt")
# let's assign it to an object uinside R
ducciotable <- read.table("my_first_table.txt")

# the first statistics for lazy beautiful people
summary(ducciotable)

# Marta does not like water
# Marta wants to get info only on fishes
summary(ducciotable$fishes)

# histogram
hist(ducciotable$fishes)
hist(ducciotable$water)





