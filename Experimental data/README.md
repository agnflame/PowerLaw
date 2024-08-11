# Estimation of the short-time exponent of the mean mRNA count using experimental data

This folder contains the data and results from estimating the short-time exponent of the mean mRNA count from two experimental data sets.
Also contained is a Jupyter Notebook written in Julia which illustrates this application on some of the data used in this paper.
We defined the power law model with delay before transcription initiation and used the BlackBoxOptim.jl package to minimise the residual sum of squares (RSS) to find the optimal parameter set.
This notebook also details the calculations of local uncertainties in the model parameters used on bulk mRNA count data.

For both data sets, in each data file, are the times and counts used in the non-linear regression (optimisation), as well as the results of the regression analysis.
This includes the estimates of the: prefactor, exponent, delay, constant mRNA count during the delay, standard errors in these estimates, $R^2$, and RSS.

## Yeast osmotic stress data

The first data set is from [[1]](https://www.nature.com/articles/s41597-019-0106-6) and contains measurements of the nuclear and cytoplasmic mRNA counts of two genes, CTT1 and STL1, which are involved in osmotic stress response pathways in the yeast species, *S. cerevisiae*.

The raw data, as given in [1], consists of single-cell measurements of the nuclear, cytoplasmic, and total (nuclear + cytoplasmic) mRNA counts measured using smFISH (single molecule fluorescence in situ hybridization) at various time points following application of two osmotic stress stimuli - 0.2 mol NaCl (denoted as Exp 1) and 0.4 mol NaCl (denoted as Exp 2).
The number of cells measured varies per time point, of which there are 16 total time points.
For each experimental condition (1 & 2) there are several experimental replicas - two replicas for Exp 1 and three replicas for Exp 2.
The mean mRNA counts were obtained by combining all experimental replicas and averaging the mRNA counts across all cells, for each experimental condition and time point.
This resulted in a mean mRNA curve (in time) for each experimental condition, each gene, and each RNA species (nuclear, cytoplasmic, and total), resulting in 12 curves in total, of which eight were used in Fig. 5.
Through bootstrapping the single-cell data, multiple resampled mean mRNA count curves can be obtained to compute the sampling distribution for the estimated parameters to investigate their uncertainty.

The file "Code_Figs_5_S11.ipynb" is a Jupyter notebook written in Julia and can be ran to reproduce Figs. 5 & S11 showing the results of fitting the nonlinear regression model to the yeast data.

## Mouse inflammation data

The second data set is from [[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) and contains measurements of the pre-mRNA (unspliced) and mRNA (spliced) counts of several inducible genes involved in inflammatory response pathways in mice fibroblasts and bone marrow derived macrophages, measured using qPCR.
To extract these measurements the tool WebPlotDigitizer [[3]](https://automeris.io/WebPlotDigitizer/) was used on Fig. S2.
The analysis was performed directly on these extracted measurements.

## References

[[1]](https://www.nature.com/articles/s41597-019-0106-6) Li, G., Neuert, G. Multiplex RNA single molecule FISH of inducible mRNAs in single yeast cells. Sci Data 6, 94 (2019). https://doi.org/10.1038/s41597-019-0106-6

[[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) S. Hao and D. Baltimore, RNA splicing regulates the temporal order of TNF-induced gene expression, Proceedings of the National Academy of Sciences 110, 11934 (2013). https://doi.org/10.1073/pnas.1309990110

[[3]](https://automeris.io/WebPlotDigitizer/) A. Rohatgi, Webplotdigitizer: Version 4.6 (2022).
