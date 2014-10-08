library("swirl")
ls()
swirl()
x
x[1:10]
x[is.na(x)]
y <- x[!is.na(x)]
y
y[y >0]
x[x>0]
x[!is.na(x)& x .0]
x[!is.na(x)& x >0]
x[c(3,5,7)]
x[0]
x[3000]
x[c(-2,-10)]
x[-c(2,10)]
vect <- c(foo = 100, bar = 2, norf= NA)
vect <- c(foo = 11, bar = 2, norf= NA)
vect
names(vect)
vect2 <-c(11,2,NA)
names(vect2)<- c("foo", "bar", "norf")
identical(vect, vect2)
vect["bar"]
vect[c("foo","bar")]
my_vector <- 1:20
my_vector
dim(my_vector)
length(my_vector)
dim(my_vector) <- c(4,5)
dim(my_vector)
attributes(my_vector)
play()
my_vector
nxt()
my_vector
class(my_vector)
my_matrix <- my_vector
?matrix
my_matrix2 <- matrix(data = 1:20,nrow = 4, ncol= 5)
identical(my_matrix, my_matrix2)
patients <-  c("Bill", "Gina", "Kelly", "Sean")
cbind(patients, my_matrix)
my_data <- data.frame(patients, my_matrix)
my_data
class(my_data)
cnames <- c("patient", "age", "weight","bp","rating","test")
colnames(my_data) <- cnames
my_data
