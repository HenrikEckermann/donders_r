# README: the interpretation of model parameters in the Understanding part 
# are NOT in line with frequentist framework (the frequentist would predict
# the point estimate always). To emphasize uncertainty I include the SE in 
# prediction.
theme_set(theme_bw(base_size = 20))
library(tidyverse)
library(glue)
  


#####################################################################
##########         Understanding Linear Regression         ##########
#####################################################################


mu <- 10
sigma <- 1
y <- rnorm(mean = mu, sd = sigma, n = 1e5)

y[1:10]

df <- tibble(y = y)

ggplot(df, aes(y = y)) +
  geom_density() +
  coord_flip()


# to illustrate how linear regression makes use of the gaussian distribution
# let us model an example for the purpose of prediction.


data(Howell1, package = "rethinking")

d <- Howell1
adults <- filter(d, age > 20)
ggplot(adults, aes(height)) +
  geom_histogram(aes(y = ..density..), fill = "white", color = "black") +
  geom_density(color = "black", size = 3)

# another way of showing the data 
adults %>% mutate(id = 1:dim(adults)[1]) %>%
  ggplot(aes(id, height)) +
    geom_point() # +
    # geom_hline(yintercept = mean(adults$height), size = 3, color = "red") 


# If we have only the outcome "height" and nothing more, what would be our guess
# if someone asked us about the height of a random person of the same
# population (not the same sample of adults)? Lets ask our regression robot:


model1 <- lm(formula = height ~ 1, data = adults)
summary(model1)

# what happens if we standardize the outcome?
# adults <- mutate(adults, height_s = scale(height)[, 1])
# model1_s <- lm(formula = height_s ~ 1, data = adults)
# summary(model1_s)


class(model1)
model1$coefficients
residuals(model1)
coefficients(model1)

# given our data and this model (linear regression), our best guess would be 
# 154.75. We are pretty confident that this is our best guess (see standard
# error). But we also know that our guess will only be good on average and 
# that each single guess can be far off (residual standard error). Our model 
# "thinks" like this: (illustrating why 157.75 is it's best guess): 

height <- rnorm(mean = 154.7477, sd = 7.799, n = 1e5)
df_height <- tibble(
  height = height,
  id = 1:length(height)
)
df_height  %>%
  ggplot(aes(height)) +
    geom_histogram(aes(y = ..density..), fill = "white", color = "black") +
    geom_density(color = "black", size = 3)

# another way of showing how the model operates"
df_height %>% 
  ggplot(aes(id, height)) +
    geom_point(alpha = 0.1) +
    geom_hline(yintercept = model1$coefficients, color = "red", size = 3)


# luckily we have more information than that and that is where the real power
# of linear regression comes from! We model the parameter mu as a linear combi-
# nation of other variables:

model2 <- lm(height ~ 1 + weight, data = adults)

# Given that we know the weight of people, what would be our best guess
# of their height?

summary(model2)

# given our data and model2, our best guess would be 
# 113.37 + weight * 0.92. We are pretty confident that this is our best guess
# (see standard errors intercept and weight). Instead of guessing one value for
# any person, now our best guess depends on the weight of that person. 
# Each average guess will be better this time and less far off than
# before (residual standard error). Our model "thinks" like this: 


# for a person with weight 40:
mu <- 113.36888 + 40 * 0.91651
sigma <- 5.101
height <- rnorm(mean = mu, sd = sigma, n = 1e5)
df_height <- tibble(
  height = height,
  id = 1:length(height)
)
df_height  %>%
  ggplot(aes(height)) +
    geom_histogram(aes(y = ..density..), fill = "white", color = "black") +
    geom_density(color = "black", size = 3)
# another way of showing the same data
df_height %>% 
  ggplot(aes(id, height)) +
    geom_point(alpha = 0.1) +
    geom_hline(yintercept = mu, color = "red", size = 3)



# or for a person with weight = 60
height <- rnorm(mean = 113.36888 + 60 * 0.91651, sd = 5.101, n = 1e5)
df_height <- tibble(
  height = height,
  id = 1:length(height)
)
df_height  %>%
  ggplot(aes(height)) +
    geom_histogram(aes(y = ..density..), fill = "white", color = "black") +
    geom_density(color = "black", size = 3)

df_height %>% 
  ggplot(aes(id, height)) +
    geom_point(alpha = 0.1) +
    geom_hline(yintercept = 
      model2$coefficients[1] + 60 * model2$coefficients[2],
      color = "red", size = 3)


# we can plot this for a range of weight values:
weight_seq <- seq(min(adults$weight) - 5, max(adults$weight) + 5, length.out = 30)
weight_seq

