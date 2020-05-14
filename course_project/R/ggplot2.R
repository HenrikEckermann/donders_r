library(tidyverse)
# run install.packages("nycflights13)" before the next line 
library(nycflights13) # for several dataframes 




#####################################################################
##########               scatterplot                       ##########
#####################################################################

milk <- read_delim(file = "https://raw.githubusercontent.com/rmcelreath/rethinking/master/data/milk.csv", delim = ";")
childcare <- read_csv("data/childcare.csv")


head(milk)
# last week we covered the basics...
# lets explore some more options for scatterplots!

# check https://ggplot2.tidyverse.org/reference/geom_point.html (aesthetics)
# alpha, size, color, shape and more  
ggplot(milk, aes(x = neocortex.perc, y = kcal.per.g)) +
  geom_point(
    alpha = 0.5, 
    size = 10, 
    color = "blue", 
    shape = 21, 
    fill = "white",
    stroke = 5
  )
  
# if you want to make these aesthetics depend on a certain variable you do that
# withing the aes function at the top level (ggplot) but you can also do it 
# within the geom function if you want behavior to be local to specific data 

# usually like this 
ggplot(milk, aes(x = neocortex.perc, y = kcal.per.g, shape = clade, color = clade)) +
  geom_point(
    alpha = 0.5, 
    size = 7,  
    fill = "white",
    stroke = 5
  )
# which colors are available in R? 
colors()


# this results in the same plot 
ggplot(milk, aes(x = neocortex.perc, y = kcal.per.g)) +
  geom_point(
    aes(shape = clade, color = clade),
    alpha = 0.5, 
    size = 7,  
    fill = "white",
    stroke = 5
  )

# we cover why this can be useful later 


# you want to plot a categorical with a numerical variable, use jitter instead
ggplot(milk, aes(x = clade, y = kcal.per.g)) +
  geom_point(size = 5)
  
ggplot(milk, aes(x = clade, y = kcal.per.g)) +
  geom_jitter(width = 0.1, size = 5)
  
  
  
#####################################################################
##########               Line graphs                       ##########
#####################################################################

# two numerical variables AND when x is a continuous sequence (e.g. time series)

# Example 1: random walk
df <- tibble(
  sequen = 1:1000,
  value = c(0, rep(NA, 999))
)



for (i in df$sequen[-1]) {
   df[i, "value"] <- df[i - 1, "value"] + runif(-1, 1, n = 1)
}

ggplot(df, aes(x = sequen, y = value)) +
  geom_line()

# Example 2: time series data 
head(weather)
glimpse(weather)
#  for simplicity let’s only consider hourly temperatures at Newark airport for
# the first 15 days in January
weather %>%
  filter(origin == "EWR" & month == 1 & day <= 15) %>%
  ggplot(aes(time_hour, temp)) +
    geom_line()






#####################################################################
##########               Histograms                        ##########
#####################################################################


# to check distributions of variables

# 1. cut the x-axis into a series of bins, where each represents a range of x
# 2. for each bin, we count the number of observations that fall in the range 
# 3. for each bar draw the hight according to the count

# geom_point is not really useful here 
ggplot(weather, aes(x = temp, y = 0)) +
  geom_point()


ggplot(weather, aes(x = temp)) +
  geom_histogram(color = "white", fill = "firebrick")

# the default binwidth of 30 makes it hard to read. we have two options now:

ggplot(weather, aes(x = temp)) +
  geom_histogram(bins = 20, color = "white", fill = "steelblue")
  
ggplot(weather, aes(x = temp)) +
  geom_histogram(binwidth = 10, color = "white", fill = "steelblue")
  
  
  
#####################################################################
##########                  facets                         ##########
#####################################################################

# to split plots by values of another variable 

ggplot(weather, aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~month)

# play with nrows or alternatively ncols
ggplot(weather, aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~month, nrow = 4)

# I want you to be aware of the scales argument ("free", "free_x")
ggplot(weather, aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~month, scales = "free")

#####################################################################
##########               Boxplots                          ##########
#####################################################################

# Boxplots are great summary plots as they show:

# 1. Minimum
# 2. First quartile (25th percentile)
# 3. Median (second quartile, 50th percentile)
# 4. THird quartile (75th percentile)
# 5. Maximum

# 2. - 4. is the interquartile range
# Keep in mind that the whiskers extend no more than 1.5x the interquartile
# range from either end. Datapoints outside of that will be shown as points 

# they need a continuous y aesthetic and if x will be specified, then it 
# should be a categorical variable 

ggplot(weather, aes(y = temp)) +
  geom_boxplot()
  
# with a categorical on the x axis (see now you get outliers)
ggplot(weather, aes(x = factor(month), y = temp)) +
  geom_boxplot()


#####################################################################
##########               Barplots                          ##########
#####################################################################


# to visualize the distribution of categorical variables

# depending on whether our categories are already counted or not, we need to
# use either geom_bar or geom_col.

# uncounted
milk

# counted 
milk %>% count(clade) 


  
# uncounted 
ggplot(milk, aes(x = clade)) +
  geom_bar()

# counted 
milk %>% count(clade) %>%
  ggplot(aes(x = clade, y = n)) +
    geom_col()

childcare <- childcare %>% mutate(
  sex = as.factor(sex),
  sibling = as.factor(sibling),
  csection = as.factor(csection)
)
# joint distribution of two categoricals:
ggplot(childcare, aes(sibling)) +
  geom_bar()
  
ggplot(childcare, aes(sibling, fill = sex)) +
  geom_bar()

# alternative: dodged barplots 
ggplot(childcare, aes(sibling, fill = sex)) +
  geom_bar(position = "dodge")

# and you already know another alternative:
ggplot(childcare, aes(sibling)) +
  geom_bar() +
  facet_wrap(~sex)

#####################################################################
##########               AVOID                             ##########
#####################################################################


# 1 PIE charts: you cannot easily compare "parts of the cake"

# 2 Dynamite plots 

ggplot(mtcars, aes(x = cyl, y = wt)) +
  stat_summary(fun.y = mean, geom = 'bar', fill = 'skyblue') +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1)













# The bars do not show data above 4 in this case although the error bars indicate higher max values (the max is 5.242). Not a big deal if the text explains well what the plot is showing. But a good plot does not need a lot of explanation. Furthermore, we cannot see how much datapoints are there for each cyliner based on the plot.


# A better alternative to get the same and even more information is plotting the individual data points. Note that the cylinders are 4,6 and 8 and that the points are spread to avoid overplotting. This is a good alternative for relatively small data sets and variables that are normally distributed, not having extreme outliers. 


ggplot(mtcars, aes(x = cyl,y = wt)) +
  geom_jitter(width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', color = 'red') +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.2, col = 'red') +
  theme_bw()
  
  
  
  
  

#####################################################################
##########               more examples                     ##########
#####################################################################


# displ = engine displacement in liter 
# hwy = highway miles per gallon
# drv = type of drive train 
# cyl = number of cylinders
# facitting by two variables 



ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl)
  

# coord flip 
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()



