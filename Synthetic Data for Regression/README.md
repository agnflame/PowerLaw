# Regression using synthetic data to estimate short-time exponent

The mean mRNA count following induction was sampled from the chemical master equation (CME) mean at 5 different time points for various parameter sets across the parameter space - representing the mRNA dynamics from potential gene expression systems that are measured in experiments. Both linear (log[mean mRNA count] - log[time]) and nonlinear regression were performed on the sampled induction curves to estimate the short-time exponent of the mean mRNA count. This procedure was used in Fig. 4.

In the case of a finite number of cells, the mean was computed across trajectories sampled using the stochastic simulation algorithm (SSA). To investigate finite sample size effects the sample size was varied over 50, 100, 500, 1000, and 10000. This procedure was used in Supplementary Figs. 3-6.

To investigate the effects of mRNA capture efficiency (important when considering experimental viability) on the short-time exponent we introduce a new parameter - the mRNA capture probability. The same procedure as done for Supplementary Figs. 3-6 was repeated with a fixed finite sample size of 1000, and the mRNA capture probability was varied over 0.2, 0.4, 0.6, 0.8, and 1.0, represeting various degrees of mRNA capture success from different experimental techniques (i.e. scRNAseq, bulk RNAseq, smFISH, etc.).

To investigate the effect of an initial mixed gene state distribution (rather than a Dirac delta distribution in a single gene state) on the estimation of the short-time exponent, different initial conditions were considered, including a uniform distribution and various random initial distributions.

## Fig. 4 Data structure

Format of data filenames:

$N$ = Total number of states, see description and structure of $N$-state model.
A model with $N$ states has $N-1$ inactive states and 1 active state.

$j$ = Initial state. e.g. if $j=2$, then state $G_2$ is the initial condition for all cells.

5 data points were used in each regression, representing an experiment where the mean from a population of cells was sampled at 5 different times as gene activation progressed.

For example:

The file `SyntheticData_N5_j3.xlsx` corresponds to:
- $N$ = 5, 5-state model, 4 inactive states with 4 activation steps until the 5th (single) active state.
- $j$ = 3, perturbation affected rate $k_3$ meaning the activation of transcription was halted at this reaction, thus the initial condition was mean mRNA count = 0 AND $P(G_3)$ = 1.

Each file contains the model parameters, the final mean mRNA count, estimates of the intercept/prefactor and slope/exponent, test statistics, p-values, and $R^2$ for each parameter set sampled.

## Supplementary Figs. 3-6 Data structure

The filenames take a similar format to that described above, but with some additional details:
- 'meanX' refers to the mean expression level at the final time point. So "mean25" indicates that the mean mRNA count at the final sample was approximately 25.
- 'psY' means "parameter set Y" where Y ranges from 1 to 5 (representing 5 different parameter sets for a given mean expression level at the final time point).

Each file contains the single parameter set used to simulate the SSA trajectories, the mean mRNA count at the final sample, the value of $t_on$ (representing the time of the final sample), the infinte sample size estimates of the short-time exponent obtained from the CME, and 5000 estimates of the short-time exponent (from both linear and nonlinear regression) for each sample size and the $R^2$ values.

## Supplementary Figs. 7-10 Data structure

The filenames take the same format to that described above for Supplementary Figs. 3-6.

Each file contains the single parameter set used to simulate the SSA trajectories, the mean mRNA count at the final sample, the value of $t_on$ (representing the time of the final sample), the infinte sample size estimates of the short-time exponent obtained from the CME, and 5000 estimates of the short-time exponent (from both linear and nonlinear regression) for each mRNA capture probability and the $R^2$ values.

## Supplementary Figs. 3-10 Parameter sets

The file `ParameterSets_FiniteSampSize.xlsx` contains a summary of the parameter sets chosen for Supplementary Figs. 3-10.

## Supplementary Figs. 11-12 Data structure

The file `SyntheticData_G1G3_MixedInitialConditions.csv` contains the initial conditions, synthetic data, and regression results used in Supplementary Fig. 11.

The file `SyntheticData_ParameterSweep_MixedInitialConditions.csv` contains the parameter sets, initial conditions, synthetic data, and regression results used in Supplementary Fig. 12.

## Code to reproduce figures

The file `Code_Fig4.ipynb` is a Jupyter notebook written in Julia and contains the necessary code to reproduce the example regression and distributions in Fig. 4, though without the model diagrams illustrated.

The file `Code_SuppFigs_3_to_6.R` is an R script and contains the necessary code to reproduce the boxplots shown in Supplementary Figs. 3-6.

The file `Code_SuppFigs_7_to_10.R` is an R script and contains the necessary code to reproduce the boxplots shown in Supplementary Figs. 7-10.

The file `Code_SuppFigs_11_to_12.ipynb` is a Jupyter notebook written in Julia and contains the necessary code to reproduce the plots in Supplementary Figs. 11-12.

## Package dependencies

To reproduce the Supplementary Figs. 3-10, the installation of the following R libraries is required:
- [ggplot2](https://ggplot2.tidyverse.org/)
- [readxl](https://readxl.tidyverse.org/)
- [HDInterval](https://cran.r-project.org/package=HDInterval)
- [cowplot](https://wilkelab.org/cowplot/index.html)