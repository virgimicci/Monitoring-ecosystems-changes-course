# R code for spatial view of points

library(sp)

data(meuse)
head(meuse)

# coordinates of this spatial dataset, we have to explain that are under x and y 
coordinates(meuse) = ~x+y

# we can put a plot for making a graph of the dataset
plot(meuse)

# the legent id related to the variable, in this case Zinc
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



