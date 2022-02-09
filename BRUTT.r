ext <- c(4e+06, 5200000, 1400000, 2800000)
clc00cropped <- crop(clc00, ext)
forest_ID <- c(311, 312, 313, 321, 322, 323, 324)
clc_forest00 <- clc00cropped%in%forest_ID
