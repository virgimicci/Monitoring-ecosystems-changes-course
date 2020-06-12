# Species Distribution Modelling
# how to model species distribution

install.packages("sdm")
library(sdm)
library(rgdal)

file <- system.file("external/species.shp", package="sdm")
species <- shapefile(file)
plot(species[species$Occurrence == 1,],col='blue',pch=16)
points(species[species$Occurrence == 0,],col='red',pch=16)

path <- system.file("external", package="sdm")

#ASII files-->asc, is like a tif o jpeg, is an extention
lst <- list.files(path=path,pattern='asc$',full.names = T)

# we have as files elevation, precipitation, temperature and vegetation,
# so we use stack function in order to stuck all the files toghether
preds <- stack(lst)
plot(preds)
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)

plot(preds, col=cl)
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

d <- sdmData(train=species, predictors=preds)
# generalized linear model --> glm, several predictors all together 
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods = "glm")
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)
s1 <- stack(preds,p1)
plot(s1, col=cl)
