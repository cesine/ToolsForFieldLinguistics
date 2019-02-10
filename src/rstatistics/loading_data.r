getwd()
dir
dir()
read.csv("hw1_data.csv")
quiz1 <- read.csv("hw1_data.csv")
quiz1
summary(quiz1)
str(quiz1)
x <- c(1,3, 5)
y <- c(3, 2, 10)
cbind(x,y)
x <- list(2, "a", "b", TRUE)
x[[2]]
x <- 1:4
y <- 2
x+y
x <- c(3, 5, 1, 10, 12, 6)
x[x <6] <- 0
x
x <- c(3, 5, 1, 10, 12, 6)
x[x %in% 1:5] <- 0
x
names(quiz1)
head(quiz1,2)
str(quiz1)
tail(quiz1,2)
quiz1[47]
head(quiz1,47)
quiz1$Ozone
quiz1$Ozone[NA]
quiz1$Ozone
sum(is.na(quiz1$zone))
sum(is.na(quiz1$Ozone))
summary(quiz1$Ozone)
tapply(flags$animate, flags$landmass, mean)
tapply(quiz1$Ozone, quiz1$Ozone, mean)
ozoneTemp <- c(quiz1$Ozone, quiz1$Temp)
ozoneTemp
ozoneTemp <- list(quiz1$Ozone, quiz1$Temp)
ozoneTemp
x
x <- quiz1(Ozone >31)
quiz1[[Ozone >31]]
quiz1[[Ozone >31, exact =FALSE]]
quiz1[["Ozone" >31, exact =FALSE]]
quiz1
quiz1[["Ozone" >31, exact =FALSE]]
sapply(quiz1, function(row) row$Ozone >31 )
sapply(quiz1, function(row) Ozone >31 )
sapply(quiz1, function(OZone) Ozone >31 )
sapply(quiz1, function(Ozone) Ozone >31 )
sapply(quiz1, function(value) value >31 )
above31 <- sapply(quiz1, function(value) value >31 )
above90 <- sapply(quiz1, function(value value > 90))
above90 <- sapply(quiz1, function(value) value > 90)
above90
quiz1[!above31]
quiz1
subset(quiz1, OZone >31)
subset(quiz1, Ozone >31)
subset(quiz1, Ozone >31& Temp >90)
ozoneTemp <- subset(quiz1, Ozone >31& Temp >90)
summary(ozoneTemp)
subset(quiz1, Month = 6)
subset(quiz1, Month == 6)
summary(subset(quiz1, Month == 6))
summary(subset(quiz1, Month == 5))
x <- 1:4
y <- 2:3
x+y
x
y
head(quiz2)
head(quiz1)
head(quiz1, 2)
tail(quiz1,2)
quiz1[47]
quiz1$Ozone[47]
is.na(quiz1$Ozone)
sum(is.na(quiz1$Ozone))
mean(!is.na(quiz1$Ozone))
!iz.na(quiz1$Ozone)
!is.na(quiz1$Ozone)
mean(quiz1$Ozone)
good <- complete.cases(quiz1)
good
quiz1[good]
quiz1[good,]
summary(quiz1[good,])
subset(quiz1, Ozone>31)
subset(quiz1, Ozone>31 & Temp  >90)
mean(subset(quiz1, Ozone>31 & Temp  >90))
summary(subset(quiz1, Ozone>31 & Temp  >90))
summary(subset(quiz1, Month == 6))
summary(subset(quiz1, Month == 5))
x <- list(2, "a", "b", TRUE)
class(x)
class( x[[1]])
x[[1]]
x <- 1:4
y <- 2:3
class(x+y)
head(quiz1,2)
tail(quiz1, 2)
quiz1$Ozone[47]
is.na(quiz1$Ozone)
sum(is.na(quiz1$Ozone))
good <- complete.cases(quiz1)
quiz1[good,]
nrows(quiz1[good,])
str(quiz1[good,])
mean(quiz1[good,])
summary(quiz1[good,])
subset(quiz1, Ozone>31 & Temp>90)
summary(subset(quiz1, Ozone>31 & Temp>90))
summary(subset(quiz1, Month == 6))
summary(subset(quiz1, Month == 5))

