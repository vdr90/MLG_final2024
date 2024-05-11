data {
  int<lower=0> N;  //número de canciones
  vector[N] y;     // popularidad de las canciones
  int<lower=0> Nartist; // número de artistas
  array[N] int artist;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real mu;                       // Overall average popularity
  real<lower=0> sigma_y;         // Standard deviation of song popularity
  real<lower=0> sigma_mu;        // Standard deviation of artist popularity deviations
  vector[Nartist] b;             // Artist-specific deviations from average popularity
}

transformed parameters {
  vector[Nartist] mu_artist;     // Mean popularity for each artist
  for (j in 1:Nartist) {
    mu_artist[j] = mu + b[j];
  }
}

model {
  // Priors
  mu ~ normal(50, 52);           // Prior for overall average popularity
  b ~ normal(0, sigma_mu);        // Prior for artist-specific deviations
  sigma_y ~ exponential(0.048);  // Prior for song popularity variance
  sigma_mu ~ exponential(1);     // Prior for artist popularity deviation variance
  
  // Likelihood
  for (i in 1:N) {
    y[i] ~ normal(mu_artist[artist[i]], sigma_y);
  }
}

