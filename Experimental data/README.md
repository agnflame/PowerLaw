# Experimental data demonstrating application of power law result

This folder contains the data used to demonstrate the application of the power law result through using non-linear regression techniques to estimate the exponent of the power law which closely fits the mRNA induction curves measured in various experiments.
Also contained is a MATLAB live editor notebook which illustrates this application on three experimental mRNA induction curves.

For both data sets, in each data file, highlighted in red, are the times and counts used in the non-linear regression, as well as the results of the regression analysis.
This includes the estimates of the: prefactor, exponent, standard errors in these estimates, test statistic, p-value, $R^2$, and root mean-square error.
Additionally for each data set there is an Excel file containing the difference in the estimated exponents and their standard errors, for the applicable induction curves.

### Yeast osmotic stress data

The first data set is from [[1]](https://www.nature.com/articles/s41597-019-0106-6) and contains measurements of the nuclear and cytoplasmic mRNA counts of two genes, CTT1 and STL1, which are involved in osmotic stress response pathways in the yeast species, *S. cerevisiae*.

The raw data, as given in [1], consists of single-cell measurements of the nuclear, cytoplasmic, and total (nuclear + cytoplasmic) mRNA counts measured using smFISH (single molecule fluorescence in situ hybridization) at various time points following application of two osmotic stress stimuli - 0.2 mol NaCl (denoted as Exp 1) and 0.4 mol NaCl (denoted as Exp 2).
The number of cells measured varies per time point, of which there are 16 total time points.
For each experimental condition (1 & 2) there are several repetitions - two repetitions for Exp 1 and three repetitions for Exp 2.
The mean mRNA counts were obtained by averaging the mRNA counts across all cells and all repetitions by the number of cells, per experimental condition and per time point.
This resulted in a mean mRNA curve (in time) for each experimental condition, each gene, and each RNA species (nuclear, cytoplasmic, and total), resulting in 12 curves in total, of which eight were used in Fig. 5.

The individual (per repetition) and combined mean mRNA count and number of cells is reported in each Excel file.
These files take the format: Regression_expi_marker_species - where expi refers to Exp 1 or 2; marker refers to the fluorescent markers used to tag the RNAs of the two genes; and species referes to the RNA species (nuclear, cytoplasmic, total).
CY5 and TMR refer to the fluorescent markers used to tag the CTT1 and STL1 RNAs respectively.

### Mouse inflammation data

The second data set is from [[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) and contains measurements of the pre-mRNA (unspliced) and mRNA (spliced) counts of various inducible genes involved in inflammatory response pathways in mice fibroblasts and bone marrow derived macrophages, measured using qPCR.
To extract these measurements the tool WebPlotDigitizer [[3]](https://automeris.io/WebPlotDigitizer/) was used.
The regression analysis was performed directly on these extracted measurements.

## References

[[1]](https://www.nature.com/articles/s41597-019-0106-6) Li, G., Neuert, G. Multiplex RNA single molecule FISH of inducible mRNAs in single yeast cells. Sci Data 6, 94 (2019). https://doi.org/10.1038/s41597-019-0106-6

[[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) S. Hao and D. Baltimore, RNA splicing regulates the temporal order of TNF-induced gene expression, Proceedings of the National Academy of Sciences 110, 11934 (2013). https://doi.org/10.1073/pnas.1309990110

[[3]](https://automeris.io/WebPlotDigitizer/) A. Rohatgi, Webplotdigitizer: Version 4.6 (2022).