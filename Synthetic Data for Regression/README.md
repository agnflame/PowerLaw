# Regression using synthetic data to estimate short-time exponent

Data sampled from CME mean used in linear (log[mean mRNA count] - log[time]) and nonlinear regression  to estimate the short-time exponent of the mean mRNA count curve to determine the lower bound on the minimum number of inactive states in a gene expression system.

Format of data files:


N = Total number of states, see description and structure of N-state model.
N means N-1 inactive states, with 1 active state.

j = State that perturbation affected. e.g. if j=2, then state G_2 is the initial condition for the perturbation.

t referrs to the non-dimensional time. This has been calculated by multiplying the real time by the mRNA degradation rate.
If we take the median mRNA degradation rate to be approx. 9hrs, measured across thousands of genes in mammalian cells, then t=0.1 approx. = 1 hour, and t=0.01 approx. = 6 minutes.

5 data points were used in each linear regression, representing an experiment where the mean from a population of cells was sampled at 5 different times.

For example:

corresponds to:
N = 5, 5-state model, 4 inactive states with 4 activation steps until the 5th (single) active state.
j = 3, perturbation affected rate k_3 meaning the activation of transcription was halted at this reaction, thus the initial condition was mRNA count = 0 AND P(G_3)=1.
