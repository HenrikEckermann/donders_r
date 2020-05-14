#####################################################################
##########               Linear Regression in R            ##########
#####################################################################

# Most models can be specified using a formula with the notation:
# y ~ x1 + x2 ... + xn

# which corresponds to:
# Y ~ N(mu, sigma)
# mu = a + b1*x1 + b2*x2 ... + bn*xn
# sigma, b1, b2 - bn will be estimated from the data

# This model specification tells us that such a model (once fit) gives us the 
# expected mean if we give to it all predictor variables. We can simulate our 
# own data
