# Point pattern analysis: density map


install.packages("spatstat")
library(spatstat)

attach(covid)
head(covid)
covids <- ppp(lon, lat, c(-180,180), c(-90,90))
d <- density(covids)
plot(d)
points(covids)
#---

setwd("C:/lab/")
load("pointpattern.RData")
library("spatstat")

# density map
plot(d)
points(covids)

install.packages("rgdal")
library(rgdal)

# let's input vector line (x0y0, x1y1, x2y2..)
coastlines <- readOGR("ne_10m_coastline.shp")

#add--> add to the previous plot
plot(coastlines, add=T)

# cl <- colorRamPalette(c('yellow', 'orange', 'red'))(100), we want red the most dense part and yellow the low dense part, 100=concern all possible color from yellow to red
cl <- colorRampPalette(c('yellow', 'orange', 'red')) (100)
plot(d, col=cl)
points(covids)
plot(coastlines, add=T)

# Exercise: new colour ramp palette
cl <- colorRampPalette(c("lightblue", "blue", "yellow", "orange", "red")) (100)
plot(d, col=cl, main="Covid19 Density")
points(covids)
plot(coastlines, add=T)

#esport the map begin with pdf, after put all the commands for the map and finish with dev.off
pdf("covid_density.pdf")
cl <- colorRampPalette(c("lightblue", "blue", "yellow", "orange", "red")) (100)
plot(d, col=cl, main="Covid19 Density")
points(covids)
plot(coastlines, add=T)
dev.off()
