data {
  int<lower=0> N;  //número de canciones
  vector[N] y;     // popularidad de las canciones
  int<lower=0> Nartist; // número de artistas
  array[N] int artist;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  vector[Nartist] mu_artist;                 //promedio, se supone 50
  real<lower=0> sigma;  
}

model {
  // Prior for artist popularity
  mu_artist ~ normal(50, 52);

  // Likelihood: Song popularity depends on artist popularity
  for (i in 1:N) {
    y[i] ~ normal(mu_artist[artist[i]], sigma);
  }

  // Prior for the common variance
  sigma ~ exponential(1);
}



