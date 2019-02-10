print("using seq_along() which makes an integer that is the length of the variable")
for(i in seq_along(x)) {
	print(x[i])
}
for(i in 1:4) print(x[i])
#### Loop with no need for the values
for(i in 1:10) {
	print(i)
}
x <- matrix(1:6, 2,3)
# print rows in a matrix
for(i in seq_len(nrow(x))) {
	for(j in seq_len(ncol(x))) {
		print(x[i,j])
	}
}
# print columns in a matrix
for(i in seq_len(ncol(x))) {
	print("col ")
	print(i)
	for(j in seq_len(nrow(x))) {
		print(x[j,i])
	}
}
for(i in 1:100){
	if (i <= 20){
next # skip this itteration like continue
}
print(i)
}
##### While loops
count <- 0
while(count < 10){
	print(count)
	count <- count +1
}
# random walk towards 3 or 10
z  <- 5
while(z >= 3 && z <=10){
	print(z)
	coin <- rbinom(1,1,0.5)
	if(coin == 1){
		z <- z+1
		} else {
			z <- z-1
		}
	}
##### Repeat loop
# optimze until you are close to a convergance (not all algorythms converge)
x0 <- 1
tol <- 1e-8 #tollerance, lower tollerance will run longer
repeat {
	x1 <- computeEstimate()
	if(abs(x1 - x0) < tol){
		break
		}else {
			x0 <- x1
		}
	}
	above <- function(x, n){
		use <- x > n
		x[use]
	}
	above <- function(x, n){
		use <- x > n
		x[use]
	}
	x <- 1:20
	above(x)
	above <- function(x, n){
		use <- x > 3
		x[use]
	}
	x <- 1:20
# should throw an error because n was needed and not passed
above(x)
add2 <- function(x,y){
	x + y
}
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# throws no error because n was not needed
above3(x)
# gets alll members of an array which are above n
above <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# should throw an error because n was needed and not passed
above(x)
add2 <- function(x,y){
	x + y
}
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# throws no error because n was not needed
above3(x)
# gets alll members of an array which are above n
above <- function(x, n){
	use <- x > n
	x[use]
}
x <- 1:20
# should throw an error because n was needed and not passed
above(x)
add2 <- function(x,y){
	x + y
}
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# throws no error because n was not needed
above3(x)
# gets alll members of an array which are above n
above <- function(x, n){
	use <- x > n
	x[use]
}
x <- 1:20
# should throw an error because n was needed and not passed
above(x)
# Error in above(x) : argument "n" is missing, with no default
above(x, 5)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
airquality
# calculate the mean of each column
columnmean <- function(y){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i])  #
}
means # last expression is returned
}
columnmean(airquality)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  #
}
means # last expression is returned
}
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the columsn, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality,FALSE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
airquality
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	if(i == 1)
	next
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print("column")
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
class(columnmean)
formals(columnmean)
formals(mean)
# You can find out the arguments and their defaults
formals(columnmean)
formals(mean)
formals(sd)
mydata <- rnorm(100)
sd(mydata)
sd(x=mydata)
sd(x=mydata)
sd(x=mydata, na.rm = FALSE)
sd(na.rm = FALSE, x=mydata)
sd(mydata, true)
sd(mydata, TRUE)
sd(y=mydata, na.rm = FALSE)
args(lm)
lm(data= mydata, y-x, model =FALSE, 1:100) # super confusing but possible
lm(data= mydata, y - x, model =FALSE, 1:100) # super confusing but possible
args(paste)
args(cat)
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	cat("column", i)
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i) # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i, "\n") # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
paste("a","b", sep =":")
paste("a","b","c", se =":")#
paste("a","b","c", sep ="SEPERATTOR")
paste("a","b","c", se ="thiswill come out as another arugment, not a seperator")# interesting error that is hard to spot
args(cat)

library(caret); library(kernlab); data(spam)
install.packages("caret")
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
head(inTrain)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
head(testing)
dim(training)
dim(testing)
}
columnmean(airquality)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  #
}
means # last expression is returned
}
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the columsn, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality,FALSE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
airquality
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	if(i == 1)
	next
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print("column")
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
class(columnmean)
formals(columnmean)
formals(mean)
# You can find out the arguments and their defaults
formals(columnmean)
formals(mean)
formals(sd)
mydata <- rnorm(100)
sd(mydata)
sd(x=mydata)
sd(x=mydata)
sd(x=mydata, na.rm = FALSE)
sd(na.rm = FALSE, x=mydata)
sd(mydata, true)
sd(mydata, TRUE)
sd(y=mydata, na.rm = FALSE)
args(lm)
lm(data= mydata, y-x, model =FALSE, 1:100) # super confusing but possible
lm(data= mydata, y - x, model =FALSE, 1:100) # super confusing but possible
args(paste)
args(cat)
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	cat("column", i)
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i) # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i, "\n") # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
paste("a","b", sep =":")
paste("a","b","c", se =":")#
paste("a","b","c", sep ="SEPERATTOR")
paste("a","b","c", se ="thiswill come out as another arugment, not a seperator")# interesting error that is hard to spot
args(cat)

library(caret); library(kernlab); data(spam)
install.packages("caret")
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
head(inTrain)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
head(testing)
dim(training)
dim(testing)

set.seed(32343)
modelFit <- train(type ~., data=training, method="glm")
train(type ~., data=training, method="glm")
# install.packages("e1071")
install.packages("e1071")
train(type ~., data=training, method="glm")
modelFit <- train(type ~., data=training, method="glm")
summary(modelFit)
str(modelFit)
modelFit
modelFit$finalModel
predictions <- predict(modelFit, newdata=testing)
predictions
confusionMatrix(predictions, testing$type)

x
airquality
knn3(training, outcome, k = 2)
?knn3
knn3(training, k = 2)
knn3(training,  type ,k = 2)
knn3(training,  "type" ,k = 2)
knn3(training,  training$type ,k = 2)
# from the kuhn tutorial
fit <- knn3(training,  training$type ,k = 2)
plot(fit)
fit
predict(fit, testing)
data(segmentationData)
segmentationData$Cell <- NUll
segmentationData$Cell <- NULL
head(segmentationData)
head(segmentationData$Cell)
head(segmentationData$Hi)
# can drop columns by assigning the column as NULL
training <- subset(segmentationData, Case == "Train")
head (training)
testing <- subset(segmentationData, Case == "Test")
training$Case <- NULL
# remove case from the  data since it will predcit 100% of case?
testing$Case <- NULL
str(training[,1:6])
trainX <- training[, names(training) != "Class"]
head(trainX)
## Methods are "BoxCox", "YeoJohnson", center", "scale",
> ## "range", "knnImpute", "bagImpute", "pca", "ica" and
    > ## "spatialSign"
#estimate the standardization parameters:
preProcValues <- preProcess(trainX, method=c("center","scale"))
preProcValues
scaledTrain <- predict(preProcValues, trainX)
class(preProcValues)
# this said it wanted the data to be centered and scaled
scaledTrain <- predict(preProcValues, trainX)
# this uses the preProcess function applied to the trainX data to get a scalled training data?
# how to plot the kmeans resampling errors
# http://stats.stackexchange.com/questions/21572/how-to-plot-decision-boundary-of-a-k-nearest-neighbor-classifier-from-elements-o
library(ElemStatLearn)
install.packages("ElemStatLearn")
library(ElemStatLearn)
require(class)
x <- mixture.example$x
g <- mixture.example$y
xnew <- mixture.example$xnew
mod15 <- knn(x, xnew, g, k=15, prob=TRUE)
prob <- attr(mod15, "prob")
prob <- ifelse(mod15=="1", prob, 1-prob)
px1 <- mixture.example$px1
px2 <- mixture.example$px2
prob15 <- matrix(prob, length(px1), length(px2))
par(mar=rep(2,4))
contour(px1, px2, prob15, levels=0.5, labels="", xlab="", ylab="", main=
	"15-nearest neighbour", axes=FALSE)
