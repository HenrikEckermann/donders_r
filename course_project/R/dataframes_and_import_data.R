library(tidyverse)



#####################################################################
##########            Dataframes and Tibbles Intro         ##########
#####################################################################


df <- data.frame(
  age = c(10, 12, 11, 9),
  name = c("Lilly", "Paul", "Jack", "Julia"),
  passed = c(TRUE, FALSE, FALSE, TRUE)
)


tbl_df <- tibble(
  age = c(10, 12, 11, 9),
  name = c("Lilly", "Paul", "Jack", "Julia"),
  passed = c(TRUE, FALSE, FALSE, TRUE)
)

class(df)
class(tbl_df)
tbl_df <- as.data.frame(tbl_df)



# to learn which datatypes the vectors within a dataframe have:

# tidyverse
glimpse(df)
# or base R
str(df)

# to see the column names:
colnames(df)
# colnames(df) <- c("A", "B", "C")


# to see rownames
rownames(df)


# also very important: the dimensions of a dataframe: rows and columns
dim(df)


# Since dataframes are basically lists with vectors of equal length,
# we can use the same extraction methods as we can use for lists:

# Extract the vector by name
df$age

df[["age"]]

# Extract the vector by position
df[[1]]
# also as with lists, if we leave one bracket, it will return the source 
# datatype (here a dataframe) instead of extracting the vector:
df["age"]
df[1]

# since dataframes are 2-dimensional, we need a way to also specify rows:
# there are several ways:

# 1 df[rownnumber(s), columnnumber(s)]
df[2:3, 1:2]
df[, 1]
df[2, c(1, 3)]

df

# you need to understand and memorize the above because it is frequently used
# However, the tidyverse style of viewwing and manipulating a dataframe is 
# using the select and filter functions. See some basic examples:


# 2 dyplr functions

# columns 
select(df, age)
select(df, age, passed)

select(df, -age)


# rows 
filter(df, passed == TRUE)
filter(df, name == "Julia")
filter(df, passed == TRUE, age < 12)

# is the same as 
filter(df, passed == TRUE & age < 12)

# before we learn in more detail how to manipulate a dafaframe, let's first
# learn how to import our own data!


#####################################################################
##########               Import data                       ##########
#####################################################################


# common function structure: read_filetype(filename, ...)




# csv files (difference between read_csv and read_csv2)
file <- "data/childcare.csv"



childcare <- read_csv(file)


# excel files 
file <- "data/childcare.xlsx"

childcare <- readxl::read_excel(file)




# SPSS files
# library(foreign)
# file <- "data/some_spss_file.sav"
# df <- read.spss(file, to.data.frame = TRUE)

# SPSS, SAS and STATA:
# see: https://haven.tidyverse.org/
# read_sas()
# read_sav()
# read_dta()



# Generally you find easily and quickly if you google:
# import xxx file in R 
# e.g. import excel files in R


# As we cover the basics of data import, we also want to take a quick look 
# at exporting data as it follows the same logic:




#####################################################################
##########               Export data                       ##########
#####################################################################
write_csv(df, path = "data/exported_df.csv")
writexl::write_xlsx(df, path = "data/exported_df.xlsx")





#####################################################################
##########      Dyplr Basics: Manipulate dataframes basics  #########
#####################################################################


# let's inspect the first 10 rows and the last 10 rows before we start 
# manipulating the dataframe using dplyr functions.
head(childcare, 3)
tail(childcare)

# The following functions are part of the dplyr package (tidyverse) and  work
# similarly: the first argument is a dataframe or tibble, the subsequent
# arguments describe what to do with the dataframe using the variable names
# WITHOUT  quotes. The result is a new dataframe (tibble). Since dyplr
# functions never modify their input, you need to store it in a new 
# object. 




select(childcare, id, age_d)
select(childcare, -age_d)
select(childcare, id, starts_with("s_"))
select(childcare, ends_with("n"), id)
select(childcare, id, contains("shannon"))




# the filter function always checks if a condition is TRUE for any value of the
# column you give 



# e.g. show all rows that have missing values in bf_ratio
filter(childcare, is.na(bf_ratio))

# or all that are older than 90 days and where csection equals to 1
filter(childcare, age_d > 90 & csection == 1)


# # a bit more advanced is to filter through all columns to search for NA
# filter_all(childcare, any_vars(is.na(.)))
# 
# # or to filter only at specified columns
# filter_at(childcare, vars(bf_ratio, csection), ~ is.na(.))



# arrange rows 

childcare

# order by csection vs not and then by age
arrange(childcare, csection, age_d)

# descending order
arrange(childcare, desc(age_d))


#####################################################################
##########               The pipe operator                 ##########
#####################################################################

# takes the object or output from the left side and puts it as the first
# argument of the next function:

# e.g.

head(childcare, 3)

# can be written as

childcare %>% head(3)

# beneficial if you have many operations that follow one another:

# instead of writing:
childcare_filtered <- filter(childcare, time == "pre", csection == 1)
childcare_selected <- select(childcare_filtered, id, shannon)
childcare_renamed <- rename(childcare_selected, subject_id = id)
childcare_renamed

# we can write:
childcare_renamed <- childcare %>%  
  filter(time == "pre", csection == 1) %>% 
  select(id, shannon) %>%
  rename(subject_id = id)

childcare_renamed


# sometimes the object/output should not be the first argument of the next 
# function. Then we can use the "." as a placeholder

gender <- list("male_1-female_0", "male_0-female_1", "male_0-female_1", "male_1-female_0")
gender

# see ?gsub: this function takes a character as the third argument
gender_female <- gender %>% 
  as.character() %>% # convert list to character
  gsub("(male_\\d)(-female_)(\\d)", "\\3", .) %>% # the "." tells %>% where 
  as.numeric() # convert to numeric

gender_female

# if you need repitition for understanding the pipe operator see 
# https://www.datacamp.com/community/tutorials/pipe-r-tutorial






# Next week we cover somewhat more complicated operations such as
# manipulating variables or creating new variables from existing ones.
