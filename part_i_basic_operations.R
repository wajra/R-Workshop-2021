# R Workshop - University of Colombo
# Day I Part I - 2021/09/18
# Author
# Jeewantha Bandara (mailto:jeewantha.bandara@rutgers.edu) 
# Following Advanced R style guide - http://adv-r.had.co.nz/Style.html

# Hello!!!
# Welcome to the R workshop
# My name is Jeewantha Bandara
# If you have any questions or comments on this workshop and it's materials,
# please reach out to me at jeewantha.bandara@rutgers.edu

# This line is a comment
# A 'comment' is something that you put inside the code to describe what you
# are doing to yourself or someone else
# It's a good practice to comment your code because it makes it more
# understandable when you come back to it at a later time

# Data types in R
# Numeric - These can contain whole numbers
2
# Or numbers with decimal points. Floating numbers
2.5
# Character
'f'
# String
'Hi. We are learning R'
# Boolean - True or False
TRUE
FALSE

# Basic arithmetic with R
# Let's sum two values.
2+2
# Let's subtract one value from another
5-2
# Let's multiply one value from another
6*30
# Let's divide one value from another
50/2
# Let's get the power of one value from another. We use the symbol '^' for this
2^3
# Let's get the remainder of 100 by 3. It should be 1.
# We use the symbol referred to as 'modulo' for this. It's basically 2 '%'s
100 %% 3


# Let's do a slightly more complicated arithemtic operation
# We can use paranthesis () for that
# Add 2 to 5 and multiply that by the result of dividing 100 by 8
(2+5) * (100/8)


# Exercise 1
# Now let's do a little exercise of your own
# Add 10 to the result of 5 to the power of 20 and divide that by the result of
# 20 minus 6
# You can use as many paranthesis as you want
(10 + 5^20)/(20-6)

# Variables in R
# A variable can hold a certain value. It can be an integer, decimal, sequence,
# character, a string (words and sentences), or even full data tables
# Variables are important because it allows us to store values
# How to assign values to a variable
# Here we will assign a value of 5 to a variable named 'a'
a <- 5
# And now let's print 'a'
print(a)
# Let's assign another value to a variable named 'b'. Let's make it a decimal
b <- 11.25
# Now let's add these two variables
a+b
# We can assign the result of this operation to another variable
# Let's do the last operation and assign the result to a variable named 'c'
c <- a+b
# Look at the top right hand portion of the screen
# You will see that our variables are shown by RStudio

# Now let's print 'c'
print(c)

# You can reassign values to existing variables
# Let's assign the value of 550 to 'a'
a <- 550
# Now let's do the above operation again and assign the result to 'c'
c <- a+b
print(c)

# Exercise 2
# Time for another exercise
# Step 1: Assign the result of 25 to the power to 3 to variable 'x'.
# Step 2: Then assign the result of 1.25 divided by 0.25 to variable 'y'
# Step 3: Then assign the value of the remainder of 'x' by 'y' to 'z'

x <- 25^3
y <- 1.25/0.25
z <- x %% y

# Functions and Vectors

# Functions are very important part of R
# Functions are basically pre-written R code that we can call by a name
# They allow us to write a little bit of code that does a lot of work!!
# Example
# There's a function for 'sine' in R
g <- sin(30)
print(g)
# There's also a function for 'cosine' in R
h <- cos(45)
print(h)


# We can write functions ourselves
# Let's write a function that gives us the fourth power of a value plus 8

beez_function <- function(arg_1){
  result <- arg_1^4 + 8
  return(result)
}

new_function <- function(arg_1){
  result <- arg_1/2 + 5
  return(result)
}

x <- new_function(20)
print(x)
# Now let's call the function
# Let's call the function with the input of 3
# This should give us the result of 89
# We can print it out
function_result <- beez_function(3)
print(function_result)
# We can also call it using a more descriptive method
function_result <- beez_function(arg_1=3)
print(function_result)


# Important tips - Good practices
# When naming variables it's important to follow the same format
# It's good to be descriptive when naming variables
# It allows us to quickly identify what it means
# Example - Let's think you are entering the birth year of someone
# What is more understandable from the two variables below?
j <- 1992
jeewantha_birth_year <- 1992
# Obviously it's the second one. It tells us more about what the value means
# So, it important that you name your variables intelligently


