# R code remote sensing, to see things through wave

setwd("C:/lab/")

library(raster)

# .grd are the images
p224r63_2011 <- brick("p224r63_2011_masked.grd)

cl <- colorRampPalette(c('black','grey','light grey'))(100)

# Exercise: plot the image with the new color ramp palette
plot(p224r63_2011, col=cl)

#bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR

# colors()--> shows how many color there are into R
# multiframe of different plots all togheter, (2,2) row per column
par(mfrow=c(2,2))

# B1: blue
clb <- colorRampPalette(c('dark blue', 'blue', 'light blue'))(100)
# $ to link every single ban to the image
plot(p224r63_2011$B1_sre, col=clb)

# B2: green
# Excercise do the ame for the green band B2_sre
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

# close all the things before
dev.off()

# RGB

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# Excercise NIR ontop of the G component of the RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#######

setwd("C:/lab/")

load("RS.RData")
ls()
library(raster)
p224r63_1988 <- brick("p224r63_1988_masked.grd")

#bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR

# Excercise: plot in visible RGB 321 both images
par(mfrow=c(2,1)) # you are saying that tou want the two follows images toghether in one column and two rows
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

# Excercise: plot in false colour RGB 432 both images
par(mfrow=c(2,1)) 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

# enhance the noise!
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

# plot RGB
#bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR

dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
plot(dvi2011,col=cl)

# Excercise: dvi for 1988
dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
plot(dvi2011,col=cl)

# dff from one year to the other
diff <- dvi2011 - dvi1988
plot(diff)

# changing the grain
#resampling
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

