#setwd("~/LAB")
rm(list=ls())

#=============================Part(1)=====================================
x <- runif(100, 0, 10)     # 100 draws between 0 & 10

#(Q1) Try changing the value of standard deviation (sd) in the next command 
#How do the data points change for different values of standard deviation?
y <- 5 + 6*x + rnorm(100, sd = 4)  # default values for rnorm (mean = 0 and sigma = 1)

#(ANS1) having larger std makes data points more scattered 

#Plot it
plot (x,y)

# OLS model
# OLS : Ordinary Least Squares
model1 <- lm(y ~ x)
# Learn about this object by saying ?lm and str(d)
# ?lm

# Compact model results
print(model1)
#(Q2) How are the coefficients of the linear model affected by changing the value
#of standard deviation in Q1?

#(ANS2) the data is more scattered so fitting is looser but the coefficients does not seem to have direct relation 

# Regression diagnostics --
ypred <- predict(model1) # use the trained model to predict the same training data
# Learn about predict by saying ?predict.lm

par(mfrow=c(1,1))
plot(y,y, type="l", xlab="true y", ylab="predicted y") # ploting the ideal line
points(y, ypred) # plotting the predicted points
                 # the nearer to the ideal line the better

# Detailed model results
d1 <- summary(model1)
print(d1)

#(Q3) How is the value of R-squared affected by changing the value
#of standard deviation in Q1?

#(ANS3) the R Squared value moves in opposite direction with std

# Learn about this object by saying ?summary.lm and by saying str(d)
cat("OLS gave slope of ", d1$coefficients[2,1],   
    "and an R-sqr of ", d1$r.squared, "\n")

#Graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model1, 1) # plot one diagnostic graphs

#(Q4)What do you conclude about the residual plot? Is it a good residual plot?
#(ANS4) it has no pattern but the range is high indicating big (y-y^) difference 
#========================End of Part(1)==============================================

#========================Part(2)=====================================================
#Training a linear regression model
x1 <- runif(100) 
# introduce a slight nonlinearity
#(A)
y1 = 5 + 6*x1 + 0.1*x1*x1 + rnorm(100)
plot(x1,y1)
model <- lm(y1 ~ x1)

summary(model)

#Creating a test set (test vector)

#EDIT: We renamed the variable as x1 instead of xtest (in previous versions)
#becaues the lm function searches in the formula for variables named 
#with x1 and not any other name.
#So, if you used xtest, the lm function will not know what is xtest and
#a random plot will be generated. 

x1 <- runif(100)
#(B)
ytrue = 5 + 6*x1 + 0.1*x1*x1 + rnorm(100)  # same equation of y1 but on xtest to get true y for xtest

ypred <- predict(model, data.frame(x1))

par(mfrow=c(1,1))
plot(ytrue, ytrue, type="l", xlab="true y", ylab="predicted y")
points(ytrue, ypred)

# graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model, 1) # plot the diagnostic graphs

#(Q5)What do you conclude about the residual plot? Is it a good residual plot?
# (ANS5) it is a good residual as the range is [-2,2] and it has no pattern 

#(Q6)Now, change the coefficient of the non-linear term in the original model for (A) training 
#and (B) testing to a large value instead. What do you notice about the residual plot?
# (ANS6) the residual plot shows that error was +ve then decresed to 0 then went to -ve and bakc to +ve 
# meaning that the data is not linear 
#===============================End of Part(2)=============================================

#=================================Part(3)==================================================
#(Q7) Import the dataset LungCapData.tsv. What are the variables in this dataset?
lung <- read.delim("LungCapData.tsv")
names(lung)
# (ANS7) "LungCap"   "Age"       "Height"    "Smoke"     "Gender"    "Caesarean"

#(Q8) Draw a scatter plot of Age (x-axis) vs. LungCap (y-axis). Label x-axis "Age" and y-axis "LungCap"
par(mfrow=c(1,1))
plot(lung$Age, lung$LungCap, xlab="Age", ylab="LungCap")

#(Q9) Draw a pair-wise scatter plot between Lung Capacity, Age and Height. 
#Check the slides for how to plot a pair-wise scatterplot
par(mfrow=c(1,1))
pairs(lung[, c("LungCap","Age","Height")])

#(Q10) Calculate correlation between Age and LungCap, and between Height and LungCap.
#Hint: You can use the function cor
age_lungcap_r = cor(lung$Age, lung$LungCap)
height_lungcap_r = cor(lung$Height, lung$LungCap)
age_lungcap_r
height_lungcap_r

#(Q11) Which of the two input variables (Age, Height) are more correlated to the 
#dependent variable (LungCap)?
# (ANS11) height is more correlated (0.91)

#(Q12) Do you think the two variables (Height and LungCap) are correlated ? why ?
# (ANS12) yes as the graph shows positive linear relation 

#(Q13) Fit a liner regression model where the dependent variable is LungCap 
#and use all other variables as the independent variables
lung_model <- lm(LungCap ~ ., data = lung)

#(Q14) Show a summary of this model
summary(lung_model)

#(Q15) What is the R-squared value here ? What does R-squared indicate?
#(ANS15) it is 0.85 it shows that model performance is model, data not taht scattered ? 

#(Q16) Show the coefficients of the linear model. Do they make sense?
#If not, which variables don't make sense? What should you do?
#(Intercept)  -11.32249  
#  Age            0.16053 (makes sense as lung capacity increases with age)
#  Height         0.26411 (makes sense as taller people generally have larger lung capacity)
#  Smokeyes      -0.60956 (makes sense as smoking has a negative effect on lung capacity)
#  Gendermale     0.38701 (makes sense since males usually have higher lung capacity)
#  Caesareanyes  -0.21422 (does not clearly make sense since birth method may not strongly affect lung capacity)

#(Q17) Redraw a scatter plot between Age and LungCap. Display/Overlay the linear model (a line) over it.
#Hint: Use the function abline(model, col="red").
#Note (1) : A warning will be displayed that this function will display only the first two 
#           coefficients in the model. It's OK.
#Note (2) : If you are working correctly, the line will not be displayed on the plot. Why?
plot(lung$Age, lung$LungCap, xlab="Age", ylab="LungCap")
abline(lung_model, col="red")
# (ANS17) the line is not there because the model uses all 5 fetaures and we are tryign to draw the line using only the age 

#(Q18)Repeat Q13 but with these variables Age, Smoke and Cesarean as the only independent variables.
lung_model2 <- lm(LungCap ~ Age + Smoke + Caesarean, data = lung)

#(Q19)Repeat Q16, Q17 for the new model. What happened?
plot(lung$Age, lung$LungCap, xlab="Age", ylab="LungCap")
abline(lung_model2, col="red")
# a line was drawn this time as it is the continuos var ?

#(Q20)Predict results for this regression line on the training data.
ypred_train <- predict(lung_model2)

#(Q21)Calculate the mean squared error (MSE)of the training data.
mse <- mean((lung$LungCap - ypred_train)^2)
mse
