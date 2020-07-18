# R_code_exam.r

# Indices
# 1. R_code_first (22)
# 2. R_code_multipanel (53)
# 3. R_code_spatial (94)
# 4. R_code_multivariate (178)
# 5. R_code_remote_sensing (217)
# 6. R_code_point_pattern_analysis (353)
# 7. R_code_ecosystem_functioning (413)
# 8. R_code_PCA_remote_sensing (496)
# 9. R_code_faPAR  (582)
# 10. R_code_radiance (679)
# 11. R_code_EBVs (729)
# 12. R_code_snow (817)
# 13. R_code_no2 (906)
# 14. R_crop_an_image (968)
# 15. R_code_temp_interpolation (993)
# 16. R_species_distribution_modelling (1063)
# 17. R_project_LaPalma

####### 1. R_code_first #######
###############################

# the function install.packages is used to install any packages that we want to use which is still not intalled in our R
#sp is a package for spatial data
install.packages("sp")

# the function library is used to start using the data present in the package
library(sp)
#meuse is a dataset comprising of four heavy metals measured in the top soil in a flood plain along the river Meuse
data(meuse)

# let's see how the meuse dataset is structured
meuse
# let's look at the first rows of the set with the function head()
head(meuse)

#Let's plot two variables
#let's see if zinc concentration is related to that copper

#the function attach () connects the dataset to the r search path so that we can use the infos in the dataset
attach(meuse)
# plot function is used for plotting a dataset
plot(zinc,copper)
# col is used to choose the colour
plot(zinc,copper,col="green")
# pch is used to define the symbol
plot(zinc,copper,col="green",pch=19)
# cex is used to define the size of the symbol
plot(zinc,copper,col="green",pch=19,cex=4)

######### 2. R_code_multipanel ############
###########################################
### Multipanel in R: second lecture of monitoring ecosystem

install.packages("sp")
install.packages("GGally") # this is used for the function ggpairs(), is an extension of ggplot2

library(sp) # require(sp) will also do the job

data(meuse) # there is a dataset aviable named meuse
attach(meuse)

# Excercise: see the names of the variables and plot cadmium versus zinc 
# There are two manners to see the names of the variables:
names(meuse) # is used to see the names of the different variables
head(meuse) # i see just the first six lines

plot(cadmium,zinc,pch=15,col="red",cex=2) 

# Exercise: make all the possible paiwis plots of the dataset
# plot(x,cadmium)
# plot(x,zinc)
# plot....
# plot is not a good idea!

#the function pairs() is used to produce a matrix of scatterplots
pairs(meuse)
# in case you recive the error "the size is too large" reshape with the mouse the graph window

# code to switch from the whole varaiable to the 4 variable
pairs(~ cadmium + copper + lead + zinc, data=meuse)

pairs(meuse[,3:6]) # subset of meuse dataset since column 3 to 6, another way for do it, is like the previews one

# Exercise: prettify the graph
pairs(meuse[,3:6],pch=8,col="purple",cex=2)

# GGally package will prettify the graph
library(GGally)
ggpairs(meuse[,3:6])

####### 3. R_code_spatial  #######
##################################

# R code for spatial view of points

library(sp)
data(meuse)
head(meuse)

# coordinates
# coordinates of this spatial dataset, we have to explain that are under x and y 
coordinates(meuse) = ~x+y # the function coordinates() is to say to R that in the dataset meuse the coordinates are x and y

# we can put a plot for making a graph of the dataset
plot(meuse)
spplot(meuse, "zinc") # plot several layers with a single legend for all the maps. The legend is related to the variable, in this case Zinc

# Exercise: plot the spatial amount of copper 
spplot(meuse, "copper", main = "Copper concentration")  # with "main" i create the title of the graph

# We change the way we see the point in the graph with the function bubble
bubble(meuse, "zinc")

# Exercise: bubble copper in red
bubble(meuse, "copper", main = "Copper concentration", col="red")

#### Importing new data
# download covid_agg.csv from our teaching site and build a folder called lab into C:
# put the covid_agg.csv file into the folder lab
# setting the working directory: lab
# Windows
# setwd("C:/lab/")
setwd("C:/lab/")

# the function read.table("covid_agg.csv", head=T) is to open and read the file, with "" because is imported from outside
# <- is to assign to a vector
covid <- read.table("covid_agg.csv", head=TRUE) # it's imp to put the head to insert the title of the column using TRUE
head(covid) 
attach(covid)
plot(country, cases) # where country is x and cases is y

# in case you do not attach covid you should use the dollar, plot(covid$country, covid$cases)

plot(country, cases, las=0) # parallel lables
# we cannot see all the countries so we need to change the orientation of the lables
plot(country, cases, las=1) # horizontal lables
plot(country, cases, las=2) # perpendiicular lables
plot(country, cases, las=3) # vertical lables
plot(country, cases, las=3) 

