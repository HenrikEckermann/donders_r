library(tidyverse)

# load data 
childcare <- read_csv("data/childcare.csv")



#####################################################################
##########               Homework session 3                ##########
#####################################################################



# 5. Create another new R file called dataframes.R. Open it. In R, there is a preloaded dataframe called "mtcars". Using only the methods we learned today, try to perform the following actions:
#    - Take a look at the first 10 rows and last 10 rows

head(mtcars)

tail(mtcars)


# - Create a new dataframe that only retains the columns mpg, disp and hp of cars that have 6 cylinders (cyl is the column for the number of cylinders). First use the base R method using the brackets. Then use dplyr functions to achieve the same!

# base R
df <- mtcars[mtcars$cyl == 6, c("mpg", "disp", "hp")]

# dyplyr 
df <- mtcars %>%
  filter(cyl == 6) %>%
  select(mpg, disp, hp)

# Note that the rownames are gone because the use of rownames in tidyverse 
# is deprecated. You can use rownames_to_column("name_of_column")
# e.g. 

dfr <- mtcars %>% 
  rownames_to_column("car") %>%
  filter(cyl == 6) %>%
  select(car, mpg, disp, hp)


# - How many observations are in this new dataframe?
dim(df)
df

# - export that file to an excel file in your data folder
writexl::write_xlsx(df, path = "data/select_cars.xlsx")




