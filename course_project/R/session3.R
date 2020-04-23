

# add new variable or change existing ones with mutate 



# change between long and wide format:

# lets say we wanted to have the variables xxx.length/width as categories


# for more complicated use cases see also the following link: 
# https://tidyr.tidyverse.org/dev/articles/pivot.html


# childcare <- mutate(childcare, birthweight = round(birthweight, 2), age_d = round(age_d), bf_ratio = round(bf_ratio, 2), shannon = round(shannon, 2))
# 
# childcare <- mutate(childcare, s_age_d = scale(age_d)[, 1], s_birthweight = scale(birthweight)[, 1], s_shannon = scale(shannon)[, 1])
# childcare
# 
# writexl::write_xlsx(childcare, "data/childcare.xlsx")
# write_csv(childcare, "data/childcare.csv")


mtcars