# we want to reduce the size of the x axis labels using cex.axis and assignin a value lower than 1
plot(country, cases, las=3, cex.axis=0.5)

# ggplot2 package
install.packages("ggplot2")
library(ggplot2) # require(ggplot2)

## save the .RData under the menu File ##

# load the previously saved .RData
setwd("C:/lab/")
load("spatial.RData")
ls() #ls() is the function to check which files are uploaded

# Covid
library(ggplot) #require(ggplot2)
# mpg dataset provides fuel economy data from 1999 and 2008 for 38 popular models of cars. The dataset is shipped with ggplot2 package
data(mpg) #to access to it
head(mpg)
# key components: data, aes, geometry
# aes= variable we want to plot, size=dimensions of point, geom = geometry of the point

ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()

# we can change the geometry of the graph 
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()

#let's look at the covid data that we already have uploaded
head(covid)
# we will exagerate the size by the number of cases
ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()


########## 4. R_code_multivariate ##########
############################################

# R code for multivariate analysis
setwd("C:/lab/")

# The vegan package provides tools for descriptive community ecology. It has most basic functions
# of diversity analysis, community ordination and dissimilarity analysis. Most of its multivariate tools
# can be used for other data types as well.
install.packages("vegan")
library(vegan)

# biomes is the name that we give(the vector assigned by the symbol <-), read.table is to analyze the data, "biomes.csv" is the name of the file, 
# head=T because the first row is words, sep="," is the separator between the names of the words in the row
biomes <- read.table("biomes.csv", head=T, sep=",")
head(biomes) # or also view(biomes), biomes

# Multivariate analysis
# DEtrended CORrespondence ANAlysis
multivar <- decorana(biomes)
plot(multivar)
# we are now seeing the graph from 1 point of view, but we can see it from other
#if we just put multivar, we see the analysis that happened
multivar
# eigenvalues= the percentage of data that we are able to see from this prospective

# biomes types
biomes_types <- read.table("biomes_types.csv", header=T, sep=",")
head(byomes_types)
attach(biomes_types)
# we make an ordiellipse that connects all the plots of the same biome
# Multivar is the first name we gave
# lwd= thickness of the line with respect to the default thickness 
# kind: type of grouping 
ordiellipse(multivar, type, col=1:4, kind = "ehull", lwd=3) # we can put the color like this or col=c("green","orange","red","blue")
#to see the 'disk' of the biomes
ordispider(multivar, type, col=1:4, label=T)


########### 5. R_code_remote_sensing ###########
################################################

# R code remote sensing, to see things through wave

setwd("C:/lab/")
# raster is useful for reading, writing, manipulating, analyzing and modeling of gridded spatial data (the format with pixels), name derives from rastrum=aratro
install.packages("raster")
#RStoolbox is a package for remote sensing image processing and analysis, such as calculating spectral indices, principal component transformation, unsupervised and supervised classification or fractional cover analyses.
install.packages("RStoolbox")

library(raster) 

# we are going to import some images, since these are satellite images and so they have more layers we use brick
# brick imports different layers at a time like satellites with more bands
# .grd are the images
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011) # we can see the plot of the different reflectance of bands, now we change the color ramp palette
cl <- colorRampPalette(c("black","grey","light grey"))(100)

# Exercise: plot the image with the new color ramp palette
plot(p224r63_2011, col=cl) # using col=cl we use the colors decided in the previous funcion

# Bands of Landsat 
# B1: blue
# B2: green
# B3: red
# B4: NIR

# colors()--> shows how many color there are into R
# multiframe of different plots all togheter, (2,2) row per column
par(mfrow=c(2,2))

# B1: blue
clb <- colorRampPalette(c('dark blue', 'blue', 'light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb) # $ to link every single band to the image

# B2: green
# Excercise do the same for the green band B2_sre
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

# B3 red
clr <- colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)

# B4 NIR
cln <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=cln)

# let's change the par
par(mfrow=c(4,1)) # to have them all in a column
# recall all the bands

# close all the things before
dev.off()

## RGB
# we are goin to mount the bands 
# plotRGB, with linear stretching (to make a continuous between the colours) and associating the bands with the respective colors
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # how we would see it with our eyes

# now we are making all the components shift and add first the NIR, removing the blue 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # like this we mounted the NIR on top of the red component of the RGB spectrum so all the areas reflecting in the NIR will apear red (mainly vegetation)

# put the NIR on top of the green component of the RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

# now NIR in the blue component
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

######### Second lesson

setwd("C:/lab/")
load("RS.RData")
ls() #ls() is the list function to see which packages we have already
library(raster)
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

#Bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR

# Excercise: plot in visible RGB 321 both images
par(mfrow=c(2,1)) # you are saying that tou want the two follows images toghether in one column and two rows
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
# we can see the two images together so we can appreciate the changes, however the vegatation is difficult to see
# show the same plot but with 432 RGBspace, to see the NIR

# Excercise: plot in false colour RGB 432 both images
par(mfrow=c(2,1)) 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

# enhance the noise, stretching more the colours
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

# plot RGB
#bands of Landsat
#B1: blue
#B2: green
#B3: red B3_sre
#B4: NIR B4_sre

# we are going to use the vegetation index
# dvi 2011
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

# let's see the effect of changing the grain (dimension of the pixels) 
# aggregate function: aggregates pixels to make a coarser grain, "fact" is the argument that indicates the factor of increase of the pixels.
# this process is called resampling 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

####### 6. R_code_point_pattern_analysis #######
################################################

# Point pattern analysis: density map

install.packages("spatstat") # spatstat is a package for the statistical analysis of spatial point patterns
library(spatstat)

attach(covid)
head(covid)
# let's give a name to what we are about to make -> covids 
# then explain x and y variables and the range for the numbers with c
covids <- ppp(lon, lat, c(-180,180), c(-90,90)) # ?ppp (planar point pattern) creates an object of class "ppp" representing a point pattern dataset in the two-dimensional plane
# density of the covids object that we created before
d <- density(covids)
# to show the map I use plot
plot(d)
# let's put the points inside this plot
points(covids)

### Second lesson
setwd("C:/lab/")
load("pointpattern.RData") # I load the work previously done and saved
library("spatstat")

# density map
plot(d)
points(covids)
# download coastlines .zip file from IOL and copy all the files into lab folder
# rgdal package provides bindings to the 'Geospatial' Data Abstraction Library 
install.packages("rgdal")
library(rgdal)

# let's input vector line (x0y0, x1y1, x2y2..)
# #read0GR within rgdal is a function that reads an OGR data source and layer into a suitable Spatial vector object
coastlines <- readOGR("ne_10m_coastline.shp")

#add--> add to the previous plot,  it doesn't erease the previous data 
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

# In order to export the map begin with pdf(), after put all the commands for the map and finish with dev.off
pdf("covid_density.pdf")
cl <- colorRampPalette(c("lightblue", "blue", "yellow", "orange", "red")) (100)
plot(d, col=cl, main="Covid19 Density")
points(covids)
plot(coastlines, add=T)
dev.off()

####### 7. R_code_ecosystem_functioning #######
###############################################

# R_code_ecosystem_functions.r
# R code to view biomass over the world and calculate changes in ecosystem functions
# energy
# chemical cycling
# proxies
# install.packages("rasterdiv")
# install.packages("rasterVis")


install.packages("rasterdiv") # is useful to calculate indices of diversity on numerical matrices based on information theory
install.packages("rasterVis") # is a package that implements visualization methods for rasters

library(rasterVis)
library(rasterdiv)
# the input dataset is the Copernicus Long-term (1999-2017) average Normalise Difference Vegetation Index (copNDVI)
data(copNDVI)
plot(copNDVI)

# reclassify is a function that (re)classifies groups of values to other values
# "cbind" is to remove some data from the library that is not useful for us
copNDVI<- reclassify(copNDVI, cbind(253:255,NA), right=TRUE)
levelplot(copNDVI) # draw level plots and contour plots
# highlights the mean biomass over the last 20 years

# fact=10 (factor of 10) is aggregating 10 pixels in 1, so the new image has much visible boundaries beetween colours
# the number of pixel has to be select in relation to what we are trying to see, if it is possible to have less pixels with the same analysis results is better (the file will be smaller in size)
copNDVI10<- aggregate (copNDVI,fact=10)
levelplot(copNDVI10)

#let's try 100x100 pixels in one
copNDVI100<- aggregate (copNDVI,fact=100)
levelplot(copNDVI100)

##############################
setwd("C:/lab/")
library(raster)

# DVI deforestation
defor1 <- brick("defor1_.jpg.png") # imports different layers at a time 
defor2 <- brick("defor2_.jpg.png")

# band1: NIR, defor1_.1, defor2_.1
# band2: red defor1_.2, defor2_.2
# band3: green 
# making the plot of the two images separately, selecting the bands, stretch to make a better passage between colours
plotRGB(defor1, r=1, g=2,b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# to see the two images one next to the other we use the par() function with multiframe by rows (1 line, 2 columns)
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin") # Red-Green-Blue plot of a multi-layered Raster object
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# if you write defor1 on R you look at the names that correspond to the 3 bands
# names: defor1_.1,  defor1_.2,  defor1_.3 
# band1: NIR    defor1_.1
# band2: red    defor1_.2
# dvi=difference vegetation index 
dvi1 <- defor1$defor1_.1 - defor1$defor1_.2
# same for defor2
# names:defor2_.1, defor2_.2, defor2_.3 
# band1:NIR, defor2_.1
# band2:red, defor2_.2
 
dvi2 <- defor2$defor2_.1 - defor2$defor2_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # we create the palette with the colours that we think more useful to highlight our data
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

#let's see the difference in the dvi between the first one and the second one 
difdvi <- dvi1 - dvi2
dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld) 

