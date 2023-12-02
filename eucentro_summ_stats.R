#FIRST copy this code & make your own script so you can edit yours with any additional notes/code
#install packages 

# Load libraries
library(dplyr)
library(ggplot2)
library(tidyverse)
library(psych)

#Create a folder titled morphometrics where you want (for example in Downloads or Desktop) the floral_data.csv to be
#Set the working directory to where your data is located, in this case it would be where you saved the csv file

setwd("C:/Users/odegr/OneDrive - Louisiana State University/undergrad research/R stats/data")
#example:


# Read the data from CSV file
centro_data <- read.csv("complete_centro.csv", na.strings=c("N/A"))

#see if data loaded 
head(centro_data)

#What is the type of each variable?
unlist(lapply(centro_data, class))

#convert variables that are listed as characters to numeric (except species name) so we can get the stats for all variables 
centro_data <- centro_data %>%
  mutate_at(vars(-scientificName), as.numeric)


#average repeated individuals




#converts data into tibble data frame for easier analysis 
my_data <- as_tibble(centro_data)
my_data


####Summary statistics of grouped data####

#counts the number of measurements for each species (we may have to think this thru a bit)
my_data %>%
  group_by(scientificName) %>%
  summarise(
    count = n()
  ) %>%
  print(n = 42)

#summarizes the mean of each trait for each species
summary_data <- my_data %>%
  group_by(scientificName) %>%
  summarise_if(is.numeric, mean, na.rm = TRUE)
summary_data

# Save the summarized means data to a CSV file
write.csv(summary_data, "summary_data.csv", row.names = FALSE)

#On Friday we will standardize the data but for now this is okay 

#using the package psych we can look at the data grouped by species
#Here is the website I used if you want to understand the outputs better
#https://statsandr.com/blog/descriptive-statistics-in-r/ 

library(psych)

describeBy(
  floral_data,
  group = floral_data$scientificName # grouping variable
)

#copy & paste the output to a text document using BBEdit & save as stats_by_species

#######Explore the Data########
#on friday we will Log the data to standardize it but for now just play around & see what you notice

#scatterplots can help explore potential correlations between variables 

plot(centro_data$corolla_base_cm, centro_data$flower_len_cm)
plot(centro_data$flower_len_cm, centro_data$corolla_base_cm)
plot(centro_data$anther_len_cm, centro_data$flower_len_cm)

#scatterplots are even more informative when differentiating the points according to a factor, in this case the species
ggplot(centro_data) +
  aes(x = flower_len_cm, y = corolla_base_cm, colour = scientificName) +
  geom_point() +
  scale_color_hue()


ggplot(centro_data) +
  aes(x = base_apex_ratio, y = flower_len_cm, colour = scientificName) +
  geom_point() +
  scale_color_hue() +
  theme(legend.key.size = unit(0.01, 'mm'),
        legend.title = element_text(size=14))

ggplot(centro_data) +
  aes(x = leaf_len_width_ratio, y = leaf_area_cm2, colour = scientificName) +
  geom_point() +
  scale_color_hue() +
  theme(legend.key.size = unit(0.01, 'mm'),
        legend.title = element_text(size=14))

#how would you interpret this plot? notice any outliers?
#If you have time, play around with other variables & we can take a look at them on Friday 