points(x, col=ifelse(g==1, "coral", "cornflowerblue"))
gd <- expand.grid(x=px1, y=px2)
points(gd, pch=".", cex=1.2, col=ifelse(prob15>0.5, "coral", "cornflowerblue"))
box()
# trees: use the variables to find ones that split the data into groups, keep branching until all data points are accounted for in the leaves (somethign liek this...)
# RWeka has trees
library(rprat)
library(rpart)
rpart1 <- rpart(Class ~., data= training, control = rpart.control(maxdepth = 2))
rpart1
# adding too much depth will usually result in overfitting, c.a.d more depth reasults in a tighter fit
rpart1 <- rpart(Class ~., data= training, control = rpart.control(maxdepth = 4))
rpart1
rpart1a <- as.party(rpart1)
library(partykit)
install.packages("partykit")
rpart1a <- as.party(rpart1)
import(partykit)
library(partykit)
rpart1a <- as.party(rpart1)
plot(rpart1a)
# it showed the decision tree
rpart1 <- rpart(Class ~., data= training, control = rpart.control(maxdepth = 2))
rpart1a <- as.party(rpart1)
plot(rpart1a)
# yes, more depth means more fit. you can generate a large tree, and then prune to keep only terminal nodes with a certain size (so all branches aren't the same height)
rpart1 <- rpart(Class ~., data= training, control = rpart.control(maxdepth = 12))
rpart1a <- as.party(rpart1)
plot(rpart1a)
# it looks like by default they arent the same height
rpart1a
# Fitted party:
# [1] root
# |   [2] TotalIntenCh2 < 45324.5
# |   |   [3] IntenCoocASMCh3 < 0.60218: PS (n = 447, err = 6.0%)
# |   |   [4] IntenCoocASMCh3 >= 0.60218: WS (n = 7, err = 0.0%)
# |   [5] TotalIntenCh2 >= 45324.5
# |   |   [6] FiberWidthCh1 < 9.67325
# |   |   |   [7] AvgIntenCh1 < 323.92429: PS (n = 139, err = 23.7%)
# |   |   |   [8] AvgIntenCh1 >= 323.92429: WS (n = 15, err = 6.7%)
# |   |   [9] FiberWidthCh1 >= 9.67325
# |   |   |   [10] ConvexHullAreaRatioCh1 >= 1.17362
# |   |   |   |   [11] VarIntenCh4 >= 172.01649: PS (n = 19, err = 10.5%)
# |   |   |   |   [12] VarIntenCh4 < 172.01649
# |   |   |   |   |   [13] KurtIntenCh3 < 4.05017: PS (n = 24, err = 33.3%)
# |   |   |   |   |   [14] KurtIntenCh3 >= 4.05017: WS (n = 20, err = 20.0%)
# |   |   |   [15] ConvexHullAreaRatioCh1 < 1.17362
# |   |   |   |   [16] ShapeP2ACh1 >= 1.30405
# |   |   |   |   |   [17] AvgIntenCh4 >= 375.20503: PS (n = 17, err = 11.8%)
# |   |   |   |   |   [18] AvgIntenCh4 < 375.20503
# |   |   |   |   |   |   [19] LengthCh1 < 20.92921: PS (n = 10, err = 30.0%)
# |   |   |   |   |   |   [20] LengthCh1 >= 20.92921
# |   |   |   |   |   |   |   [21] NeighborMinDistCh1 < 22.02943
# |   |   |   |   |   |   |   |   [22] AvgIntenCh1 < 110.64524: PS (n = 16, err = 18.8%)
# |   |   |   |   |   |   |   |   [23] AvgIntenCh1 >= 110.64524: WS (n = 16, err = 6.2%)
# |   |   |   |   |   |   |   [24] NeighborMinDistCh1 >= 22.02943: WS (n = 120, err = 14.2%)
# |   |   |   |   [25] ShapeP2ACh1 < 1.30405: WS (n = 159, err = 11.9%)
# Number of inner nodes:    12
# Number of terminal nodes: 13
# ah yes, by default rpart will do as many splits as possible then prune the tree and keep the depth we requested
# it keeps the simplest tree within 1 Standard error of the best tree
rpartFull <- rpart(Class, ~., data = training)
rpartFull <- rpart(Class ~., data = training)
rpartFull
rpartPred <- predict(rpartFull, testing, type= "class")
confusionMatrix(rpartPred, testing$Class)
?train
train(Class ~., data=training, method="rpart")
train(Class ~., data=training, method="rpart", tuneLength=30)
cvCtrl <- trainControl(method = "repeatedcv", repeats=3)
#use the repeated 10fold cross validation instead of the default bootstrap
train(Class ~., data=training, method = "rpart", tuneLength = 30, tvControl = cvCtrl)
fakeData <- data.frame(pred = testing$Class, obs = sample(testing$Class), PS = runif(nrow(testing)))
head(fakeData)
twoClassSummary(fakeData, lev= levels(fakeData$obs))
install.packages("pROC")
library(pROC)
twoClassSummary(fakeData, lev= levels(fakeData$obs))
plot(twoClassSummary(fakeData, lev= levels(fakeData$obs)))
cvCtrl <- trainControl(method = "repeatedcv", repeats=3, summaryFunction = twoClassSummary, classProbs = TRUE)
set.seed(1)
rpartTune <- train(Class ~., data = training, method = "rpart", tuneLength = 30, metric = "ROC", trControl = cvCtrl)
rpartTune
plot.train(rpartTune)
# plots the trained model as a function of the CP (complexity parameter)
print.train(rpartTune)
rpartPred2 <- predict(rpartTune, testing)
confusionMatrix(rpartPred2, testing$Class)
rpartProbs <- predict(rpartTune, testing, type = "prob")
head(rpartProbs)
rpartROC <- roc(testing$Class, rpartProbs[, "PS"], levels = rev(testProbs$Class))
rpartROC <- roc(testing$Class, rpartProbs[, "PS"], levels = rev(rpartProbs$Class))
rpartROC <- roc(testing$Class, rpartProbs[, "PS"])
plot(rpartROC, type = "S", print.thres = .5)
plot(rpartROC, type = "S", print.thres = .8)
plot(rpartROC, type = "S", print.thres = .5)
library(doMC)
install.packages("doMC")
library(doMC)
registerDoMC(cors)
registerDoMC(cores = 2)

##### While loops
count <- 0
while(count < 10){
	print(count)
	count <- count +1
}
# random walk towards 3 or 10
z  <- 5
while(z >= 3 && z <=10){
	print(z)
	coin <- rbinom(1,1,0.5)
	if(coin == 1){
		z <- z+1
		} else {
			z <- z-1
		}
	}
##### Repeat loop
# optimze until you are close to a convergance (not all algorythms converge)
x0 <- 1
tol <- 1e-8 #tollerance, lower tollerance will run longer
repeat {
	x1 <- computeEstimate()
	if(abs(x1 - x0) < tol){
		break
		}else {
			x0 <- x1
		}
	}
	above <- function(x, n){
		use <- x > n
		x[use]
	}
	above <- function(x, n){
		use <- x > n
		x[use]
	}
	x <- 1:20
	above(x)
	above <- function(x, n){
		use <- x > 3
		x[use]
	}
	x <- 1:20
