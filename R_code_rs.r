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



