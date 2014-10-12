
# Load spam data set
library(kernlab)
data(spam)

# Exploring the data to see if the feature 'your' is predictive of spam vs ham
plot(density(spam$your[spam$type=="nonspam"]),col="blue",main="",xlab="Frequency of 'your'")
lines(density(spam$your[spam$type=="spam"]),col="red")

# It looks like a cutoff could be at 0.5
abline(v=0.5,col="black")

# Create a column of predicted spam/nonspam based on the above cutoff
predictionBasedOnOnlyYour <- ifelse(spam$your > 0.5, "spam", "nonspam")

# View the precision and recall scores
table(predictionBasedOnOnlyYour,spam$type)/length(spam$type)

# Set random seed 
set.seed(333)

# Get a small sample (very small)
smallSpam <- spam[sample(dim(spam)[1], size=10),]

# Take a look at the data
head(smallSpam)
str(smallSpam)

# Create a color for the scatterplot 
spamLabel <- (smallSpam$type=="spam")*1+1
plot(smallSpam$capitalAve, col=spamLabel)
plot(smallSpam$edu, col=spamLabel)

# Create a very simple 'classifier' which just divides the data
usingAnOverfittedRuleBasedOnOnlyAverageOfCapitalLetters <- function(x){
	# print(x)
	prediction <- rep(NA, length(x))
	prediction[x > 2.7] <-"spam"
	prediction[x < 2.40] <-"nonspam"
	# example of overfitting the data to this small sample size by carving a small hole that is spam in the nonspam section
	prediction[(x >= 2.40 & x <=2.45)] <- "spam"
	prediction[(x > 2.45 & x <= 2.70)] <- "nonspam"
	prediction <- rep(NA, length(x))
	# print(prediction)
	return(prediction)
}

table(usingAnOverfittedRuleBasedOnOnlyAverageOfCapitalLetters(smallSpam$caplitalAve), smallSpam$type)

# Create another random sample
smallSpam <- spam[sample(dim(spam)[1], size=10),]
spamLabel <- (smallSpam$type=="spam")*1+1
plot(smallSpam$capitalAve,col=spamLabel)

# Change the colors since red looks like it would be spam 
spamLabel <- (smallSpam$type=="spam")*1 +3
plot(smallSpam$capitalAve,col=spamLabel)

predicted <- usingAnOverfittedRuleBasedOnOnlyAverageOfCapitalLetters(smallSpam$capitalAve)
table(predicted, smallSpam$type)

# Create a more general 'classifer' which does not try to overfit the sample
usingOnlyAverageOfCapitalLetters <- function(x){
	prediction <- rep(NA, length(x))
	prediction[x >2.8] <- "spam"
	prediction[x  <= 2.8] <- "nonspam"
	return(prediction)
}

predicted2 <-usingOnlyAverageOfCapitalLetters(smallSpam$capitalAve)
table(predicted2, smallSpam$type)

sum(usingAnOverfittedRuleBasedOnOnlyAverageOfCapitalLetters(spam$capitalAve)==spam$type)
sum(usingOnlyAverageOfCapitalLetters(spam$capitalAve)==spam$type)


# Compare the prediction results for the three rules 
# 
# Using only the feature 'your'
table(prediction,spam$type)/length(spam$type)
	# prediction   nonspam      spam
	#    nonspam 0.4590306 0.1017170
	#    spam    0.1469246 0.2923278

# Using only the overfitted function based on the feature 'Average of capital letters' 
table(usingAnOverfittedRuleBasedOnOnlyAverageOfCapitalLetters(spam$capitalAve),spam$type)/length(spam$type)
	#           nonspam      spam
	# nonspam 0.4653336 0.1277983
	# spam    0.1406216 0.2662465

# Using only the feature 'Average of capital letters'
table(usingOnlyAverageOfCapitalLetters(spam$capitalAve),spam$type)/length(spam$type)
	#         nonspam      spam
	# nonspam 0.4833732 0.1395349
	# spam    0.1225820 0.2545099
	
# Calculate the quality of the prediction rules
calculateFScores <- function(confusionMatrix){
	sensitivity <- confusionMatrix[1] / (confusionMatrix[1] + confusionMatrix[2])
	specificity <- confusionMatrix[4] / (confusionMatrix[3] + confusionMatrix[4])
	positivePredictiveValue <- (confusionMatrix[1] + confusionMatrix[2]) / (confusionMatrix[1] + confusionMatrix[3])
	negativePredictiveValue <- (confusionMatrix[3] + confusionMatrix[4]) / (confusionMatrix[2] + confusionMatrix[4])
	accuracy <- confusionMatrix[1] + confusionMatrix[4] 

	return( c("sensitivity"=sensitivity, "specificity"=specificity, "positivePredictiveValue"=positivePredictiveValue, "negativePredictiveValue"=negativePredictiveValue, "accuracy"=accuracy))
}


calculateFScores(table(usingAnOverfittedRuleBasedOnOnlyAverageOfCapitalLetters(spam$capitalAve),spam$type)/length(spam$type))
	# sensitivity             specificity positivePredictiveValue negativePredictiveValue 
	#   0.7679340               0.6756757               1.0216196               0.9684829 
	#    accuracy 
	#   0.7315801 

calculateFScores(table(usingOnlyAverageOfCapitalLetters(spam$capitalAve),spam$type)/length(spam$type))
	# sensitivity             specificity positivePredictiveValue negativePredictiveValue 
	#   0.7977044               0.6458908               0.9727844               1.0449568 
	#    accuracy 
	#   0.7378831 

# The predictionBasedOnOnlyYour is more accurate but less sensitive so some good emails will lost 
calculateFScores(table(predictionBasedOnOnlyYour,spam$type)/length(spam$type))
	# sensitivity             specificity positivePredictiveValue negativePredictiveValue 
	#   0.7575323               0.7418643               1.0806202               0.8970807 
	#    accuracy 
	#   0.7513584 
