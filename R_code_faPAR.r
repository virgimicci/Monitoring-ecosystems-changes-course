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

# faPAR: level plot this set













