# R Workshop - University of Colombo
# Day II Part I - 2021/09/19
# Author
# Jeewantha Bandara (mailto:jeewantha.bandara@rutgers.edu) 
# Following Advanced R style guide - http://adv-r.had.co.nz/Style.html

# Today we'll get more into statistical analysis using R
library(tidyverse)
library(gridExtra)
library(ggfortify)


# First let's refresh ourselves with some simple vector statistics

# Let's go back to yesterday's Hemoglobin example
# Let's take the Day 2 data
hemoglobin_day_2 <- c(18,9.8,13.2,12.4,7.4,11.6)
# R allows us basic functions to get some basic statistics such as 
# Mean, Median, Range, Maximum, Minimum
# Mean
hemoglobin_mean <- mean(hemoglobin_day_2)
# Median
hemoglobin_median <- median(hemoglobin_day_2)
# Range
hemoglobin_range <- range(hemoglobin_day_2)
# Maximum
hemoglobin_max <- max(hemoglobin_day_2)
# Minimum
hemoglobin_min <- min(hemoglobin_day_2)
# Standard deviation
hemoglobin_sd <- sd(hemoglobin_day_2)

# Let's also do some basic vector operations to refresh our memories
# We can do normal mathematical operations on them
hemoglobin_day_2 + 1
hemoglobin_day_2/2

# Accessing different parts of a vector
# Let's say that you want to access the second value in a vector
# We do that like the following
hemoglobin_day_2[1:4]


# Now let's load a dataset and explore it
# Let's load the in-built dataset: mtcars
cars <- datasets::mtcars
# Let's view the dataset
cars
# R has some cool functions that allows us to view different portions of the
# dataset
# We can access a single variable or column of a dataset using the '$' symbol
# Let's access the 'disp' column
cars$disp
# 'head' function allows us to view a number of rows at the start of the dataset
# Let's view the first 5 rows of the dataset
head(cars,5)
# 'tail' function allows us to view a number of rows at the end of the dataset
tail(cars,5)
# The 'dplyr' library has a neat function named 'summary' that allows us to see
# basic statistics with a dataset
summary(cars)
# You can see useful information like mean, maximum, minimum, and quantiles
# with summary for each variable/column

# Now let's develop a hypothesis
# Let's see if there's a relationship between 'mpg'(miles per gallon) 
# and 'wt' (Weight)
# The logic behind this is, the heavier the car is, the less efficient it is
# Let's create a scatterplot for this
# So our hypothesis is that there should be a negative correlation between the 
# two variables
# Let's plot it first
# aes = aesthetics
ggplot(cars, aes(x=wt,y=mpg)) + geom_point()
# Looks like there's a negative linear relationship between the two variables

# Now let's see the correlation value between the two variables
# R has a useful function named 'cor.test' that allows us to do this
# correlation value = -1 to +1
# significant value = Smaller the better
cor.test(cars$mpg, cars$wt, method=c("pearson"))
# Since we have a very low p-value and high negative cor value, we can say that
# this is significant negative linear relationship

# Now let's do some Linear Regression
# We need the function 'lm' (meaning Linear Model) to perform linear regressions
# We'll get the model results into a variable named 'car_model'
car_model <- lm(mpg ~ wt, data=cars)
car_model
# How is a linear model explained in formula
# We explain it by y=mx+c
# We can use the 'summary' function on the car_model to get some information
# on the linear relationship
model_summary <- summary(car_model)
model_summary
# And now we can get the information on the intercept, slope and significance for
# the relationship
# We can see that the Intercept is 37.2851. The slope is -5.3445.
# The significant level (p-value) is 1.29 x 10^-10
# Now let's plot this relationship
# We can get the values from the 'model_summary' object
model_summary$coefficients[1]

wt_intercept <- model_summary$coefficients[1]
wt_slope <- model_summary$coefficients[2]
# Let's plot this using ggplot
model_plot <- ggplot(cars, aes(x=wt, y=mpg)) + geom_point() +
  xlab("Weight (Tonnes)") +ylab("Mile Per Gallon") + 
  geom_abline(slope=wt_slope, intercept=wt_intercept, linetype=2, alpha=0.5)
model_plot

# And there it is
# Now let's go one step further
# Let's predict some values using this model
# Because this a model that actually works well, we can use it to predict miles
# per gallon for a car with a certain weight
# Let's create a vector
new_weights <- readr::read_csv("data/new_weight_data.csv")
# Let's view this data
new_weights
# new_weights = c(1.2, 4.5, 5.8)
# There's a function in R named 'predict.lm' that allows us to predict new values
# for a linear model
predict.lm(car_model, newdata=new_weights)
# Now let's plot this new data
# First let's get the newly predicted values to a new vector
predicted_mpg <- predict.lm(car_model, newdata=new_weights)
# Isn't that great?
# Now you know how to predict future values using a model