# should throw an error because n was needed and not passed
above(x)
add2 <- function(x,y){
	x + y
}
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# throws no error because n was not needed
above3(x)
# gets alll members of an array which are above n
above <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# should throw an error because n was needed and not passed
above(x)
add2 <- function(x,y){
	x + y
}
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# throws no error because n was not needed
above3(x)
# gets alll members of an array which are above n
above <- function(x, n){
	use <- x > n
	x[use]
}
x <- 1:20
# should throw an error because n was needed and not passed
above(x)
add2 <- function(x,y){
	x + y
}
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# throws no error because n was not needed
above3(x)
# gets alll members of an array which are above n
above <- function(x, n){
	use <- x > n
	x[use]
}
x <- 1:20
# should throw an error because n was needed and not passed
above(x)
# Error in above(x) : argument "n" is missing, with no default
above(x, 5)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
airquality
# calculate the mean of each column
columnmean <- function(y){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i])  #
}
means # last expression is returned
}
columnmean(airquality)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  #
}
means # last expression is returned
}
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the columsn, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality,FALSE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
airquality
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	if(i == 1)
	next
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print("column")
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
class(columnmean)
formals(columnmean)
formals(mean)
# You can find out the arguments and their defaults
formals(columnmean)
formals(mean)
formals(sd)
mydata <- rnorm(100)
sd(mydata)
sd(x=mydata)
sd(x=mydata)
sd(x=mydata, na.rm = FALSE)
sd(na.rm = FALSE, x=mydata)
sd(mydata, true)
sd(mydata, TRUE)
sd(y=mydata, na.rm = FALSE)
args(lm)
lm(data= mydata, y-x, model =FALSE, 1:100) # super confusing but possible
lm(data= mydata, y - x, model =FALSE, 1:100) # super confusing but possible
args(paste)
args(cat)
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	cat("column", i)
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i) # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i, "\n") # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
paste("a","b", sep =":")
paste("a","b","c", se =":")#
paste("a","b","c", sep ="SEPERATTOR")
paste("a","b","c", se ="thiswill come out as another arugment, not a seperator")# interesting error that is hard to spot
args(cat)
names(spam)
library(kernlab)
names(spam)
data(spam)
names(spam)
library(ISLR)
library(caret)
data(Wage)
inTrain <- createDataPartition(y=Wage$wage, p = 0.7, list= FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
table(training$jobclass)
dummies <- dummVars(wage ~jobclass, data=training)
dummies <- dummyVars(wage ~jobclass, data=training)
head(predict(dummies, newdata=training))
nsv <- nearZeroVar(training, saveMetrics=TRUE)
nsv
#            freqRatio percentUnique zeroVar   nzv
# year        1.138889    0.33301618   FALSE FALSE
# age         1.166667    2.85442436   FALSE FALSE
# sex         0.000000    0.04757374    TRUE  TRUE
# maritl      3.251670    0.23786870   FALSE FALSE
# race        8.098131    0.19029496   FALSE FALSE
# education   1.413934    0.23786870   FALSE FALSE
# region      0.000000    0.04757374    TRUE  TRUE
# jobclass    1.116818    0.09514748   FALSE FALSE
# health      2.429038    0.09514748   FALSE FALSE
# health_ins  2.170437    0.09514748   FALSE FALSE
# logwage     1.000000   19.74310181   FALSE FALSE
# wage        1.000000   19.74310181   FALSE FALSE
library(splines)
bsBasis <- bs(training$age, df=3)
bsBasis
# fit curving lines to the ata
# use a 3rd degree polynomial
lm1 <- lm(wage~bsBasis, data=training)
# using rpedictors from polnomia data (age, age^2 and age^3)
plot(training$age, training$wage, pch=19, cex=0.5)
points(trianing$age, predict(lm1, newdata=training), col="red", pch=19,cex=0.5)
points(training$age, predict(lm1, newdata=training), col="red", pch=19,cex=0.5)
predict(bsBasis, age=testing$age)

# install.packages("caret")
# install.packages("e1071")
library(caret); library(kernlab); data(spam)

# use the createDataPartition function to make training and test sets
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
head(inTrain)
training <- spam[inTrain,]
# testing will be the complement of the training set
testing <- spam[-inTrain,]
head(testing)
dim(training)
dim(testing)

set.seed(32343)
# train a model using all the 57 variables  except type (type ~.) with the GML method
modelFit <- train(type ~., data=training, method="glm")
	# modelFit
	# Generalized Linear Model 

	# 3451 samples
	# 57 predictor
	# 2 classes: 'nonspam', 'spam' 

	# No pre-processing
	# Resampling: Bootstrapped (25 reps) 

	# Summary of sample sizes: 3451, 3451, 3451, 3451, 3451, 3451, ... 

	# Resampling results

	# Accuracy  Kappa  Accuracy SD  Kappa SD
	# 0.924     0.84   0.00699      0.0146  


# View the cooeficients for the final model for each variable 
modelFit$finalModel

# run the model on the testing data to get its predictions
predictions <- predict(modelFit, newdata=testing)
predictions

# See how well the model performed
confusionMatrix(predictions, testing$type)
# Confusion Matrix and Statistics

#           Reference
# Prediction nonspam spam
#    nonspam     662   58
#    spam         35  395

#                Accuracy : 0.9191          
#                  95% CI : (0.9018, 0.9342)
#     No Information Rate : 0.6061          
#     P-Value [Acc > NIR] : < 2e-16         

#                   Kappa : 0.8291          
#  Mcnemar's Test P-Value : 0.02253         

#             Sensitivity : 0.9498          
#             Specificity : 0.8720          
#          Pos Pred Value : 0.9194          
#          Neg Pred Value : 0.9186          
#              Prevalence : 0.6061          
#          Detection Rate : 0.5757          
#    Detection Prevalence : 0.6261          
#       Balanced Accuracy : 0.9109          

#        'Positive' Class : nonspam   

knn3(training, outcome, k = 2)
?knn3
knn3(training, k = 2)
knn3(training,  type ,k = 2)
knn3(training,  "type" ,k = 2)
knn3(training,  training$type ,k = 2)
# from the kuhn tutorial
fit <- knn3(training,  training$type ,k = 2)
plot(fit)
fit
predict(fit, testing)
data(segmentationData)
segmentationData$Cell <- NUll
segmentationData$Cell <- NULL
head(segmentationData)
head(segmentationData$Cell)
head(segmentationData$Hi)
# can drop columns by assigning the column as NULL
training <- subset(segmentationData, Case == "Train")
head (training)
testing <- subset(segmentationData, Case == "Test")
training$Case <- NULL
# remove case from the  data since it will predcit 100% of case?
testing$Case <- NULL
str(training[,1:6])
trainX <- training[, names(training) != "Class"]
head(trainX)
## Methods are "BoxCox", "YeoJohnson", center", "scale",
> ## "range", "knnImpute", "bagImpute", "pca", "ica" and
    > ## "spatialSign"
#estimate the standardization parameters:
preProcValues <- preProcess(trainX, method=c("center","scale"))
preProcValues
scaledTrain <- predict(preProcValues, trainX)
class(preProcValues)
# this said it wanted the data to be centered and scaled
scaledTrain <- predict(preProcValues, trainX)
# this uses the preProcess function applied to the trainX data to get a scalled training data?
# how to plot the kmeans resampling errors
# http://stats.stackexchange.com/questions/21572/how-to-plot-decision-boundary-of-a-k-nearest-neighbor-classifier-from-elements-o
library(ElemStatLearn)
install.packages("ElemStatLearn")
library(ElemStatLearn)
require(class)
x <- mixture.example$x
g <- mixture.example$y
xnew <- mixture.example$xnew
mod15 <- knn(x, xnew, g, k=15, prob=TRUE)
prob <- attr(mod15, "prob")
prob <- ifelse(mod15=="1", prob, 1-prob)
px1 <- mixture.example$px1
px2 <- mixture.example$px2
prob15 <- matrix(prob, length(px1), length(px2))
par(mar=rep(2,4))
contour(px1, px2, prob15, levels=0.5, labels="", xlab="", ylab="", main=
	"15-nearest neighbour", axes=FALSE)
points(x, col=ifelse(g==1, "coral", "cornflowerblue"))
gd <- expand.grid(x=px1, y=px2)
points(gd, pch=".", cex=1.2, col=ifelse(prob15>0.5, "coral", "cornflowerblue"))
box()
# trees: use the variables to find ones that split the data into groups, keep branching until all data points are accounted for in the leaves (somethign liek this...)
# RWeka has trees
library(rprat)
library(rpart)
rpart1 <- rpart(Class ~., data= training, control = rpart.control(maxdepth = 2))
rpart1
# adding too much depth will usually result in overfitting, c.a.d more depth reasults in a tighter fit
rpart1 <- rpart(Class ~., data= training, control = rpart.control(maxdepth = 4))
rpart1
rpart1a <- as.party(rpart1)
library(partykit)
install.packages("partykit")
rpart1a <- as.party(rpart1)
import(partykit)
library(partykit)
rpart1a <- as.party(rpart1)
plot(rpart1a)
# it showed the decision tree
rpart1 <- rpart(Class ~., data= training, control = rpart.control(maxdepth = 2))
rpart1a <- as.party(rpart1)
plot(rpart1a)
# yes, more depth means more fit. you can generate a large tree, and then prune to keep only terminal nodes with a certain size (so all branches aren't the same height)
rpart1 <- rpart(Class ~., data= training, control = rpart.control(maxdepth = 12))
rpart1a <- as.party(rpart1)
plot(rpart1a)
# it looks like by default they arent the same height
rpart1a
# Fitted party:
# [1] root
# |   [2] TotalIntenCh2 < 45324.5
# |   |   [3] IntenCoocASMCh3 < 0.60218: PS (n = 447, err = 6.0%)
# |   |   [4] IntenCoocASMCh3 >= 0.60218: WS (n = 7, err = 0.0%)
# |   [5] TotalIntenCh2 >= 45324.5
# |   |   [6] FiberWidthCh1 < 9.67325
# |   |   |   [7] AvgIntenCh1 < 323.92429: PS (n = 139, err = 23.7%)
# |   |   |   [8] AvgIntenCh1 >= 323.92429: WS (n = 15, err = 6.7%)
# |   |   [9] FiberWidthCh1 >= 9.67325
# |   |   |   [10] ConvexHullAreaRatioCh1 >= 1.17362
# |   |   |   |   [11] VarIntenCh4 >= 172.01649: PS (n = 19, err = 10.5%)
# |   |   |   |   [12] VarIntenCh4 < 172.01649
# |   |   |   |   |   [13] KurtIntenCh3 < 4.05017: PS (n = 24, err = 33.3%)
# |   |   |   |   |   [14] KurtIntenCh3 >= 4.05017: WS (n = 20, err = 20.0%)
# |   |   |   [15] ConvexHullAreaRatioCh1 < 1.17362
# |   |   |   |   [16] ShapeP2ACh1 >= 1.30405
# |   |   |   |   |   [17] AvgIntenCh4 >= 375.20503: PS (n = 17, err = 11.8%)
# |   |   |   |   |   [18] AvgIntenCh4 < 375.20503
# |   |   |   |   |   |   [19] LengthCh1 < 20.92921: PS (n = 10, err = 30.0%)
# |   |   |   |   |   |   [20] LengthCh1 >= 20.92921
# |   |   |   |   |   |   |   [21] NeighborMinDistCh1 < 22.02943
# |   |   |   |   |   |   |   |   [22] AvgIntenCh1 < 110.64524: PS (n = 16, err = 18.8%)
# |   |   |   |   |   |   |   |   [23] AvgIntenCh1 >= 110.64524: WS (n = 16, err = 6.2%)
# |   |   |   |   |   |   |   [24] NeighborMinDistCh1 >= 22.02943: WS (n = 120, err = 14.2%)
# |   |   |   |   [25] ShapeP2ACh1 < 1.30405: WS (n = 159, err = 11.9%)
# Number of inner nodes:    12
# Number of terminal nodes: 13 
# ah yes, by default rpart will do as many splits as possible then prune the tree and keep the depth we requested
# it keeps the simplest tree within 1 Standard error of the best tree
rpartFull <- rpart(Class, ~., data = training)
rpartFull <- rpart(Class ~., data = training)
rpartFull
rpartPred <- predict(rpartFull, testing, type= "class")
confusionMatrix(rpartPred, testing$Class)
?train
train(Class ~., data=training, method="rpart")
train(Class ~., data=training, method="rpart", tuneLength=30)
cvCtrl <- trainControl(method = "repeatedcv", repeats=3)
#use the repeated 10fold cross validation instead of the default bootstrap
train(Class ~., data=training, method = "rpart", tuneLength = 30, tvControl = cvCtrl)
fakeData <- data.frame(pred = testing$Class, obs = sample(testing$Class), PS = runif(nrow(testing)))
head(fakeData)
twoClassSummary(fakeData, lev= levels(fakeData$obs))
install.packages("pROC")
library(pROC)
twoClassSummary(fakeData, lev= levels(fakeData$obs))
plot(twoClassSummary(fakeData, lev= levels(fakeData$obs)))
cvCtrl <- trainControl(method = "repeatedcv", repeats=3, summaryFunction = twoClassSummary, classProbs = TRUE)
set.seed(1)
rpartTune <- train(Class ~., data = training, method = "rpart", tuneLength = 30, metric = "ROC", trControl = cvCtrl)
rpartTune
plot.train(rpartTune)
# plots the trained model as a function of the CP (complexity parameter)
print.train(rpartTune)
rpartPred2 <- predict(rpartTune, testing)
confusionMatrix(rpartPred2, testing$Class)
rpartProbs <- predict(rpartTune, testing, type = "prob")
head(rpartProbs)
rpartROC <- roc(testing$Class, rpartProbs[, "PS"], levels = rev(testProbs$Class))
rpartROC <- roc(testing$Class, rpartProbs[, "PS"], levels = rev(rpartProbs$Class))
rpartROC <- roc(testing$Class, rpartProbs[, "PS"])
plot(rpartROC, type = "S", print.thres = .5)
plot(rpartROC, type = "S", print.thres = .8)
plot(rpartROC, type = "S", print.thres = .5)
library(doMC)
install.packages("doMC")
library(doMC)
registerDoMC(cors)
registerDoMC(cores = 2)


x + y
}
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# throws no error because n was not needed
above3(x)
# gets alll members of an array which are above n
above <- function(x, n){
	use <- x > n
	x[use]
}
x <- 1:20
# should throw an error because n was needed and not passed
above(x)
add2 <- function(x,y){
	x + y
}
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
x <- 1:20
# throws no error because n was not needed
above3(x)
# gets alll members of an array which are above n
above <- function(x, n){
	use <- x > n
	x[use]
}
x <- 1:20
# should throw an error because n was needed and not passed
above(x)
# Error in above(x) : argument "n" is missing, with no default
above(x, 5)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
airquality
# calculate the mean of each column
columnmean <- function(y){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i])  #
}
means # last expression is returned
}
columnmean(airquality)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  #
}
means # last expression is returned
}
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the columsn, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality,FALSE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
airquality
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	if(i == 1)
	next
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print("column")
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
class(columnmean)
formals(columnmean)
formals(mean)
# You can find out the arguments and their defaults
formals(columnmean)
formals(mean)
formals(sd)
mydata <- rnorm(100)
sd(mydata)
sd(x=mydata)
sd(x=mydata)
sd(x=mydata, na.rm = FALSE)
sd(na.rm = FALSE, x=mydata)
sd(mydata, true)
sd(mydata, TRUE)
sd(y=mydata, na.rm = FALSE)
args(lm)
lm(data= mydata, y-x, model =FALSE, 1:100) # super confusing but possible
lm(data= mydata, y - x, model =FALSE, 1:100) # super confusing but possible
args(paste)
args(cat)
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	cat("column", i)
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i) # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i, "\n") # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
paste("a","b", sep =":")
paste("a","b","c", se =":")#
paste("a","b","c", sep ="SEPERATTOR")
paste("a","b","c", se ="thiswill come out as another arugment, not a seperator")# interesting error that is hard to spot
args(cat)
names(spam)
library(kernlab)
names(spam)
data(spam)
names(spam)
library(ISLR)
library(caret)
data(Wage)
inTrain <- createDataPartition(y=Wage$wage, p = 0.7, list= FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
table(training$jobclass)
dummies <- dummVars(wage ~jobclass, data=training)
dummies <- dummyVars(wage ~jobclass, data=training)
head(predict(dummies, newdata=training))
nsv <- nearZeroVar(training, saveMetrics=TRUE)
nsv
#            freqRatio percentUnique zeroVar   nzv
# year        1.138889    0.33301618   FALSE FALSE
# age         1.166667    2.85442436   FALSE FALSE
# sex         0.000000    0.04757374    TRUE  TRUE
# maritl      3.251670    0.23786870   FALSE FALSE
# race        8.098131    0.19029496   FALSE FALSE
# education   1.413934    0.23786870   FALSE FALSE
# region      0.000000    0.04757374    TRUE  TRUE
# jobclass    1.116818    0.09514748   FALSE FALSE
# health      2.429038    0.09514748   FALSE FALSE
# health_ins  2.170437    0.09514748   FALSE FALSE
# logwage     1.000000   19.74310181   FALSE FALSE
# wage        1.000000   19.74310181   FALSE FALSE
library(splines)
bsBasis <- bs(training$age, df=3)
bsBasis
# fit curving lines to the ata
# use a 3rd degree polynomial
lm1 <- lm(wage~bsBasis, data=training)
# using rpedictors from polnomia data (age, age^2 and age^3)
plot(training$age, training$wage, pch=19, cex=0.5)
points(trianing$age, predict(lm1, newdata=training), col="red", pch=19,cex=0.5)
points(training$age, predict(lm1, newdata=training), col="red", pch=19,cex=0.5)
predict(bsBasis, age=testing$age)

library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
M <- abs(cor(training[,58]))
M <- abs(cor(training[,-58]))
diag(M) <-0
which(M > 0.8, arr.ind=T)
#-58 means leave out the category of the data taht we are tyring to rpdict
#empty out the diagonal to 0 because other wise it would be 1
then look for where the corelation is haghe rthan .8
names(spam)[c(34,32)]
plot(spam[,34],spam[,32])
# avoid including prictors that predict eachother so combine into one feature
#PCA
X <- 0.71*training$num415 + 0.71*training$num857
Y <- 071*training$num415 - 0.71*training$num857
plot(X,Y)
# matrix decomposition U D V
smallSpam <- spam[,c(34,32)]
head(smallSpam)
prComp <- prcomp(smallSpam)
plot(prComp$x[,1],prComp$x[,2])
# 34 and 32 were the two taht were highlyl correlated
#PCA1 = adding, PC2 looks like subtracting
prComp$rotation
typeColor <- ((spam$type=="spam")*1+1)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1],prComp$x[,2],col=typeColor, xlab="PC1", ylab="PC2")
# created PCA from the spam data set with out the type column
preProc <- preProcess(log10(spam[,-58]+1), method="pca",pcaComp=2)
spamPC <- predict(preProc,log10(spam[,-58]+1))
plot(spamPC[,1],spamPC[,2],col=typeColor)
trainPC <- predict(preProc, log10(training[,-58]+1))
modelFit <- train(training$type ~., method="glm",data=trainPC)
# hvve to use the same in the test
testPC <- predict(preProc, log10(testing[,-58]+1))
confusionMatrix(testing$type, predict(modelFit,testPc))
confusionMatrix(testing$type, predict(modelFit,testPC))
# now a high accuracy
# Confusion Matrix and Statistics
#           Reference
# Prediction nonspam spam
#    nonspam     651   46
#    spam         52  401
#                Accuracy : 0.9148
#                  95% CI : (0.8971, 0.9303)
#     No Information Rate : 0.6113
#     P-Value [Acc > NIR] : <2e-16
#                   Kappa : 0.8211
#  Mcnemar's Test P-Value : 0.6135
#             Sensitivity : 0.9260
#             Specificity : 0.8971
#          Pos Pred Value : 0.9340
#          Neg Pred Value : 0.8852
#              Prevalence : 0.6113
#          Detection Rate : 0.5661
#    Detection Prevalence : 0.6061
#       Balanced Accuracy : 0.9116
#        'Positive' Class : nonspam
# principal component is good for linear modles and harder to predict
# the meaning of the model
# outliers can wreak havoc on PCA
# plot predictors to see the problems

nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i])  #
}
means # last expression is returned
}
columnmean(airquality)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  #
}
means # last expression is returned
}
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the columsn, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality,FALSE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
airquality
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	if(i == 1)
	next
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print("column")
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
class(columnmean)
formals(columnmean)
formals(mean)
# You can find out the arguments and their defaults
formals(columnmean)
formals(mean)
formals(sd)
mydata <- rnorm(100)
sd(mydata)
sd(x=mydata)
sd(x=mydata)
sd(x=mydata, na.rm = FALSE)
sd(na.rm = FALSE, x=mydata)
sd(mydata, true)
sd(mydata, TRUE)
sd(y=mydata, na.rm = FALSE)
args(lm)
lm(data= mydata, y-x, model =FALSE, 1:100) # super confusing but possible
lm(data= mydata, y - x, model =FALSE, 1:100) # super confusing but possible
args(paste)
args(cat)
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	cat("column", i)
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i) # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i, "\n") # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
paste("a","b", sep =":")
paste("a","b","c", se =":")#
paste("a","b","c", sep ="SEPERATTOR")
paste("a","b","c", se ="thiswill come out as another arugment, not a seperator")# interesting error that is hard to spot
args(cat)
names(spam)
library(kernlab)
names(spam)
data(spam)
names(spam)
library(ISLR)
library(caret)
data(Wage)
inTrain <- createDataPartition(y=Wage$wage, p = 0.7, list= FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
table(training$jobclass)
dummies <- dummVars(wage ~jobclass, data=training)
dummies <- dummyVars(wage ~jobclass, data=training)
head(predict(dummies, newdata=training))
nsv <- nearZeroVar(training, saveMetrics=TRUE)
nsv
#            freqRatio percentUnique zeroVar   nzv
# year        1.138889    0.33301618   FALSE FALSE
# age         1.166667    2.85442436   FALSE FALSE
# sex         0.000000    0.04757374    TRUE  TRUE
# maritl      3.251670    0.23786870   FALSE FALSE
# race        8.098131    0.19029496   FALSE FALSE
# education   1.413934    0.23786870   FALSE FALSE
# region      0.000000    0.04757374    TRUE  TRUE
# jobclass    1.116818    0.09514748   FALSE FALSE
# health      2.429038    0.09514748   FALSE FALSE
# health_ins  2.170437    0.09514748   FALSE FALSE
# logwage     1.000000   19.74310181   FALSE FALSE
# wage        1.000000   19.74310181   FALSE FALSE
library(splines)
bsBasis <- bs(training$age, df=3)
bsBasis
# fit curving lines to the ata
# use a 3rd degree polynomial
lm1 <- lm(wage~bsBasis, data=training)
# using rpedictors from polnomia data (age, age^2 and age^3)
plot(training$age, training$wage, pch=19, cex=0.5)
points(trianing$age, predict(lm1, newdata=training), col="red", pch=19,cex=0.5)
points(training$age, predict(lm1, newdata=training), col="red", pch=19,cex=0.5)
predict(bsBasis, age=testing$age)

library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
M <- abs(cor(training[,58]))
M <- abs(cor(training[,-58]))
diag(M) <-0
which(M > 0.8, arr.ind=T)
#-58 means leave out the category of the data taht we are tyring to rpdict
#empty out the diagonal to 0 because other wise it would be 1
then look for where the corelation is haghe rthan .8
names(spam)[c(34,32)]
plot(spam[,34],spam[,32])
# avoid including prictors that predict eachother so combine into one feature
#PCA
X <- 0.71*training$num415 + 0.71*training$num857
Y <- 071*training$num415 - 0.71*training$num857
plot(X,Y)
# matrix decomposition U D V
smallSpam <- spam[,c(34,32)]
head(smallSpam)
prComp <- prcomp(smallSpam)
plot(prComp$x[,1],prComp$x[,2])
# 34 and 32 were the two taht were highlyl correlated
#PCA1 = adding, PC2 looks like subtracting
prComp$rotation
typeColor <- ((spam$type=="spam")*1+1)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1],prComp$x[,2],col=typeColor, xlab="PC1", ylab="PC2")
# created PCA from the spam data set with out the type column
preProc <- preProcess(log10(spam[,-58]+1), method="pca",pcaComp=2)
spamPC <- predict(preProc,log10(spam[,-58]+1))
plot(spamPC[,1],spamPC[,2],col=typeColor)
trainPC <- predict(preProc, log10(training[,-58]+1))
modelFit <- train(training$type ~., method="glm",data=trainPC)
# hvve to use the same in the test
testPC <- predict(preProc, log10(testing[,-58]+1))
confusionMatrix(testing$type, predict(modelFit,testPc))
confusionMatrix(testing$type, predict(modelFit,testPC))
# now a high accuracy
# Confusion Matrix and Statistics
#           Reference
# Prediction nonspam spam
#    nonspam     651   46
#    spam         52  401
#                Accuracy : 0.9148
#                  95% CI : (0.8971, 0.9303)
#     No Information Rate : 0.6113
#     P-Value [Acc > NIR] : <2e-16
#                   Kappa : 0.8211
#  Mcnemar's Test P-Value : 0.6135
#             Sensitivity : 0.9260
#             Specificity : 0.8971
#          Pos Pred Value : 0.9340
#          Neg Pred Value : 0.8852
#              Prevalence : 0.6113
#          Detection Rate : 0.5661
#    Detection Prevalence : 0.6061
#       Balanced Accuracy : 0.9116
#        'Positive' Class : nonspam
# principal component is good for linear modles and harder to predict
# the meaning of the model
# outliers can wreak havoc on PCA
# plot predictors to see the problems

