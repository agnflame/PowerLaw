# Comparing the steady-state mRNA count distributions of the $N$-state models and effective telegraph model

This folder contains the data used in Fig. 2 to demonstrate that across vast regions of the $N$ = 3, 4, 5 state model parameter space (sampled in the physiological range) the steady-state mRNA count distribution is very well approximated by that of the effective telegraph model, given by the rate parameter mapping detailed in the paper.

## Notebook

Also in this folder is the mRNA_dist_FSP.ipynb notebook which illustrates the calculation of the $N$ = 5-state model and effective telegraph model steady-state mRNA count distributions for a given parameter set, using the Finite State Projection (FSP) algorithm of solving the chemical master equation (CME).
The notebook shows the calculation of the: joint distribution (as given by the CME), marginal mRNA count distribution (probability mass function), cumulative distribution function (CDF), and Wasserstein distance (computed using the two CDFs).

## Data

The results of comparing the corresponding steady-state mRNA count distributions can be found within the $N$ = 3, 4, 5 state model subfolders and are stored in .csv files.
Since the models with more gene states required a greater number of samples than models with fewer gene states, the increased number of results are spread across more files.
These files contain:
- $N$-state model parameters ($k_i$ for $i = 1,\dots,N$; $\rho^{\ast}$; $d$)
- effective telegraph model parameters ($k_{on}$; $k_{off}$; $\rho$)
- distance metrics (Wasserstein distance (WD), Hellinger distance, etc.)
- number of and position of modes (for both the mRNA count distributions and waiting time distribution)
- important statistics of the mRNA count distributions (e.g. mean, variance, Fano factor, skewness, kurtosis)
- numerical mRNA count distributions (probability mass function and CDF, as vectors)
- distribution shape classifier (i.e. Shape I, II, III, or IV)

Note that in the paper the transcription (mRNA synthesis) rates $\rho$ and $\rho^{\ast}$ and degradation rate $d$ are denoted by $\alpha$, $\alpha^{\ast}$, and $\beta$ respectively in the data files.

### Distribution shapes

The parameter sets chosen for Fig. 2D-G and Fig. S1 can be found in the file Distribution_shapes_in_Fig2_FigS1.xlsx, along with important statistics, distance metrics, and numerical distributions.
These parameter sets are also given in Tables II and VI.

### Boxplots percentiles

The results from each parameter set were used to compute the distribution of Wasserstein distances for each $N$ = 3, 4, 5 state model and each distribution shape (I, II, III or IV).
The summary statistics for each boxplot in Fig. 2H can be found in the file Percentiles_boxplots.xlsx, containing the 10th, 25th (lower quartile), 50th (median), 75th (upper quartile), and 90th percentiles of the WDs.
These summary statistics can also be found in Table III.
