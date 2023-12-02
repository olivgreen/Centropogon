install.packages("ggplot2")
install.packages("RColorBrewer")
install.packages("readxl")
library(ggplot2)
library(RColorBrewer)
library(readxl)





setwd("/Users/livdegreen/OneDrive\ -\ Louisiana\ State\ University/undergrad\ research")
mydata <- read.csv("alsophilus avg.csv", header = T)
#look at data table headers
head(mydata)
#get summary stats
summary(mydata)
stats = summary(mydata)
write.csv(stats, file = "alsophilus_stats.csv")

#look at stats for 1 column or individual column
summary(mydata$flower_len_cm)

#look at mean or sd of one column
mean(mydata$degree_curvature)
sd(mydata$degree_curvature)