# to make an histogram 
hist(difdvi) 

####### 8. R_code_PCA_remote_sensing #######
############################################

#R_code_pca_remote_sensing.r

setwd("C:/lab/") 
library(raster)
library(RStoolbox)

p224r63_2011 <- brick("p224r63_2011_masked.grd")

# we use plotRGB
# b1 blue
# b2 green
# b3 red
# b4 NIR
# b5 SWIR (short wave infrared)
# infrared has 3 parts: one close to red, one in other place, one as thermal infrared.
# b6 thermal infrar
# b7 SWIR
# b8 panchromatic

plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

##The same plot with GGplot
library(ggplot2)
ggRGB(p224r63_2011,5,4,3) # ggRGB calculates RGB color composite raster for plotting with ggplot2


# do the same with the 1988 image
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

# let's see if the bands are correlated to eachother 
# being correlated means that you are following the pattern of another variable, 
# we are going to see if band3 is correlated to band1, so if having small values of B1 is related to the values on B3 
# first we need to know the names of those bands 
names(p224r63_2011)
# "B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"
# sre: spectrum reflectance, bt: bit transfer
# we are going, through $, to correlate the bands to the image
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)

dev.off()
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)

# PCA
# decrease resolution
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)

# rasterPCA function calculates R-mode PCA (Principal Component Analysis) for RasterBricks or RasterStacks and returns a RasterBrick with multiple layers of PCA scores
# PCA is useful to uncover relationships among many variables (as found in a set of raster maps in a map list) and to reduce the amount of data needed to define the relationships
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)

plot(p224r63_2011_pca$map) #let's polot the $map
cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) 
plot(p224r63_2011_pca$map, col=cl)

# summary:to see information clearly
summary(p224r63_2011_pca$model) # $model : how much variation is explained by each component
# PC1 99.83% of the whole variation

pairs(p224r63_1988) # how much the bands are correlated each other

# let's do the same for the 1988 
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res)
plot(p224r63_1988_pca$map, col=cl)

summary(p224r63_1988_pca$model) # we see that there is high correlation 
# here as well we can see that the PC1 has the highest amount of information
pairs(p224r63_1988)

# now we can make a difference between the 1988 and 2011 and then plotting the difference 
# we are making the difference of every pixel
difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(difpca)
# since the PC1 contains most of the information so we can also only plot this one, only 1 layer
cldif <- colorRampPalette(c('blue','black','yellow'))(100)
plot(difpca$PC1, col=cldif)
# we see the areas that have changed most

###### 9. R_code_faPAR  #######
###############################

# R_code_faPAR.r
# how to look at chemical cycling from satellite

# faPAR code

library(raster)
library(rasterVis)
library(rasterdiv)

# copNDVI (copernicus NDVI) NDVI= works with layers of reflectance
# plants: high reflectance in NIR and low in RED
# no plants: lower NIR higher RED
# let's have a look to the Copernicus image 
plot(copNDVI)
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

##### day 2

setwd("C:/lab/")
load("faPAR.RData")

library(raster)
library(rasterdiv)
library(rasterVis)
writeRaster(copNDVI, "copNDVI.tif") # write an entire Raster object to a file
# 5.3 MB

# faPAR: level plot this set
levelplot(faPAR10)

##### Day 3
### regression model between faPAR and NDVI
## we have two variable (x,y), and we can see the relation between them
# y= bx+a 
# b= the slope, a= the point of intersection with y (intercept)

erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600) # hm, heavy metals
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals")

# the function used is lm
model1 <- lm(hm ~ erosion)
summary(model1) # to have all the information about the model
# in this case the equation is hm= 9.2751*erosion + (-26.9888)
#pvalue= how many time is a random situation, if p is lower than 0.01 means lower prob (1/100) that is random, so the variables are related
abline(model1) # line described by a and b

# let's do the same for the faPAR and NDVI 
setwd("C:/lab/")
faPAR10 <- raster("C:/lab/faPAR10.tif")
library(raster)
library(rasterdiv)
faPAR10 <- raster("C:/lab/faPAR10.tif")
plot(faPAR10)
plot(copNDVI)
# let's remove the water values from the copNDVI
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
copNDVIp <- extract(copNDVI, pts) # make the extraction of the faPAR and copNDVI from a raster
faPAR10p <- extract(faPAR10,pts)

