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