# Vectors and Sequences
# A vector is basically a series of numbers, characters, or strings
vector_of_numbers <- c(1,2,3,4,5)
# Now print the list_of_numbers
vector_of_numbers
# There are some functions that allows us to generate a sequence of numbers
sequence_of_numbers <- seq(1,50)
sequence_of_numbers
# We can also create a sequence by gaps
# Here we create a vector that will go from 1 to 50 while skipping 2 numbers at
# a time - 1,3,5,7,9.....
sequence_numbers_gaps <- seq(1,50,6)
sequence_numbers_gaps
# There's also a shorthand method of creating a vector
sequence_of_numbers <- 1:50
# The above is the same as 'seq(1,50)'
# Also remember that sequences are vectors as well

# Example of vector operations
# Normal arithmetic functions can be performed on vectors
# We can add a value to a vector
# Let's take a vector of five numbers
vector_of_numbers_2 <- c(25, 64, 87, 29, 55)
# Now let's add '1' to this vector
vector_of_numbers_2+1
# You can see that '1' was added to each number in the vector
# This can be done for every arithmetic operation you can think of
# Let's do a real world example!!!
# Let's say that we take the weight of 5 people on 1st of June, 2021
weight_june_2021 <- c(50.5, 62, 84.2, 48.6, 75)
# Then let's take their weight again on 1st of September, 2021
weight_september_2021 <- c(52, 52, 87.5, 51.9, 72.3)
# Now let's see what the difference in weight is for each of them
weight_difference <- weight_september_2021 - weight_june_2021
print(weight_difference)


# Plotting with R
# Basic plots
# Just a taste of what's to come
# Don't take this too seriously. This is just to keep you interested
# Let's take the hemoglobin patients and make plots for them

plot(weight_june_2021, type="o", col="blue", main="Weight fluctuations",
     xlab="Patient", ylab="Weight (kg)", ylim=c(45,90))
lines(weight_september_2021, type="o", col="red", ylab="", xlab="")


# Hemoglobin - Exercise
hemoglobin_day_1 <- c(12.5,16.7,13.3,16.4,12.8,17.6)
hemoglobin_day_2 <- c(18,9.8,13.2,12.4,13.2,11.6)

plot(hemoglobin_day_1, type="o", col="blue", main="Hemoglobin",
     xlab="Patient", ylab="", ylim=c(8,20))
lines(hemoglobin_day_2, type="o", col="red", ylab="", xlab="")


# Conditional flow control with R
# Programming languages have different methods to work with conditional
# programming

# If/Else If/Else
# These structures are useful for when you want a certain variable to be
# treated different based on it's value

# Let's take the example from the Powerpoint presentation
a <- 70
# Is it greater than 250? If so, then print 'Bigger than 250'
# If not, is it smaller than 50? If not, then print 'Between 50 and 250'
# If yes, then print 'Smaller than 50'
if (a>250){
  print('Bigger than 250')
} else if(a<50){
  print('Smaller than 50')
} else {
  print('Between 250 and 50')
}

# While loops
# While loops allows us to repeat a block of code until a certain condition
# is fulfilled
a <- 120
while (a<1000){
  print(a)
  a <- a+250
}


# For loops
# For loops allows us to repeat a block of code until the end of a sequence or
# a vector is reached
# Here we will loop through a vector and print the square of each of it's
# numbers
sequence_of_numbers <- seq(1,25)
for(i in sequence_of_numbers){
  print(i^2)
}

beez_sequence <- seq(1,10,3)
for(b in beez_sequence){
  result <- b+3
  print(result)
}

# Final exercise
# Do the Hemoglobin exercise Part II

hemoglobin_day_2 <- c(18,9.8,13.2,12.4,13.2,11.6)

for(hemo in hemoglobin_day_2){
  if(hemo>17){
    print("High hemoglobin levels")
  } else if (hemo<11){
    print("Low hemoglobin levels")
  } else{
    print("Normal hemoglobin levels")
  }
}