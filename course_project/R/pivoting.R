# childcare <- mutate(childcare, birthweight = round(birthweight, 2), age_d = round(age_d), bf_ratio = round(bf_ratio, 2), shannon = round(shannon, 2))
# 
# childcare <- mutate(childcare, s_age_d = scale(age_d)[, 1], s_birthweight = scale(birthweight)[, 1], s_shannon = scale(shannon)[, 1])
# childcare
# 
# writexl::write_xlsx(childcare, "data/childcare.xlsx")
# write_csv(childcare, "data/childcare.csv")