# linear regression is relatively easy to interpret
# predicting geiser eruptions
library(caret); data(faithful); set.seed(333)
inTrain <- createDataPartition(y=faithful$waiting, p=0.5, list=FALSE)
trainFaith <- faithful[inTrain,]; testFaith <- faithful[-inTrain,]
head(trainFaith)
str(trainFaith)
summary(trainFaith)
plot(trainFaith$waiting, trainFaith$eruption)
lm1 <- lm(eruptions ~ waiting, data=trainFaith)
summary(lm1)
# predict eruptions as a function of waiting
# intercept is b0
lines(trainFaith$waiting, lm1$fitted, lwd=3)
lm1.fitted
lm1$fitted
# get the estimated values of b0 and b1
coef(lm1)[1] + coef(lm1)[2]*80
#coef gets them out of the lm1
newdata <- data.frame(waiting=80)
# 80 was the new value
predict(lm1, newdata)
# prediction of the value eruptions if waiting is 80
par(mfrow=c(1,2))
plot(trainFaith$waiting, trainFaith$eruption, pch=19, col="blue",xlab="Waiting",ylab="Duration")
lines(trainFaith$waiting, predict(lm1), lwd=3)
plot(testFaith$waiting, testFaith$eruption, pch=19, col="blue",xlab="Waiting",ylab="Duration")
lines(testFaith$waiting, predict(lm1, newdata=testFatih), lwd=3)
lines(testFaith$waiting, predict(lm1, newdata=testFaith), lwd=3)
sqrt(sum((lm1$fitted-trainFaith$eruptions)^2))
sqrt(sum((predict(lm1, newdata=testFaith)--testFaith$eruptions)^2))
sqrt(sum((predict(lm1, newdata=testFaith)-testFaith$eruptions)^2))
pred1 <- predict(lm1, newdata=testFaith, interval = "prediction")
pred1 <- predict(lm1, newdata=testFaith, intervals = "prediction")
ord <- order(testFaith$waiting)
plot(testFaith$waiting, testFaith$eruptions, pch=19, col="bluew")
plot(testFaith$waiting, testFaith$eruptions, pch=19, col="blue")
matlines(testFaith$watiing[ord],pred1[ord,],type="l",,col=c(1,2,2))
modFit <- train(eruptions ~ waiting, data=trainFaith, method= "lm")
summary(modFit$finalModel)
# exploring a data set and finding good predictors
library(ISLR); library(ggplot2); library(caret)
data(Wage); Wage <- subset(Wage, select=-c(logwage)) # take the data that isnt the logwage variable
summary(Wage)
inTrain <- createDataPartition(y=Wage$wage, p0.7,list=FALSE)
inTrain <- createDataPartition(y=Wage$wage, p=0.7,list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]
dim(training);dim(testing)
featurePlot(x=training[,c("age","education","jobclass")])
featurePlot(x=training[,c("age","education","jobclass")], y=training$Wage)
featurePlot(x=training[,c("age","education","jobclass")], y=training$Wage,plot="pairs")
featurePlot(x=training[,c("age","education","jobclass")], y=training$wage, plot="pairs")
qplot(age,wage, data=training)
qplot(age,wage, data=training, color=jobclass)
qplot(age,wage, data=training, color=education)