heights <- list()
for (w in seq_along(weight_seq)) {
    df <- tibble(
      height = rnorm(
        mean = model2$coefficients[1] + weight_seq[w] * model2$coefficients[2],
        sd = 5.101,
        n = 1e3),
      weight = weight_seq[w]
  )
  heights[[w]] <- df
}


heights <- bind_rows(heights)


ggplot(heights, aes(x = weight, y = height)) +
  geom_point(alpha = 0.1)

# and we can calculate our best guess for each weight, which is the regression 
# line!
best_guess <- tibble(
  weight_seq, 
  mu = model2$coefficients[1] + weight_seq * model2$coefficients[2])

ggplot(heights, aes(x = weight, y = height)) +
  geom_point(alpha = 0.1) +
  geom_line(data = best_guess, aes(x = weight_seq, y = mu), size = 3, color = "red")

# adding the real data 
ggplot(heights, aes(x = weight, y = height)) +
  geom_point(alpha = 0.1, color = "lightgrey") +
  geom_line(data = best_guess, aes(x = weight_seq, y = mu), size = 3, color = "red") +
  geom_point(data = adults, aes(x = weight, y = height),
    alpha = 0.5, 
      size = 2, 
      color = "firebrick", 
      shape = 1,
      stroke = 1)

# the same concept applies to categorical variables
model3 <- lm(height ~ 1 + male, data = adults)
summary(model3)
149.4578 + 11.1526

# given our data and model3, our best guess would be 149.46 for females and
# 160.61 for males. We are pretty confident etc...

df_height <- tibble(
  male = sample(c(0, 1), 1e4, replace = T),
  height = rnorm(1e4, mean = 149.4578 + male * 11.1526)
)
mu <- tibble(male = c(0, 1), mu = c(149.4578, 160.6104))
ggplot(df_height, aes(male, height)) +
  geom_point() +
  geom_line(data = mu, aes(male, mu), size = 3, color = "red")
  
# again adding the real data: 
ggplot(df_height, aes(male, height)) +
  geom_point(alpha = 0.1, color = "lightgrey") +
  geom_line(data = mu, aes(male, mu), size = 3, color = "red") +
  geom_jitter(data = adults, aes(x = male, y = height),
    alpha = 0.5, 
      size = 2, 
      color = "firebrick", 
      shape = 1,
      stroke = 1,
      width = 0.1
    )


# to show that this is nothing different than a STANDARD t test:
summary(model3)
t.test(height ~ male, data = adults, paired = FALSE, var.equal = TRUE)


# Now lets explore what our model predicts if we add both:
model4 <- lm(height ~ weight + male, data = adults)
summary(model4)

betas <- model4$coefficients
betas

heights <- map_dfr(weight_seq, function(w) {
  tibble(
    male = rep(c(0, 1), 5e3),
    height = rnorm(
      mean = betas[1] + w * betas[2] + male * betas[3],
      sd = 4.929,
      n = 1e4),
    weight = w,
    mu = betas[1] + w * betas[2] + male * betas[3]
  )
})

head(heights)

ggplot(heights, aes(weight, height)) +
  geom_point(alpha = 0.1) +
  geom_line(aes(y = mu), size = 3, color = "red") +
  facet_wrap(~male)
  
  
ggplot(heights, aes(weight, height)) +
  geom_point(alpha = 0.1, color = "lightgrey") +
  geom_line(aes(y = mu), size = 3, color = "red") +
  geom_point(data = adults, aes(x = weight, y = height),
    alpha = 0.5, 
      size = 2, 
      color = "firebrick", 
      shape = 1,
      stroke = 1) +
  facet_wrap(~male)



# But not all can be described well by a straight line.
# if you like, try to fit a polynomial regression!
ggplot(heights, aes(weight, height)) +
  geom_point(alpha = 0.1, color = "lightgrey") +
  geom_line(aes(y = mu), size = 3, color = "red") +
  geom_point(data = d, aes(x = weight, y = height),
    alpha = 0.5, 
      size = 2, 
      color = "firebrick", 
      shape = 1,
      stroke = 1) +
  facet_wrap(~male)

#####################################################################
##########               Performing Linear Regression      ##########
#####################################################################

# as we have seen, there are assumptions to linear regression that need to be
# tested:

final <- lm(height ~ 1 + weight + male, data = adults)

# 1. Is the gaussian model appropriate (often referred to as normality of
#    residuals)?

# lets first extract the residuals and the fitted values and then add them 
# to our dataframe:

# resid(model)
# fitted(model)


diag_df <- adults %>%
  mutate( 
    sresid = resid(final), 
    fitted = fitted(final)
  ) %>% 
  mutate(sresid = scale(sresid)[, 1])
  

# do you think the error (the residuals) are normally distributed?
ggplot(diag_df, aes(sresid)) +
    geom_density() +
    ylab('Density') + xlab('Standardized Redsiduals') 

