data {
  int<lower=1> N;
  int<lower=1> T;
  int<lower=1,upper=T> Tsubj[N];
  real rewlos[N, T];
  int ydata[N, T];
}
###################
#
# This is a modification of the hBayesDM package igt_pvl_delta model to account for trial
# dependent choices.  Here the consistency parameter theta(t) = (t/10)^c
# where c is between (-5,5)
#
# Prior on sigma has been changed from Cauchy(0,5) to a InvGamma(5,1) prior on sigma^2
#
# Potential problem: The stan file is compiled from the working directory
# within the corresponding R file
#
# Last Modified April 17, 2017
# Dave Campbell
#
#
###################
transformed data {
  vector[4] initV;
  initV  = rep_vector(0.0,4);
}

parameters {
  # Declare all parameters as vectors for vectorizing
  # Hyper(group)-parameters  
  vector[4] mu_p;  
  vector<lower=0>[4] sigma2;
    
  # Subject-level raw parameters (for Matt trick)
  vector[N] A_pr;
  vector[N] alpha_pr;
  vector[N] cons_pr;
  vector[N] lambda_pr;
}

transformed parameters {
  # Transform subject-level raw parameters 
  vector<lower=0,upper=1>[N]  A;
  vector<lower=0,upper=2>[N]  alpha;
  vector<lower=-5,upper=5>[N]  cons;
  vector<lower=0,upper=10>[N] lambda;
    
  for (i in 1:N) {
    A[i]      = Phi_approx( mu_p[1] + sqrt(sigma2[1]) * A_pr[i] );
    alpha[i]  = Phi_approx( mu_p[2] + sqrt(sigma2[2]) * alpha_pr[i] ) * 2;
    cons[i]   = Phi_approx( mu_p[3] + sqrt(sigma2[3]) * cons_pr[i] ) * 10 - 5;
    lambda[i] = Phi_approx( mu_p[4] + sqrt(sigma2[4]) * lambda_pr[i] ) * 10;

  }
}

model {
  # Hyperparameters
  mu_p  ~ normal(0, 1);
  sigma2 ~ inv_gamma(5, 1);
  
  # individual parameters
  A_pr      ~ normal(0,1);
  alpha_pr  ~ normal(0,1);
  cons_pr   ~ normal(0,1);
  lambda_pr ~ normal(0,1);
    
  for (i in 1:N) {
    # Define values
    vector[4] ev;
    real curUtil;     # utility of curFb
    real theta;       # theta = (10/t)^c  

    # Initialize values
    #theta = pow(t/10, cons[i]);# now dealt with in line 78
    ev = initV; # initial ev values
        
    for (t in 1:(Tsubj[i]-1)) {
      if ( rewlos[i,t] >= 0) {  # x(t) >= 0
        curUtil = pow(rewlos[i,t], alpha[i]);
      } else {                  # x(t) < 0
        curUtil = -1 * lambda[i] * pow( -1*rewlos[i,t], alpha[i]);
      }
            
      # delta
      ev[ ydata[i, t] ] = ev[ ydata[i, t] ] + A[i]*(curUtil - ev[ ydata[i, t] ]);



      # softmax choice
      theta = pow(t, cons[i])/pow(10, cons[i]);
      ydata[i, t+1] ~ categorical_logit( theta * ev );

    }
  }
}

generated quantities {
  # For group level parameters
  real<lower=0,upper=1>  mu_A;
  real<lower=0,upper=2>  mu_alpha;
  real<lower=-5,upper=5>  mu_cons;
  real<lower=0,upper=10> mu_lambda;
  
  # For log likelihood calculation
  real log_lik[N];

  mu_A      = Phi_approx(mu_p[1]);
  mu_alpha  = Phi_approx(mu_p[2]) * 2;
  mu_cons   = Phi_approx(mu_p[3]) * 10 - 5;
  mu_lambda = Phi_approx(mu_p[4]) * 10;

  { # local section, this saves time and space
    for (i in 1:N) {
      # Define values
      vector[4] ev;
      real curUtil;     # utility of curFb
      real theta;       # theta = 3^c - 1  
      
      # Initialize values
      log_lik[i] = 0;
      #theta = pow(t/10, cons[i]); #now inline at 119
      ev = initV; # initial ev values
            
      for (t in 1:(Tsubj[i]-1)) {
        if ( rewlos[i,t] >= 0) {  # x(t) >= 0
          curUtil = pow(rewlos[i,t], alpha[i]);
        } else {                  # x(t) < 0
          curUtil = -1 * lambda[i] * pow( -1*rewlos[i,t], alpha[i]);
        }
              
        # delta
        ev[ ydata[i, t] ] = ev[ ydata[i, t] ] + A[i]*(curUtil - ev[ ydata[i, t] ]);

        # softmax choice
        theta = pow(t, cons[i])/pow(10, cons[i]);
        log_lik[i] = log_lik[i] + categorical_logit_lpmf( ydata[i, t+1] | theta * ev );
      }
    }
  }
}