# Now let's do an exercise (Time: 20-30 minutes)
# We'll work in breakout groups
# We'll use the same 'cars' dataset
# Let's try to establish a relationship between 'hp' and 'mpg'
# 'hp' is horse power - Basically a measurement of engine power
# So I want you to do the following
# Step 1: Make the hypothesis
# Step 2: Make a scatterplot (Just like we did for mpg and wt above) for this
# relationship
# Step 3: Then measure the correlation (Using cor.test) between the two variables
# Step 4: Then see if it's significant
# Step 5: Then create the linear model (Using lm) for this relationship
# Step 6: Then plot this linear relationship using a straight line
# Step 7 (Bonus): Then create an excel file (saved as a .csv) and use that to predict
# new values for mpg



# ANOVA with R and dplyr
# Analysis of variance is basically the other side of linear regression.
# The difference is that it's comparing group means
# What we are basically asking when performing ANOVA is the following
# Do these groups come from the same distribution? Because if they do, they
# should have a similar mean within specific bounds

# Let's use the 'Iris' dataset for this
# The Iris dataset has three species
# Let's build a hypothesis
# H0 = The mean petal length of the three species are the same
# H1 = The mean petal length of the three species are not the same
# Now let's test it
# First let's load 'iris'
iris <- datasets::iris
# Let's view it just to refresh our memory
iris
# Let's visualize the distribution of Petal Length
# As a histogram plot
petal_histogram_p <- ggplot(iris, aes(Petal.Length, fill=Species, color=Species)) + 
  geom_histogram(alpha=0.4) + xlab("Petal Length") +
  ylab("Count")
petal_histogram_p

# As a density plot
petal_density_p <- ggplot(iris, aes(Petal.Length, fill=Species, color=Species)) + 
  geom_density(alpha=0.4) + xlab("Petal Length") +
  ylab("Count")
petal_density_p

# Let's plot how the means are distributed in a box plot
petal_boxplot <- ggplot(iris, aes(x=Species, y=Petal.Length)) + 
  geom_boxplot()
petal_boxplot
# We can improve this by plotting the data points across the box plots
petal_boxplot_points <- ggplot(iris, aes(x=Species, y=Petal.Length)) + 
  geom_boxplot() + geom_point(color='purple', alpha=0.2) +
  labs(y="Petal Length", x="Species")
petal_boxplot_points

# In R+dplyr, we need to run a linear model to do an ANOVA
petal_model <- lm(Petal.Length ~ Species, data=iris)
# Let's summarize this model
petal_model_summary <- summary(petal_model)
petal_model_summary
# Now let's perform an ANOVA for this model
# aov - The function for ANOVA
petal_model_anova <- aov(petal_model)
# Run the summary to 
summary(petal_model_anova)
# We can see that the p value is much lower than 0.0005.
# So we can say that these species were not drawn from the same population
# So we can reject the null hypothesis
# But do we know which species is actually different from the other?
# We can do the Tukey's test to solve this problem.
# Tukey's test performs pairwise testing
# Tukey's test
petal_model_tukey <- TukeyHSD(petal_model_anova, ordered=TRUE)

petal_model_tukey
# And we can see that they are all different from one another


# Exercise
# Alright. Now that you know how to perform an ANOVA in R, let's do an exercise
# There's a dataset named 'InsectSprays' built-in R
# This is a dataset that shows how many pest species remain on a crop plant
# after getting treated by a certain pesticide
# Let's load it 
insect_sprays <- datasets::InsectSprays
insect_sprays
# Now do the following
# Step 1: Make a histogram/density plot showing the distribution of all the groups
# Step 2: Create a hypothesis for testing
# Step 3: Then do an ANOVA between the groups
# Step 4: Then do a Tukey's test on this outcome
# Step 5: Then explain your results and a conclusion

# I will do Step 1 here
ggplot(insect_sprays, aes(x=count, fill=spray, color=spray)) + 
  geom_histogram(alpha=0.4) + 
  scale_fill_manual(values = c("lightgreen", "blue", "purple", "black", "red", "cyan")) +
  scale_color_manual(values = c("lightgreen", "blue", "purple", "black", "red", "cyan"))

  
ggplot(insect_sprays, aes(x=count, fill=spray, color=spray)) + 
  geom_density(alpha=0.4) + 
  scale_fill_manual(values = c("lightgreen", "blue", "purple", "black", "red", "cyan")) +
  scale_color_manual(values = c("lightgreen", "blue", "purple", "black", "red", "cyan"))

