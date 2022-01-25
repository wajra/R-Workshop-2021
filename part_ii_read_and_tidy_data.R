# R Workshop - University of Colombo
# Day I Part II - 2021/09/18
# Author
# Jeewantha Bandara (mailto:jeewantha.bandara@rutgers.edu) 
# Following Advanced R style guide - http://adv-r.had.co.nz/Style.html


# Now that you have gone through the basics of the language itself,
# let's get started on dealing with data

# Tidy data....

# First let's load tidyverse
library(tidyverse)
library(gridExtra)
library(ggfortify)

# install.packages("gridExtra")
# install.packages("ggfortify")

# Exploring your data
# It's important to realize whether your data is normal or not
# R has some great tools that makes it easier for us
# R has some inbuilt datasets. One is called 'iris'
# 'iris' is actually the famous Iris Flower datasets
# https://en.wikipedia.org/wiki/Iris_flower_data_set
# It has the sepal length, width and petal length, width of these flowers
# It was collected by Edgar Anderson in 1936 on three species of Iris flowers

# Let's load it
iris <- datasets::iris
# Let's see how the dataset is structured
iris
# You will see that there are three species of Iris in this dataset
# They are 'setosa', 'versicolor', 'virginica'
# First let's visualize the data
# ggplot2 is a useful package for creating publication quality graphs
# Let's see how Sepal Length is distributed in the dataset
# Let's make histogram plots
sepal_dist_p <- ggplot(iris, aes(Sepal.Length)) + 
  geom_histogram(color="black", fill="white") + xlab("Sepal Length") +
  ylab("Count")
# aes = aesthetics
sepal_dist_p
# But this doesn't really make sense. Remember that there are three 
# species. So we should actually plot them by their histograms
sepal_dist_p_2 <- ggplot(iris, aes(x=Sepal.Length, fill=Species, color=Species)) +
  geom_histogram(alpha=0.5) + geom_density() + xlab("Sepal Length") + ylab("Count") 
sepal_dist_p_2
# Tidyverse has some great tools for us to filter the data
# Let's say that you only want to plot the distribution data for 'virginica'
# species. How would you do that?
# The 'dplyr' package has a lot of useful functions to clean and filter your data
# We'll use the function 'filter' from that package to select only 'virginica'
# This will look weird to you, don't worry
# %>% is a pipeline symbol. It basically means we are sending one thing through a
# function
iris_virginica <- iris %>% dplyr::filter(Species=="virginica")
# You will see that we have got a dataset of 50 observations for only this species
# Cool!!!
# Now let's plot it
virginica_plot <- ggplot(iris_virginica, aes(Sepal.Length)) + 
  geom_histogram(color='black', fill='white') + xlab("Sepal Length") +
  ylab("Count")
virginica_plot

# Now let's make density plots. Density plots are also useful to see
# the distribution of your data. But it allows for smoothing and is more pleasing
# visually
iris_density <- ggplot(iris_virginica,aes(Sepal.Length)) + geom_density(alpha=0.5)
iris_density
# We can make it visually nicer
virginica_density <- ggplot(iris_virginica,aes(Sepal.Length)) + 
  geom_density(alpha=0.5, fill="blue",color="blue") + xlab("Sepal Length") +
  ylab("Density")
virginica_density
# xlab = x-axis label
# ylab = y-axis label

# ggplot has tools to create subplots
# One is called 'gridExtra'
hist_and_density <- grid.arrange(virginica_plot, virginica_density, ncol=2)
# ncol = number of columns = 2
# hist_and_density <- grid.arrange(virginica_plot, virginica_density, nrow=2)
# How to save a plot
# We can use a ggplot function named 'ggsave'
# We are setting the height and width to 6 inches and maximum quality (300 dots per inch [dpi])
ggsave("virginica_plots.png", hist_and_density, width=6, height=6, dpi=300)

# Exercise
# Now that you know how to plot data, do the following
# Select only setosa and versicolor species from the iris dataset
# Then create a density plot for these 2 species
# Try to make them nice
# Then save them to your computer
# Hint - Use the following line to filter the 2 species
# two_species <- iris %>% dplyr::filter(Species=='setosa' | Species=='versicolor')
two_species <- iris %>% dplyr::filter(Species=='setosa' | Species=='versicolor')
dens_plot <- ggplot(two_species, aes(x=Sepal.Length, fill=Species, color=Species)) +
  geom_density(alpha=0.5) + xlab("Sepal Length") + ylab("Count")
# Save it
dens_plot
ggsave("2_species_density.png", dens_plot, width=6, height=6, dpi=300)

#Exploring data and models
# We'll just take a quick look at how to statistically model some relationships
# There's a dataset named 'mtcars' in R. It has some statistics for different
# car models
data(mtcars)
# You can see that there are several columns with different data for each car
# model
# Let's see if there's a relationship between 'mpg'(miles per gallon) 
# and 'wt' (Weight)
# The logic behind this is, the heavier the car is, the less efficient it is
# Let's create a scatterplot for this
ggplot(mtcars, aes(x=wt,y=mpg)) + geom_point()
# Looks like there's a negative linear relationship between the two variables

# So let's create a linear model
# You can create a linear model in R using 'lm'
# lm = linear model
car_model <- lm(mpg ~ wt, data=mtcars)
# There's a function named 'autoplot' that really helps us understand our data
stat_plot <- autoplot(car_model)
ggsave("autoplot.png", stat_plot, width=6, height=6, dpi=300)


# Tidyverse loads in several useful packages
# 'readr' is one of them. It's great for reading in datasets like
# csv files and Excel files
weight_dataset <- readr::read_csv("data/untidy_dataset_i.csv")
# You can view the dataset on the right hand side window
# Click on it and the dataset will load on a different tab
# You can also just type in the name of the dataset and hit enter
weight_dataset
# You can see that the dataset is not tidy
# We can use 'pivot_longer' to resolve this type of issue
weight_dataset_tidy <- weight_dataset %>% tidyr::pivot_longer(c('2004','2005','2006','2007'),
                      names_to = "year", values_to = "weight")
# Now view the data again
weight_dataset_tidy
# Now let's write that dataset to the disk
readr::write_csv(weight_dataset_tidy, "data/tidy_dataset_i.csv")
# There's another form of untidy data
# That's when an observation is scattered across multiple rows
# Let's read in the other dataset


people_dataset <- readr::read_csv("data/untidy_dataset_ii.csv")
people_dataset
# We use a function named 'pivot_wider' to resolve this type of untidy data
people_dataset_tidy <- people_dataset %>% 
  tidyr::pivot_wider(names_from='type',values_from='value')
people_dataset_tidy
# Now it's tidy!!!

# That's it for the day
# If you have any questions, please feel free to ask!!!