library(tidyverse)



# 3. Write a function that takes as arguments two numeric vectors and returns a named list that shows the Pearson as well as the Spearman correlation of these vectors.



cor_coef <- function(x, y) {
  pearson_r <- cor(x, y)
  spearman_r <- cor(x, y, method = "spearman")
  r_list <- list("pearson" = pearson_r, "spearman" = spearman_r)
  return(r_list)
}

# test the function 
cor_coef(mtcars$mpg, mtcars$wt)

# 4. Now rewrite this function by giving it another argument (linear = FALSE). Write the function so that it returns Pearson correlation when linear == TRUE and otherwise Spearman correlation.

cor_coef <- function(x, y, linear = FALSE) {
  cor_method <- if (linear) "pearson" else "spearman"
  cor_r <- cor(x, y, method = cor_method)
  return(cor_r)
}

# test the function 
cor_coef(mtcars$mpg, mtcars$wt)

cor_coef(mtcars$mpg, mtcars$wt, linear = TRUE)
