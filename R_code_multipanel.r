### Multipanel in R: second lecture of monitorin ecosystem

install.packages("sp")
install.packages("GGally")

library(sp) # require(sp) will also do the job

data(meuse) #there is a dataset aviable named meuse

attach(meuse)

# Excercise: see the names of the variables and plot cadium versus zinc 
# There are two manners to see the names of the variables:
names(meuse)
head(meuse) # i see just the first six lines
plot(cadmium,zinc,pch=15,col="red",cex=2) #cex is the carachter exageration

#exercise : make all the possible paiwis plots of the dataset
# plot(x,cadmium)
# plot(x,zinc)
...

pairs(meuse)
# in case you recive the error "the size is too large" reshape with the mouse the graph window

pairs(~ cadmium + copper + lead + zinc, data=meuse)

pairs(meuse[,3:6]) #subset of meuse dataset since column 3 to 6, another way for do it, is like the previews one

# Exercise: prettify the graph
pairs(meuse[,3:6],pch=8,col="purple",cex=2)

#GGally package will prettify the graph
library(GGally)
ggpairs(meuse[,3:6])
