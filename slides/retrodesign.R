install.packages("retrodesign")
library(retrodesign)
library(tidyverse)

# The posited effects Gelman and Carlin consider
effect_sizes <- list(.1, .3, 1, 2, 3)
standard_error <- 3.3
retro_design(effect_sizes, standard_error) 



