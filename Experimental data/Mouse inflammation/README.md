# Experimental data - Mouse inflammation

Data taken from Fig. S2 of [1]. The mRNA count measurements and times were extracted using Webplotdigitzer [2] and are saved in the CSV files: `Data_letter_group_gene_JX_RNA.csv`. These filenames can be interpreted in the following way:
- 'letter' refers to which panel of Fig. S2 the curve is taken from, i.e. 'A' means from Fig. S2A. Curves from Fig. S2A are from mouse fibroblast cells, and curves from Fig. S2B-C are from mouse bone-marrow-derived macrophage cells.
- 'group' refers to the "three waves of mRNA appearance", as explained in [1]. Group 1 ('g1') mRNAs are "early production", group 2 ('g2') mRNAs are "slower production", and group 3 ('g3') mRNAs are very slow production.
- 'gene' is self-explanatory - the data for the gene of this name.
- 'JX' refers to the intron junction that was used to detect the pre- and mRNA.
- 'RNA' refers to the RNA species, i.e. either 'premRNA' for unspliced mRNA, or 'mRNA' for spliced mRNA.

The file `Mouse_results_summary.xlsx` contains a summary of the results from fitting to three mouse data curves. This includes the mRNA curves and times; the number of data points considered; the optimal number of data points and corresponding RSS value; estimates of the prefactor, exponent, delay, and constant mRNA count; and estimates of the standard error in these parameters. This information is also summarised in Supplementary Table 7.

## References

[[1]](https://www.pnas.org/doi/10.1073/pnas.1309990110) S. Hao and D. Baltimore, RNA splicing regulates the temporal order of TNF-induced gene expression, Proceedings of the National Academy of Sciences 110, 11934 (2013). https://doi.org/10.1073/pnas.1309990110

[[2]](https://automeris.io/WebPlotDigitizer/) A. Rohatgi, Webplotdigitizer: Version 4.6 (2022).