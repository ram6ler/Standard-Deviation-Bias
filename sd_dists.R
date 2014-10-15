# Demonstrate how sd calculated with denominator n
# introduces bias compared to sd calculated 

library("trotter")

pop.size <- 20
samp.size <- 5

my.population <- rnorm(pop.size)
pop.sd <- sd(my.population) * (pop.size - 1) / pop.size

indices <- 1:pop.size

# Generate a pseudo-vector containing all sample combinations
all.samples <- cpv(samp.size, indices)

# Sample standard deviations calculated with denominator n
sd.n <- sapply(
  1: length(all.samples),
  function(s) {
    dummy.sample <- sapply(all.samples[s], function(x) my.population[x])
    sd(dummy.sample) * (samp.size - 1) / samp.size
  }
)

# Sample standard deviations calculated with denominator n - 1
sd.n_1 <- sapply(
  1: length(all.samples),
  function(s) {
    dummy.sample <- sapply(all.samples[s], function(x) my.population[x])
    sd(dummy.sample)
  }
)

par(mfrow = c(2, 1))

hist(
  sd.n,
  main = "Distribution of sample SD; denominator n",
  xlab = "Standard deviation"
)
abline(
  v = pop.sd,
  lty = "dashed",
  lwd = "2",
  col = "red"
)

hist(
  sd.n_1,
  main = "Distribution of sample SD; denominator n - 1",
  xlab = "Standard deviation"
)
abline(
  v = pop.sd,
  lty = "dashed",
  lwd = "2",
  col = "red"
)