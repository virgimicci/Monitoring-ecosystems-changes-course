# R code exam
# 1. R code first
install.packages("sp")

library(sp)
data(meuse)

# let's see how the meuse dataset is structured:
meuse

# let's look at the first row of the set
head(meuse)

#Let's plot two variables
#let's see if zinc concentration is related to that copper
attach(meuse)
plot(zinc,copper)
plot(zinc,copper,col="green")
plot(zinc,copper,col="green",pch=19)
plot(zinc,copper,col="green",pch=19,cex=4)

############################################################
#####################################
#############
# 2. R spatial

# R code for spatial view of points

library(sp)

data(meuse)
head(meuse)

# coordinates of this spatial dataset, we have to explain that are under x and y 
coordinates(meuse) = ~x+y

# we can put a plot for making a graph of the dataset
plot(meuse)

# the legent is related to the variable, in this case Zinc
spplot(meuse, "zinc")

# exercise: plot the aspatial amount of copper, with "main" i create the title of the graph
spplot(meuse, "copper", main="copper concentration")

# We changed the way we see the point in the graph 
bubble(meuse, "zinc")

# Exercise: bubble copper in red
bubble(meuse, "copper", main="Copper concentration", col="red")

##importing new data
# download covid_agg.csv from iol and build a folder called lab into C:
# put the covid_agg.csv file into the folder lab 

# setting the working directory: lab
# Windows
setwd("C:/lab/")

#it's imp to put the head to insert the title of the column using TRUE
covid <- read.table("covid_agg.csv", head=TRUE)
head(covid)

attach(covid)
plot(country, cases)

# in case you do not attach covid you should use the dollar, plot(covid$country, covid$cases)

plot(country, cases, las=0) #parallel lables
plot(country, cases, las=1) #horizontal lables
plot(country, cases, las=2) #perpendiicular lables
plot(country, cases, las=3) #vertical lables
plot(country, cases, las=3) 

# ggplot2 package
install.packages("ggplot2")
library(ggplot2) # require(ggplot2)

 # save the .RData under the menu File

# load the previously saved .RData
setwd("C:/lab/")

load("spatial.RData")
ls()

#covid
install.packages("ggplot2")
library(ggplot) #require(ggplot2)
data(mpg)
head(mpg)
# key components: data, aes, geometry
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()

# we can change the geometry of the graph 
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()

head(covid)
# aes= variable we want to plot, size=dimensions of point, geom = geometry of the point
ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()

