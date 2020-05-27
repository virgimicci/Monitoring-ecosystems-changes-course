# R_code_EBVs.r

# install.packages("raster")
# install.packages("RStoolbox")
library(raster)
library(RStoolbox) # this is for PCA


setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

snt <- brick("snt_r10.tif")

plot(snt)

# B1 blue
# B2 green
# B3 red
# B4 NIR

# R3 G2 B1
plotRGB(snt,3,2,1, stretch="lin") 
plotRGB(snt,4,3,2, stretch="lin") 

pairs(snt)

### PCA analysis
sntpca <- rasterPCA(snt)
sntpca

summary(sntpca$model)
# 70% of information
plot(sntpca$map) 

plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

# set the moving window
window <- matrix(1, nrow = 5, ncol = 5)
window

sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")

############## day 2

## FOCAL ON Cladonia
setwd("C:/lab/") 
library(RStoolbox)
library(raster) # two function we can use 1.raster(import one single layer, one bend) 2.brick(import several layers)
# now we have three layers so we need brick function
clad <- brick("cladonia_stellaris_calaita.JPG")

plotRGB(clad,1,2,3, stretch="lin") 
# we create a window to analyze the standard deviation of a 3x3 matrix, and so 3x3 pixel
# number one is an arbitrary value
window <- matrix(1, nrow = 3, ncol = 3)
window

cladpca<-rasterPCA(clad)
cladpca 
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")
summary(cladpca$model)
# functin focal for do the calculation of the value of neightboorod local cells
# we want the first names which is PC1
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)
clad
# PC1_agg <- aggregate(cladpca$map$PC1, fact=10)
# sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)

#plot the calculation
#is telling us how much complex is the organism, with the violet and pink 

par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100)
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad,col=cl) 
# plot(sd_clad_agg,col=cl) 


