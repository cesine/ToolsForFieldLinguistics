install.packages("swirl")
library("swirl")
ls()
rm(list=ls())
ls()
swirl()
5 + 7
x <- 5+7
x
y <- x - 3
y
z <- c(1.1,9,3.14)
?c
z
c(z, 555, z)
z*2 +100
my_sqrt <- sqrt(z -1)
my_sqrt
my_div <- z/my_sqrt
my_deiv
my_div
c(1,2,3,4 ) + c(0,10)
c(1,2,3,4)+ c(0,10,100)
z*2 +1000
my_div
swirl()
1:20
pi:10
15:1
?`:`
sec(1,20)
seq(1,20)
seq(0,10,by=0.5)
seq(0,10,length=30)
my_seq = seq(0,10,length=30)
my_seq <- seq(0,10,length=30)
my_seq <- seq(5,10,length=30)
length(my_seq)
1:length(my_seq)
seq(along.with = my_seq)
seq_along(my_seq)
rep(0, times = 40)
rep(c(0,1,2), times=10)
rep(c(0,1,2), each = 10)
num_vect <- c(0.5,55,-10,6)
tf <- num_vect < 1
tf
num_vect >=6
my_char <-c("My", "name", "is")
my_char
paste(my_char, collapse= " ")
my_name <- c(my_char, "cesine")
my_name
paste(my_name, collapse= " ")
paste("Hello", "world!", sep=" ")
paste(1:3, c("X", "Y", "Z"), sep = "")
paste(LETTERS, 1:4, sep = "-")
x <- c(44, NA, 5, NA)
x * 3
y <- rnorm(1000)
z <- rep(NA, 1000)
my_data <- sample(c(y,z), 100)
my_na <- is.na(my_data)
my_na
play()
my_data
nxt()
my_data == NA
sum(my_na)
my_data
0/0
Inf-Inf
