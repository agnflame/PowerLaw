# Experimental data - Yeast osmotic stress

Data taken from [1]. For details of data processing see SI Note 5.4.

The folder "Raw Data" contains CSV files with the raw data, the mRNA counts in each cell at each time point for each experimental replica, condition, and gene. These data files take the format "Result_ExpX_repY_RNA_marker_compartment.csv". These filenames can be interpreted in the following way:
- 'ExpX' refers to the two experimental conditions (strengths of osmotic stress). 'Exp1' is 0.2 mol NaCl and 'Exp2' is 0.4 mol NaCl.
- 'repY' refers to each experimental replica (1, 2 or 3).
- 'marker' refers to the name of the smFISH marker used to tag each gene. The 'CY5' tag refers to the gene CTT1 and the 'TMR' tag refers to the gene STL1.
- 'compartment' refers to the cellular compartment the mRNA was observed in, i.e. nuclear, cytoplasmic, or total (nuclear + cytoplasmic).
So for example the file "Result_Exp1_rep1_RNA_TMR_nuclear.csv" refers to replica 1 of STL1 nuclear mRNA measurements under 0.2 mol NaCl induced osmotic stress.

The folder "Single cell data" contains the mRNA counts in each cell at each time point after combining all experimental replicas.

The folder "Bootstrapped means" contains various mean mRNA curves computed from bootstrapping the original single-cell yeast data which were used to compute the sampling distributions of each estimated parameter.

The folder "Sampling distributions" contains the results of fitting the power-law model to each mean mRNA curve from bootstrapping the single-cell yeast data. The files in this folder contain the nuclear and cytoplasmic mean mRNA counts and times, the RSS values, estimates of each parameter, and the R-squared values for each of the 10,000 bootstrapped curves. The sampling distributions of each parameter contained here can be found in Fig. 5 and Fig. S11.

The file "Yeast_results_summary.xlsx" contains a summary of the results from fitting to the yeast induction curves. This includes the nuclear and cytoplasmic mRNA curves and times; the number of data points considered; the optimal number of data points and corresponding RSS value; estimates of the (mean and median of the) prefactor, exponent, delay, and constant mean mRNA count from bootstrapping.

## References

[[1]](https://www.nature.com/articles/s41597-019-0106-6) Li, G., Neuert, G. Multiplex RNA single molecule FISH of inducible mRNAs in single yeast cells. Sci Data 6, 94 (2019). https://doi.org/10.1038/s41597-019-0106-6