# plot
modFit <- train(wage ~age + jobclass + education, method = "lm", data=training)
finMod <- modFit$finalModel
print(finMod)
plot(finMod, 1, pch=19,cex=0.5, col="#00000010")


plot(finMod, 1, pch=19,cex=0.5, col="#0000010")
plot(finMod, 1, pch=19,cex=0.5, col="#00000010")
# explore if the data collection changed over time
qplot(finMod$fitted, finMod$residuals, color=race, data=training)
plot(finMod$residulas, pch19)
plot(finMod$residulas, pch=19)
plot(finMod$residuals, pch=19)
pred <- predict(modFit, testing)
qplot(wage, pred,colour=year, data=testing)
modFitAll <- train(wage ~., data=training, method ="lm")
pred <- predict(modFitAll,testing)
qplot(wage,pred,data=testing)


use <- x > n
x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
airquality
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	if(i == 1)
	next
	print(y[i,])
means[i] <- mean(y[i,], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
add2 <- function(x,y){
	x + y
}
x <- 1:20
# gets all members of an array which are above 3
above3 <- function(x, n){
	use <- x > 3
	x[use]
}
# throws no error because n was not needed
above3(x)
# gets all members of an array which are above n
aboveNoDefault <- function(x, n){
	use <- x > n
	x[use]
}
# should throw an error because n was needed and not passed
aboveNoDefault(x)
# Error in aboveNoDefault(x) : argument "n" is missing, with no default
aboveNoDefault(x, 5)
# gets all members of an array which are above n (use 10 by default)
above <- function(x, n = 10){
	use <- x > n
	x[use]
}
# uses 10 by default
above(x)
# accepts an optional value
above(x, 5)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	print("column")
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
columnmean(airquality, TRUE)
columnmean(airquality)
class(columnmean)
formals(columnmean)
formals(mean)
# You can find out the arguments and their defaults
formals(columnmean)
formals(mean)
formals(sd)
mydata <- rnorm(100)
sd(mydata)
sd(x=mydata)
sd(x=mydata)
sd(x=mydata, na.rm = FALSE)
sd(na.rm = FALSE, x=mydata)
sd(mydata, true)
sd(mydata, TRUE)
sd(y=mydata, na.rm = FALSE)
args(lm)
lm(data= mydata, y-x, model =FALSE, 1:100) # super confusing but possible
lm(data= mydata, y - x, model =FALSE, 1:100) # super confusing but possible
args(paste)
args(cat)
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
	cat("column", i)
	print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i) # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
