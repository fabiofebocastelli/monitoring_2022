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
#lezione 19-11
#scrivo l1992 e vengono fuori i dati
#plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") prima banda infrarossi seconda banda rossi terza banda verdi
#linear stretching ... esce la figura colorata..
#si vede la situazione del mato grosso nel 1992
#ora carichiamo l'immagine più recente del 2006:
l2006 <- brick("defor2_.png")
l2006
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin") #plottiamo come prima ma con l'immagine 2006
#let's look at the Rio Pixoto: the amount of solid inside the river is smaller-> is blue and not white as the 1992 pic. If it was black that'd mean is pure water.
#vogliamo mettere una immagine sopra l'altra usiamo codice "par" creamo 2 righe e una colonna
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
#vediamo qualcosa che prima era nascosto... 
#let's calculate energy in 1992
#i nomi dei layers contenenti le differenti reflettanze di colori sono chiamati defor1_.1, defor1_.2, defor1_.3 
dvi1992 <- l1992$defor1_.1-l1992$defor1_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) #per scegliere i colori 
plot(dvi1992, col=cl)
#vogliamo vedere le due immagini sovrapposte, per chiudere l'immagine prevedente "dev.off" close the plotting device
dev.off()
dvi1992 <- l1992$defor1_.1-l1992$defor1_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) #per scegliere i colori 
plot(dvi1992, col=cl)
#esce fuori l'immagine con il DVI 1992

#calculate for 2006 
dev.off()
dvi2006 <- l2006$defor2_.1-l2006$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) #per scegliere i colori 
plot(dvi2006, col=cl)

#monitoriamo la situazione non solo nel momento corrente ma anche lungo il tempo
#facciamo la differenza tra i due anni presi come riferimento 1992 e 2006
dvidif <- dvi1992 - dvi2006
#associamo le differenti funzioni ad oggetti, cosi da poterli usare in analisi successive...
#scegliamo una nuova colorramppallet cld <- colorRampPalette(c('blue','white','red'))(100)
#plot the results 
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvidif, col=cld)

#final plot: original images, DVIs, final DVI difference with "par" function 
#3 row and 2 columns
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
#per farne un pdf 
pdf("energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off() #needed to close the pdf file.
