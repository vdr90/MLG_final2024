data {
  int<lower=0> N;  //número de canciones
  vector[N] y;     // popularidad de las canciones
  int<lower=0> Nartist; // número de artistas
  array[N] int artist; // id's artistas
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real mu;                 //promedio, se supone 50
  real<lower=0> sigma;    // varianza
}

model {
  for (i in 1:N) {
    y[i] ~ normal(mu, sigma); // verosimilitud
  }
  // y ~ normal(mu, sigma);
  mu ~ normal(50,52);
  sigma ~ exponential(0.048);
}

generated quantities {
  vector[Nartist] mu_artist;
  for (i in 1:Nartist) {
    mu_artist[i] = normal_rng(mu, sigma);
  }
}