# calculate the mean of each column
columnmean <- function(y, removeNA = TRUE){
	nc <- ncol(y)
means <- numeric(nc)         # initialize a vector of 0s that is the length of incoming  y
for(i in 1:nc){              #  eg 1:20
cat("column", i, "\n") # print number of column we are on
# print(y[, i])
means[i] <- mean(y[ , i], na.rm = removeNA)  # use the mean function to get the mean of the column, removing npas is controlled by the user
}
means # last expression is returned
}
columnmean(airquality, FALSE)
paste("a","b", sep =":")
paste("a","b","c", se =":")#
paste("a","b","c", sep ="SEPERATTOR")
paste("a","b","c", se ="thiswill come out as another arugment, not a seperator")# interesting error that is hard to spot
args(cat)
names(spam)
library(kernlab)
names(spam)
data(spam)
names(spam)
library(ISLR)
library(caret)
data(Wage)
inTrain <- createDataPartition(y=Wage$wage, p = 0.7, list= FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
table(training$jobclass)
dummies <- dummVars(wage ~jobclass, data=training)
dummies <- dummyVars(wage ~jobclass, data=training)
head(predict(dummies, newdata=training))
nsv <- nearZeroVar(training, saveMetrics=TRUE)
nsv
#            freqRatio percentUnique zeroVar   nzv
# year        1.138889    0.33301618   FALSE FALSE
# age         1.166667    2.85442436   FALSE FALSE
# sex         0.000000    0.04757374    TRUE  TRUE
# maritl      3.251670    0.23786870   FALSE FALSE
# race        8.098131    0.19029496   FALSE FALSE
# education   1.413934    0.23786870   FALSE FALSE
# region      0.000000    0.04757374    TRUE  TRUE
# jobclass    1.116818    0.09514748   FALSE FALSE
# health      2.429038    0.09514748   FALSE FALSE
# health_ins  2.170437    0.09514748   FALSE FALSE
# logwage     1.000000   19.74310181   FALSE FALSE
# wage        1.000000   19.74310181   FALSE FALSE
library(splines)
bsBasis <- bs(training$age, df=3)
bsBasis
# fit curving lines to the ata
# use a 3rd degree polynomial
lm1 <- lm(wage~bsBasis, data=training)
# using rpedictors from polnomia data (age, age^2 and age^3)
plot(training$age, training$wage, pch=19, cex=0.5)
points(trianing$age, predict(lm1, newdata=training), col="red", pch=19,cex=0.5)
points(training$age, predict(lm1, newdata=training), col="red", pch=19,cex=0.5)
predict(bsBasis, age=testing$age)

library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
M <- abs(cor(training[,58]))
M <- abs(cor(training[,-58]))
diag(M) <-0
which(M > 0.8, arr.ind=T)
#-58 means leave out the category of the data taht we are tyring to rpdict
#empty out the diagonal to 0 because other wise it would be 1
then look for where the corelation is haghe rthan .8
names(spam)[c(34,32)]
plot(spam[,34],spam[,32])
# avoid including prictors that predict eachother so combine into one feature
#PCA
X <- 0.71*training$num415 + 0.71*training$num857
Y <- 071*training$num415 - 0.71*training$num857
plot(X,Y)
# matrix decomposition U D V
smallSpam <- spam[,c(34,32)]
head(smallSpam)
prComp <- prcomp(smallSpam)
plot(prComp$x[,1],prComp$x[,2])
# 34 and 32 were the two taht were highlyl correlated
#PCA1 = adding, PC2 looks like subtracting
prComp$rotation
typeColor <- ((spam$type=="spam")*1+1)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1],prComp$x[,2],col=typeColor, xlab="PC1", ylab="PC2")
# created PCA from the spam data set with out the type column
preProc <- preProcess(log10(spam[,-58]+1), method="pca",pcaComp=2)
spamPC <- predict(preProc,log10(spam[,-58]+1))
plot(spamPC[,1],spamPC[,2],col=typeColor)
trainPC <- predict(preProc, log10(training[,-58]+1))
modelFit <- train(training$type ~., method="glm",data=trainPC)
# hvve to use the same in the test
testPC <- predict(preProc, log10(testing[,-58]+1))
confusionMatrix(testing$type, predict(modelFit,testPc))
confusionMatrix(testing$type, predict(modelFit,testPC))
# now a high accuracy
# Confusion Matrix and Statistics
#           Reference
# Prediction nonspam spam
#    nonspam     651   46
#    spam         52  401
#                Accuracy : 0.9148
#                  95% CI : (0.8971, 0.9303)
#     No Information Rate : 0.6113
#     P-Value [Acc > NIR] : <2e-16
#                   Kappa : 0.8211
#  Mcnemar's Test P-Value : 0.6135
#             Sensitivity : 0.9260
#             Specificity : 0.8971
#          Pos Pred Value : 0.9340
#          Neg Pred Value : 0.8852
#              Prevalence : 0.6113
#          Detection Rate : 0.5661
#    Detection Prevalence : 0.6061
#       Balanced Accuracy : 0.9116
#        'Positive' Class : nonspam
# principal component is good for linear modles and harder to predict
# the meaning of the model
# outliers can wreak havoc on PCA
# plot predictors to see the problems