# photosyinthesis (y) vs biomass (X)
model2 <- lm(faPAR10p ~ copNDVIp)
summary(model2) # we see through the r squared and the p-value that the correlation is not random
plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")
# there are some parts with high biomass and high faAPR(near red line)
# but also points with high biomass but low photosyntesis, so they are far from red line

####### 10. R_code_radiance #######
###################################
# R_code_radiance.r

# bit example
library(raster)

#let's create a raster with 2 rows and 2 columns
toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.13,1.44,1.55,3.4) # put data into each pixel
plot(toy)
text(toy, digits=2)

# we changed the original, the lower the n of bits we use, the lower the difference between pixels 
toy2bits <- stretch(toy,minv=0,maxv=3)
storage.mode(toy2bits[]) = "integer"
plot(toy2bits)
text(toy2bits, digits=2)

# let's use 4 bits, 16 values possible
toy4bits <- stretch(toy,minv=0,maxv=15)
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2)

# now 8 bits, 256 potential values 
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, digits=2)

# plot all togheter
par(mfrow=c(1,4))
plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2)

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)

dev.off()
library(rasterdiv)
plot(copNDVI)


########### 11. R_code_EBVs  ###########
########################################

# R_code_EBVs.r
# Essential Biodiversity Variables

# install.packages("raster")
# install.packages("RStoolbox")
library(raster)
library(RStoolbox) # this is for PCA

setwd("C:/lab/") # windows

# now we import the image: we can use raster which imports one single layer or brick which imports the whole image (different layers at a time)
snt <- brick("snt_r10.tif")
# 30 Bit image 

plot(snt)

# B1 blue
# B2 green
# B3 red
# B4 NIR

# R3 G2 B1
plotRGB(snt, 3, 2, 1, stretch="Lin") # image as the human eye would see it
plotRGB(snt, 4, 3, 2, stretch="Lin") # NIR on top of red, vegetation is then colored red
pairs(snt) # to produce a matrix of scatterplots 

### PCA analysis
sntpca <- rasterPCA(snt)
sntpca

summary(sntpca$model)
# 70% of information
plot(sntpca$map) 

plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

# set the moving window
# to see the different standard deviation in the groups of pixels 
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
library(raster) # two function we can use: 1.raster(import one single layer, one bend) 2.brick(import several layers)
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

######## 12. R_code_snow ########
#################################

# R_code_snow.r

setwd("C:/lab/") # windows

# install.packages("ncdf4")
library(ncdf4) # in order to read netCDF files, all copernicus data use this extension
library(raster)

snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

# Exercise: plot snow cover with the cl palette
plot(snowmay,col=cl)

##### import snow data

setwd("C:/lab/snow/")

snow2000r <- raster("snow2000r.tif")
snow2005r <- raster("snow2005r.tif")
snow2010r <- raster("snow2010r.tif")
snow2015r <- raster("snow2015r.tif")
snow2020r <- raster("snow2020r.tif")

par(mfrow=c(2,3))
plot(snow2000r, col=cl)
plot(snow2005r, col=cl)
plot(snow2010r, col=cl)
plot(snow2015r, col=cl)
plot(snow2020r, col=cl)

##### we can do the same we've done before with less command
## fast version of import and plot many data for lazy people
# is used to apply a function, in this case "raster" to several layer in one time 

# list.files function is used to do the list of all the files in a cerain place considering a repeting pattern in the name of the files
rlist <- list.files(pattern="snow")

# we use the function lapply to apply the raster function to all the list we've done before
import <- lapply(rlist, raster)

# when i have so many raster files is better to put them in a stack, without using par function
snow.multitemp <- stack(import)  
plot(snow.multitemp, col=cl)

# I can also chose which ones to plot
par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))


#### Let's make a prediction

source("prediction.r")
plot(predicted.snow.2025.norm, col=cl)

######### Day 2
setwd("C:/lab/snow") # windows

# Excercise: import all of the snow cover images all together 
library(raster)

rlist <- list.files(pattern="snow")
import <- lapply(rlist, raster)
snow.multitemp <- stack(import)  
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow.multitemp, col=cl)

prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)
# writeraster creates a data, it is the opposite to raster function
# with raster or brik function you import the data, with writeraster function you are exportinx images from R to my folder
writeRaster(prediction, "final.tif")
final.stack <- stack(snow.multitemp, prediction)
final.stack <- stack(snow.multitemp, prediction)
plot(final.stack, col=cl)

# export R graph for yout beautiful thesis
png("my_final_exciting_graph.png")
plot(final.stack, col=cl)
dev.off()

######## 13. R_code_no2 #########
#################################

library(raster)
setwd("C:/lab/no2/") # windows

# Exercise: import all of the NO2 data in R by the lapply function
rlist <- list.files(pattern="EN")
rlist

import <- lapply(rlist, raster)
EN <- stack(import)
cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(EN, col=cl)

# let's plot the first one and the last one only to see the difference, january and march
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

