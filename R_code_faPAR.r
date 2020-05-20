#R_code_faPAR.r
#how to look at chemical cycling from satellite

# paPAR code

library(raster)
library(rasterVis)
library(rasterdiv)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI)

setwd("C:/lab/")
faPAR10 <- raster("C:/lab/faPAR10.tif")

# with faPAR we can see the real power of the forest of keeping the carbon
levelplot(faPAR10)

# for so the pdf 
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()
pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off()

library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <- random.points(faPAR10,1000)

copNDVIp <- extract(copNDVI,pts)
faPAR10p <- extract(faPAR10,pts)

plot(copNDVIp,faPAR10p)

model1 <- lm(faPAR10p~copNDVIp)

plot(copNDVIp,faPAR10p,col="green")
abline(model1,col="red")

##### day 2

setwd("C:/lab/")
load("faPAR.RData")

library(raster)
library(rasterdiv)
library(rasterVis)
writeRaster(copNDVI, "copNDVI.tif")
#5.3 MB

# faPAR: level plot this set
levelplot(faPAR10)


##### Day 3
### regression model between faPAR and NDVI
## we have two variable (x,y), and we can see the relation between them
# y= bx+a 
#b= the slope, a= the point of intersection with y (intercept)

erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals")

 # the function used is lm
model1 <- lm(hm ~ erosion)
summary(model1) # to have all the information about the model
# in this case the equation is hm= 9.2751*erosion + (-26.9888)
#pvalue= how many time is a random situation, if p is lower than 0.01 means lower prob (1/100) that is random, so the variables are related

abline(model1) #line described by a and b

 setwd("C:/lab/")
faPAR10 <- raster("C:/lab/faPAR10.tif")
library(raster)
library(rasterdiv)
faPAR10 <- raster("C:/lab/faPAR10.tif")
plot(faPAR10)
plot(copNDVI)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)

# function to make a random sample
library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <-random.points(faPAR10,1000) 
copNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10,pts)

# photosyinthesis vs biomass
model2 <- lm(faPAR10p ~ copNDVIp)

plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")
#there are some parts with high biomass and high faAPR(near redl line
# but also points with high biomass but low phootosyntesis so they are far from red line