# linear regression is relatively easy to interpret
# predicting geiser eruptions
library(caret); data(faithful); set.seed(333)
inTrain <- createDataPartition(y=faithful$waiting, p=0.5, list=FALSE)
trainFaith <- faithful[inTrain,]; testFaith <- faithful[-inTrain,]
head(trainFaith)
str(trainFaith)
summary(trainFaith)
plot(trainFaith$waiting, trainFaith$eruption)
lm1 <- lm(eruptions ~ waiting, data=trainFaith)
summary(lm1)
# predict eruptions as a function of waiting
# intercept is b0
lines(trainFaith$waiting, lm1$fitted, lwd=3)
lm1.fitted
lm1$fitted
# get the estimated values of b0 and b1
coef(lm1)[1] + coef(lm1)[2]*80
#coef gets them out of the lm1
newdata <- data.frame(waiting=80)
# 80 was the new value
predict(lm1, newdata)
# prediction of the value eruptions if waiting is 80
par(mfrow=c(1,2))
plot(trainFaith$waiting, trainFaith$eruption, pch=19, col="blue",xlab="Waiting",ylab="Duration")
lines(trainFaith$waiting, predict(lm1), lwd=3)
plot(testFaith$waiting, testFaith$eruption, pch=19, col="blue",xlab="Waiting",ylab="Duration")
lines(testFaith$waiting, predict(lm1, newdata=testFatih), lwd=3)
lines(testFaith$waiting, predict(lm1, newdata=testFaith), lwd=3)
sqrt(sum((lm1$fitted-trainFaith$eruptions)^2))
sqrt(sum((predict(lm1, newdata=testFaith)--testFaith$eruptions)^2))
sqrt(sum((predict(lm1, newdata=testFaith)-testFaith$eruptions)^2))
pred1 <- predict(lm1, newdata=testFaith, interval = "prediction")
pred1 <- predict(lm1, newdata=testFaith, intervals = "prediction")
ord <- order(testFaith$waiting)
plot(testFaith$waiting, testFaith$eruptions, pch=19, col="bluew")
plot(testFaith$waiting, testFaith$eruptions, pch=19, col="blue")
matlines(testFaith$watiing[ord],pred1[ord,],type="l",,col=c(1,2,2))
modFit <- train(eruptions ~ waiting, data=trainFaith, method= "lm")
summary(modFit$finalModel)
# exploring a data set and finding good predictors
library(ISLR); library(ggplot2); library(caret)
data(Wage); Wage <- subset(Wage, select=-c(logwage)) # take the data that isnt the logwage variable
summary(Wage)
inTrain <- createDataPartition(y=Wage$wage, p0.7,list=FALSE)
inTrain <- createDataPartition(y=Wage$wage, p=0.7,list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]
dim(training);dim(testing)
featurePlot(x=training[,c("age","education","jobclass")])
featurePlot(x=training[,c("age","education","jobclass")], y=training$Wage)
featurePlot(x=training[,c("age","education","jobclass")], y=training$Wage,plot="pairs")
featurePlot(x=training[,c("age","education","jobclass")], y=training$wage, plot="pairs")
qplot(age,wage, data=training)
qplot(age,wage, data=training, color=jobclass)
qplot(age,wage, data=training, color=education)
modFit <- train(wage ~age + jobclass + education, method = "lm", data=training)
finMod <- modFit$finalModel
print(finMod)
plot(finMod, 1, pch=19,cex=0.5, col="#00000010")
plot(finMod, 1, pch=19,cex=0.5, col="#0000010")
plot(finMod, 1, pch=19,cex=0.5, col="#00000010")
qplot(finMod$fitted, finMod$residuals, color=race, data=training)
plot(finMod$residulas, pch19)
plot(finMod$residulas, pch=19)
plot(finMod$residuals, pch=19)
pred <- predict(modFit, testing)
qplot(wage, pred,colour=year, data=testing)
modFitAll <- train(wage ~., data=training, method ="lm")
pred <- predict(modFitAll,testing)
qplot(wage,pred,data=testing)

library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)
install.packages(AppliedPredictiveModeling)
library(AppliedPredictiveModeling)
install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)
names(diagnosis)
adData = data.frame(diagnosis,predictors)
adData
summary(predictors)
summary(diagnosis)
str(adData)
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
plot(training$CompressiveStrengths, )
plot(training$CompressiveStrengths, pch=19)
plot(training$CompressiveStrengths)
head(adData)
modFit <- train(diagnosis~., method="lm", data=training)
training$diagnosis
modFit <- train(CompressiveStrength~., method="lm", data=training)
plot(modFit$finalModel, 1, pch=19)
names(testing)
plot(modFit$finalModel, 1, pch=19, colour="FlyAsh")
plot(modFit$finalModel, 1, pch=19, colour=cut2(training$FlyAsh))
plot(modFit$finalModel$residuals, pch=19, colour="FlyAsh")
libary(Hmisc)
library(Hmisc)
plot(modFit$finalModel$residuals, pch=19, colour=cut2(training$FlyAsh))
plot(modFit$finalModel$residuals, pch=19, colour=cut2(training$FlyAsh, g=3))
head(training$FlyAsh)
summary(training$FlyAsh)
cutFlyAsh <- cut2(training$FlyAsh, g-6)
cutFlyAsh <- cut2(training$FlyAsh, g=6)
table(cutFlyAsh)
plot(modFit$finalModel$residuals, pch=19, colour=cutFlyAsh )
names(training)
plot(modFit$finalModel$residuals, pch=19, colour=Age)
plot(modFit$finalModel$residuals, pch=19, colour="Age")
plot(modFit$finalModel$residuals, pch=19, colour="Age")
plot(modFit$finalModel$residuals, pch=19, colour="Age")
qplot(modFit$finalModel$residuals, pch=19, colour="Age")
qplot(modFit$finalModel$residuals, pch=19, color="Age")
qplot(modFit$finalModel$residuals, pch=19, color="cutFlyAsh")
qplot(modFit$finalModel$residuals, pch=19, color=cutFlyAsh)
qplot(training$CompressiveStrength, training$FlyAsh, pch=19)
featurePlot(x=training,c("FlyAsh"), y=training$CompressiveStrength, plot="pairs")
featurePlot(x=training[],c("FlyAsh")], y=training$CompressiveStrength, plot="pairs")
featurePlot(x=training[,c("FlyAsh")], y=training$CompressiveStrength, plot="pairs")
featurePlot(x=training, y=training$CompressiveStrength, plot="pairs")
qplot(CompressiveStrength, FlyAsh, color=Age)
qplot(CompressiveStrength, FlyAsh, color=Age, data=training)
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
hist(training$Superplasticizer)
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
names(training)
adData[1]
preObj <- preProcess(training[,-1]))
preObj <- preProcess(training[,-1])
# need to convert diagnosis into numeric?
preObj <- preProcess(training[,-1], method=c("center","scale") )
str(adData)
ilData <- subset(adData, c("IL_11","IL_13","IL_16","IL_17E","IL_1alpha","IL_3","IL_4","IL_5","IL_6","IL_6_Receptor","IL_7","IL_8"))
str(adData)
reducedData <-
c(training["IL_11"],training["IL_13"],training["IL_16"],training["IL_17E"],training["IL_1alpha"],training["IL_3"],training["IL_4"],training["IL_5"],training["IL_6"],training["IL_6_Receptor"],training["IL_7"],training["IL_8"])
head(reduceData)
head(reducedData)
names(reducedData)
reducedData <-
c(training$diagnosis, training["IL_11"],training["IL_13"],training["IL_16"],training["IL_17E"],training["IL_1alpha"],training["IL_3"],training["IL_4"],training["IL_5"],training["IL_6"],training["IL_6_Receptor"],training["IL_7"],training["IL_8"])
# preObj <- preProcess(reducedData[,-1], method=c("center","scale")
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
	