# this plot lets us answer this easier:
ggplot(diag_df, aes(sample = sresid)) +
    geom_qq() 

# there are also statistical tests for this but think the analyst should 
# argue and decide whether or not the model is suited for the purpose of
# interest

# 2. Homogeneity of variance
#    The parameter sigma is estimated once (unlike mu which is estimated
#    for each new set of predictor value). Thus, it is assumed that sigma
#    is constant or "homogeneous" across the predictor space. Lets inspect 
#    if this is the case here:


diag_df$id <- 1:dim(diag_df)[1]

ggplot(diag_df, aes(fitted, sresid)) +
  geom_point(alpha = 0.6) +
  geom_smooth(se = F, color = "#f94c39") +
  geom_point(
    data = filter(diag_df, abs(sresid) > 3.5), 
    aes(fitted, sresid), color='red')  +
    ggrepel::geom_text_repel(
      data = filter(diag_df, abs(sresid) > 3.5), 
      aes(fitted, y = sresid, label = id), size = 3
    ) 

# Fitted vs observed
ggplot(diag_df, aes(fitted, height)) +
  geom_point(alpha = 0.6) +
  geom_smooth(se = F, color = '#f94c39')
  
  
# how about this model?
model <- lm(height ~ 1 + weight + male, data = d)

# 1. Is the gaussian model appropriate (often referred to as normality of
#    residuals)?


diag_df <- d %>%
  mutate( 
    sresid = resid(model), 
    fitted = fitted(model)
  ) %>% 
  mutate(sresid = scale(sresid)[, 1])
  

# do you think the error (the residuals) are normally distributed?
ggplot(diag_df, aes(sresid)) +
    geom_density() +
    ylab('Density') + xlab('Standardized Redsiduals') 

# this plot lets us answer this easier:
ggplot(diag_df, aes(sample = sresid)) +
    geom_qq() 



# 2. Homogeneity of variance



diag_df$id <- 1:dim(diag_df)[1]

ggplot(diag_df, aes(fitted, sresid)) +
  geom_point(alpha = 0.6) +
  geom_smooth(se = F, color = "#f94c39") +
  geom_point(
    data = filter(diag_df, abs(sresid) > 3.5), 
    aes(fitted, sresid), color='red')  +
    ggrepel::geom_text_repel(
      data = filter(diag_df, abs(sresid) > 3.5), 
      aes(fitted, y = sresid, label = id), size = 3
    ) 

# Fitted vs observed
ggplot(diag_df, aes(fitted, height)) +
  geom_point(alpha = 0.6) +
  geom_smooth(se = F, color = '#f94c39')
betas <- model$coefficients
summary(model)
weight_seq <- seq(min(d$weight) - 5, max(d$weight) + 5, length.out = 30)
heights <- map_dfr(weight_seq, function(w) {
  tibble(
    male = rep(c(0, 1), 5e3),
    height = rnorm(
      mean = betas[1] + w * betas[2] + male * betas[3],
      sd = 9.37,
      n = 1e4),
    weight = w,
    mu = betas[1] + w * betas[2] + male * betas[3]
  )
})
  
ggplot(heights, aes(weight, height)) +
  geom_point(alpha = 0.1, color = "lightgrey") +
  geom_line(aes(y = mu), size = 3, color = "red") +
  geom_point(data = d, aes(x = weight, y = height),
    alpha = 0.5, 
      size = 2, 
      color = "firebrick", 
      shape = 1,
      stroke = 1) +
  facet_wrap(~male)


# I used ggplot2 to follow up on your ggplot skills. However, for such 
# common plots, there will always be a package or as in this case a base 
# r function that is so much shorter:
plot(model)

# Now you know how to perform a regression. What else do you need to know 
# how to do in R in the context of regression?


# Hilde: How to do t-test:

# the standard t-test (as we saw) assumes homogeneity of variance
# you need to test this:
library(car)
leveneTest(adults$height, adults$male)
# then you can use the standard test 
males <- filter(adults, male == 1) %>% .$height 
females <- filter(adults, male == 0) %>% .$height
t.test(males, females, var.equal = TRUE)

# or here easier: 
t.test(height ~ male, data = adults, var.equal = TRUE)

# (problem with homogeneity of variance)
# a great feature in R is that the default is actually Welch t-test:
# (see https://www.rips-irsp.com/articles/10.5334/irsp.82/)
t.test(height ~ male, data = adults)

males <- na.omit(males)
males_post <- males + rnorm(n = length(males), 4, 1)
# perform a paired t test 
t.test(males, males_post, var.equal = TRUE, paired = TRUE)


# always check the function documentation no matter which analyses you use 
# e.g.: how does the model treat missingness? Often listwise deletion is
# default. But also some model impute by default or throw an error.


# as homework, please go through this page to see how to do x in R:
# https://www.statmethods.net/stats/index.html