# RGB space
plotRGB(EN, r=1, g=7, b=13, stretch="lin")

# difference map
dif <- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100) # 
plot(dif, col=cld)

# quantitative estimate!
# let's see the boxplot() function
# produce box and whisker (the lines) of a given data
# let's make a boxplot of the whole stack, to see the variation in a graphical way 
boxplot(EN)

# there are a lot of outliers, let's remove them 
boxplot(EN, outline=F)

# let's move the boxplots horizontal 
boxplot(EN, outline=F, horizontal=T)

# let's add the axes to make it easier to read
boxplot(EN, outline=F, horizontal=T, axes=T)

# plot!
plot(EN$EN_0001, EN$EN_0013)
abline(0,1,col="red")

######## 1:1 line with snow data
setwd("C:/lab/snow/") 

# Exercise: import the snow cover imeages altogether

# fast version of import and plot of many data for lazy people!
rlist <- list.files(pattern="snow20")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

plot(snow.multitemp$snow2000r, snow.multitemp$snow2020r)
abline(0,1,col="red")

############# 14. R_crop_an_image ###############
#################################################

#how to crop satellite images 

setwd("C:/lab/")
library(raster)
library(ncdf4) 

snow <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow, col=cl)

ext <- c(0, 20, 35, 50)
zoom(snow, ext=ext) # zoom function allows to zoom on an image

# crop function allows to create a new image
snowitaly <- crop(snow, ext) 
plot(snowitaly, col=cl) 

#you can also use drawextent
# zoom(snow, ext=drawExtent())
# crop(snow, drawExtent())

############ 15. R_code_interpolation ###########
#################################################

###interpolation
# using data that we measured in the field 
# 1.Foreste Casentinesi dataset

setwd("C:/lab/snow/") 
install.packages("spatstat")
## Interpolation: spatstat library
library(spatstat)

inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T) #; is for the semi-column, each column has an header so is TRUE
# attach-->start working with the dataset
attach(inp)
plot(X,Y)

#to know minimum and maximum of X and Y
summary(inp)
#ppp() function we are going to assign what are X, Y and the range
inppp <- ppp(x=X,y=Y,c(716000,718000),c(4859000,4861000))

#marks() function to lable the single point with the data we want
#we put into the inppp the canopy cover
names(inp)
marks(inppp) <- Canopy.cov
# we don't need to use $ to select the column because we attached the file
# Smooth() function is from library(spatstat). Allows us to interpolate data where we don't have it.
canopy <- Smooth(inppp)
plot(canopy)
points(inppp, col="green") # to add the points to the image 

# we can measure the lichens on the tree and see how much they are covering them
# lichens: bioindicators
marks(inppp) <- cop.lich.mean
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)

# show our plots in one image
par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)

# final plot
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)
########################################################

# 2. Data psammophilus species 
#psammophilus: adapted to arid environments (sand dunes)
# The file that is just a table (no need to use raster or brick)
inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)

attach(inp.psam)
# have a look to the dataset
head(inp.psam)
summary(inp.psam) # C.org is the amount of carbon. the higher it is the higher the amount of organisms

# let's see the point in space through the function 
plot(E,N)
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))

marks(inp.psam.ppp) <- C_org
# Smooth() function to calculate the means between points
C <- Smooth(inp.psam.ppp)
plot(C)
points(inp.psam.ppp)

######## 16. R_species_distribution_modelling ########
######################################################
# Species Distribution Modelling
# how to model species distribution

install.packages("sdm")
library(sdm)
library(raster) # predictors
library(rgdal) # species 

# species, presence/absence 
file <- system.file("external/species.shp", package="sdm")
species <- shapefile(file)
species
species$Occurrence # table with absence/presence of species, 0 or 1 
plot(species)

plot(species[species$Occurrence == 1,],col='blue',pch=16) # to only plot the presences 
points(species[species$Occurrence == 0,],col='red',pch=16)  # to plot the absences 

# environmental variables
path <- system.file("external", package="sdm")

#ASII files-->asc, is like a tif o jpeg, is an extention
lst <- list.files(path=path,pattern='asc$',full.names = T)

# we have as files elevation, precipitation, temperature and vegetation
# so we use stack function in order to stack all the files toghether
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

# we create a model -> to put all the information together 

d <- sdmData(train=species, predictors=preds) # sdmData creates objects that holds species (single or multiple) and explanatory variates and more info 

# generalized linear model --> glm, several predictors all together 
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods = "glm")
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# we can make the final stack with all the predictors and variables
s1 <- stack(preds,p1)
plot(s1, col=cl)

########## 17. R_project_LaPalma ###########
#############################################

setwd("C:/lab/exam") # windows

library(raster)
library(RStoolbox)

