#R_code_pcs_remote_sensing.r

setwd("C:/lab/") 
library(raster)
library(RStoolbox)
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

##The same plot with GGplot
library(ggplot2)
ggRGB(p224r63_2011,5,4,3)

# do the same with the 1988 image
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")
names(p224r63_2011)
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)

dev.off()
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)
#PCA
#decrease resolution
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)

plot(p224r63_2011_pca$map)
cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) 
plot(p224r63_2011_pca$map, col=cl)
summary(p224r63_2011_pca$model)

pairs(p224r63_1988)
difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(difpca)
cldif <- colorRampPalette(c('blue','black','yellow'))(100) 
plot(difpca$PC1,col=cldif)


