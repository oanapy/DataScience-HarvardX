# this script focuses on several R basic commands to use when working with a dataset modified according to what I find interesting in this dataset
install.packages("magrittr")
library(magrittr) #needed to be able to use the pipe operator
install.packages("dslabs") #install the package specifically written for this course 
#install.packages("dplyr") #install dplyr - a grammar of data manipulation - THIS COMMAND DID NOT INSTALL THE FINAL VERSION OF dplyr
devtools::install_github("hadley/dplyr") #but this worked
library(dslabs) #load the packages
library(dplyr)
data(murders) #load the data with which the following script will work

str(murders) #offers short description of the data file
names(murders) #designed to extract the column names from a data frame. Can also be used to associate the elements from a vector to another vector (temperatures to cities for example)
class(murders) #used to determine the class of an object (character, numeric or logical)

a <- murders$abb # Use the accessor($) to extract state abbreviations from the dataset and assign it to a
b <- murders[["abb"]] #the double square brackets ar an equivalent for the $ (accessor)
identical(a, b) # We can confirm these two are the same, it return a logical variable. TRUE in our case.
#if you instead try to access a column with just one bracket, R returns a subset of the original data frame containing just this column. This new object will be of class data.frame rather than a vector

length(levels(murders$region)) #nested way to determine the number of unique categories contained in the region variable

table(murders$region) #table() takes a vector as input and returns the frequency of each unique element in the vector

sorted_pop <- sort(murders$population) #sorts the population values in ascending order and save the result in an object
ordered_pop <- order(murders$population) #order() returns the index vector needed to sort the vector. So sort(x) and x[order(x)] are equivalent


states <- murders$state # Defines a variable states to be the state names from the murders data frame
ranks <- rank(murders$population) # Defines a variable ranks to determine the population size ranks 
ind <- order(murders$population)# Defines a variable ind to store the indexes needed to order the population values
my_df <- data.frame(state = states[ind], rank = ranks[ind]) # Create a data frame my_df with the state name and its rank and ordered from least populous to most 

data(na_example) #loads a dataset with NA values
a <- is.na(na_example) #assigns TRUE for NA values and FALSE for numeric/characters
na_example[!a] #SORCERY TO REMOVE NA VALUES

high <- murders$population > 10000000 #defines a variable to store logical values for each state: TRUE if population is bigger than 10000000 and FALSE otherwise
which(high) #gives the index of the logical vectors that are TRUE

abbs <- c("AK", "MI", "IA") # Stores 3 abbreviations in the abbs vector 
ind <- match(abbs, murders$abb) # Matches the abbs to the murders$abb. match() returns the index of the elements from the first vector found in the second vector
murders$state[ind] # Prints the state names found at the specific indices from ind
abbs %in% murders$abb # %in% returns logical values if an element is found in another element
ind2 <- which(!abbs%in%murders$abb) #finds the abbreviations that are not actually part of the dataset
abbs[ind2] # shows What are the entries of abbs that are not actual abbreviations

murders <- mutate(murders, population_in_millions = population / 10^6) #adds a new column/changes the existing one from a table. In this case adds a new one
select(murders, state, population) # filters data by subsetting columns. In this case shows only the state and the population columns from the murders dataset
filter(murders, state == "New York") #used to choose specific rows of the data frame
murders%>%filter(region%in%c("Northeast", "West"))%>%select(state) #piping multiple commands on a dataset following a typical workflow: DATA -> FILTER -> SELECT
# 