# La Palma in September 2016 post fire
# fast way to import all the bands
rlist09 <- list.files(pattern="LC08_L1TP_208040_20160928_20170321_01_T1_B")
import09 <- lapply(rlist09,raster)
lapalma09 <- stack(import09)
lapalma09 # i check the order of the bands to change their names correctly
names(lapalma09) <- c("lapalma09_B10","lapalma09_B2","lapalma09_B3","lapalma09_B4","lapalma09_B5","lapalma09_B6") # I change the names of the bands for a easly reading
lapalma09 

#1- lapalma09_B10 : TIRS (Thermal Indrared)
#2- lapalma09_B2 : BLUE
#3- lapalma09_B3 : GREEN
#4- lapalma09_B4 : RED
#5- lapalma09_B5 : NIR
#6- lapalma07_B6 : SWIR


#La Palma in August 2016 (during fire)
rlist08 <- list.files(pattern="LC08_L1TP_208040_20160811_20170322_01_T1_B")
import08 <- lapply(rlist08,raster)
lapalma08 <- stack(import08)
lapalma08 # to check the names of the band and change their names
names(lapalma08) <- c("lapalma08_B10","lapalma08_B2","lapalma08_B3","lapalma08_B4","lapalma08_B5","lapalma08_B6") # I change the names of the bands for a easly reading
lapalma08 

#1- lapalma08_B10 : TIRS (Thermal Indrared)
#2- lapalma08_B2 : BLUE
#3- lapalma08_B3 : GREEN
#4- lapalma08_B4 : RED
#5- lapalma08_B5 : NIR
#6- lapalma08_B6 : SWIR


#La Palma in July 2016 pre fire
rlist07<- list.files(pattern="LC08_L1TP_208040_20160710_20170323_01_T1_B")
import07 <- lapply(rlist07,raster)
lapalma07 <- stack(import07)
lapalma07
names(lapalma07) <- c("lapalma07_B10","lapalma07_B2","lapalma07_B3","lapalma07_B4","lapalma07_B5","lapalma07_B6") # I change the names of the bands for a easly reading
lapalma07

#1- lapalma07_B10 : TIRS (Thermal Indrared)
#2- lapalma07_B2 : BLUE
#3- lapalma07_B3 : GREEN
#4- lapalma07_B4 : RED
#5- lapalma07_B5 : NIR
#6- lapalma07_B6 : SWIR


# I don't like how I see the island
# I just want the island itself and not the external parts
# I create a shapefile with QGIS

shapefile("lapalma.shp") # shapefile created with QGIS
shp <- shapefile("lapalma.shp")
plot(shp)
shp # the extent is different from the RasterStack
# I have to change the extent of the shp in order to have the crop
# I use spTransform using the csr of lapalma09
shp <- spTransform(shp, CRS("+proj=utm +zone=28 +datum=WGS84 +units=m +no_defs"))

# Crop/mask lapalma09
lapalma09 <- mask(lapalma09, shp) 
lapalma09 <- crop(lapalma09, shp)
plot(lapalma09)

#Crop/mask lapalma08
lapalma08 <- mask(lapalma08, shp) # mask is not sufficient
lapalma08 <- crop(lapalma08, shp) # i use crop function
plot(lapalma08)

# Crop/mask lapalma07
lapalma07 <- mask(lapalma07, shp) # mask is not sufficient
lapalma07 <- crop(lapalma07, shp) # i use crop function
plot(lapalma07)

##### plotRGB
# how human eyes see it
par(mfrow=c(1,3), mar=rep(1,4))
plotRGB(lapalma07,4,3,2, stretch="lin", main="July", margins=T) # non fa il titolo CONTROLLA
plotRGB(lapalma08,4,3,2, stretch="lin", main="August", margins=T)
plotRGB(lapalma09,4,3,2, stretch="lin", main="September", margins=T)


### NDVI analysis ####
# ndvi <- (NIR - red) / (NIR + red)
#1 lapalma07_B10 : TIRS (Thermal Indrared)
#2 lapalma07_B2 : BLUE
#3 lapalma07_B3 : GREEN
#4 lapalma07_B4 : RED
#5 lapalma07_B5 : NIR
#6 lapalma07_B6 : SWIR

cl <- colorRampPalette(c('blue','white','red'))(100) 

# Using spectralIndices() from RStoolbox for the NDVI analysis

NDVI07<-spectralIndices(lapalma07, red="lapalma07_B4", nir="lapalma07_B5", indices="NDVI")
NDVI09<-spectralIndices(lapalma09, red="lapalma09_B4", nir="lapalma09_B5", indices="NDVI")
par(mfrow=c(1,2))
plot(NDVI07, col=cl, main= "July")
plot(NDVI09, col=cl, main= "September")

# Zoom in the burned area
ext <- c(215000, 227000, 3150000, 3170000)
zoom(NDVI07, ext=ext)
zoomNDVI07<- crop(NDVI07, ext)

ext <- c(215000, 227000, 3150000, 3170000)
zoom(NDVI09, ext=ext)
zoomNDVI09<- crop(NDVI09, ext)

par(mfrow=c(1,2))
plot(zoomNDVI07, col=cl, main= "July")
plot(zoomNDVI09, col=cl, main= "September")


#highlighting hot soil temperature in red (TIRS,r,b)
par(mfrow=c(1,2), mar=rep(4,4))
plotRGB(lapalma07,1,4,2, stretch="lin", main="High Temperature highlighting in July", margins= T, cex.main= 1)
rect(216000,3151000,226000,3172000, border = "red")
plotRGB(lapalma08,1,4,2, stretch="lin", main="High Temperature highlighting in August", margins=T, cex.main=1)
rect(216000,3151000,226000,3172000, border = "red")

##focus in the area
plotRGB(lapalma07,1,4,2, stretch="lin",  main="High Temperature highlighting in July", margins= T, cex.main= 1, ext=ext)
plotRGB(lapalma08,1,4,2, stretch="lin", main="High Temperature highlighting in August", margins=T, cex.main=1, ext=ext)

#highlight the burnt area (SWIR-NIR-red)
par(mfrow=c(1,1), mar=rep(4,4))
burntarea08<-plotRGB(lapalma08,6,5,4, stretch="lin", margins=T, main="Burnt Area")
rect(216000,3151000,226000,3172000, border = "red")

# see relation among temperature and burned area
par(mfrow=c(1,2), mar=rep(4,4))
plotRGB(lapalma08,1,4,2, stretch="lin", main="High Temperature highlighting", margins=T)
rect(216000,3151000,226000,3172000, border = "red")
plotRGB(lapalma08,6,5,4, stretch="lin", main= "Burnt Area highlighting", margins=T)
rect(216000,3151000,226000,3172000, border = "red")

#zoom in the burnt area
plotRGB(lapalma08,1,4,2, stretch="lin", ext=ext, margins=T,  main="High Temperature highlighting")
plotRGB(lapalma08,6,5,4, stretch="lin", ext=ext, main= "Burnt Area highlighting", margins=T)

plotRGB(lapalma2015,7,2,3,stretch="lin")

### La palma in august 2015, no fire occurred  ##
lp2015<-brick("LC82080402015237LGN01_Enmask2.tif") #Raster without cloud created with Fmask in QGIS
lp2015

# B2 BLUE :LC8208040//_Enmask2.1
# B3 GREEN : LC8208040//_Enmask2.2
# B4 RED : LC8208040//_Enmask2.3
# B5 NIR : LC8208040//_Enmask2.4
# B6 SWIR : LC8208040//_Enmask2.5
# B7 SWIR2 :LC8208040//_Enmask2.6
# B10 TIRS : LC8208040//_Enmask2.7 

names(lp2015)<- c("B2 BLUE ", "B3 GREEN"," B4 RED", "B5 NIR ", "B6 SWIR ","B7 SWIR2", "B10 TIRS")

# Crop/mask La palma 2015
lapalma2015 <- mask(lp2015, shp) # mask is not sufficient
lapalma2015 <- crop(lapalma2015, shp) # i use crop function
plot(lapalma2015)

# DIfferences in T between August 2016 and 2015
par(mfrow=c(1,2), mar=rep(4,4))
plotRGB(lapalma08,1,4,2, stretch="lin", main="High Temperature highlighting in Aug2016", margins= T, cex.main= 1)
rect(216000,3151000,226000,3172000, border = "red")
plotRGB(lapalma2015,7,3,1, stretch="lin", main="High Temperature highlighting in Aug2015", margins=T, cex.main=1)
rect(216000,3151000,226000,3172000, border = "red")


# Comparison of areas in 2015 and 2016
plotRGB(lapalma08,6,5,4, stretch="lin", margins=T,  main="Fire occurred in August 2016")
rect(216000,3151000,226000,3172000, border = "red")
plotRGB(lapalma2015,5,4, 3, stretch="lin",  main= "Fire doesn't occurred in 2015", margins=T) # we have lighter color, maybe for the black hole given by cloud delate
rect(216000,3151000,226000,3172000, border = "red")

#zoom
par(mfrow=c(1,3), mar=rep(4,4))
plotRGB(lapalma08,1,4,2, stretch="lin", ext=ext, main="High Temperature highlighting in Aug2016", margins= T, cex.main= 1.5)
plotRGB(lapalma07,1,4,2, stretch="lin", main="High Temperature highlighting in July2016", margins= T, cex.main= 1.5, ext=ext)
plotRGB(lapalma2015,7,3,1, stretch="lin",  main="High Temperature highlighting in Aug2015", margins=T, cex.main=1.5, ext=c(215000, 227000, 3150000, 3170000))





