# Transient power-law behaviour in stochastic gene expression models

[![DOI](https://zenodo.org/badge/734792222.svg)](https://doi.org/10.5281/zenodo.14245773)

Data and code for the paper ['Transient power-law behaviour following induction distinguishes between competing models of stochastic gene expression'](https://www.nature.com/articles/s41467-025-58127-4), now published in *Nature Communications*.
Preprint available [here](https://www.biorxiv.org/content/10.1101/2023.12.30.573521v2).

Please direct any questions regarding the paper to the authors. For any questions regarding the code please raise an issue or contact Andrew.

![Illustration of the power law result for the short-time behaviour of the mean mRNA count following gene induction.](./Repo%20Images/PowerLaw_example.png "Transient power-law behaviour in stochastic gene expression")

![An example of the steady-state mRNA count distribution of both a 5-state model and its effective telegraph model.](./Repo%20Images/5statemodel_example.png "Steady-state mRNA count distribution")

The following table contains a description of the uploaded data and relevant code used in the analysis and figures in the paper, as well as a description of the data format.

| Name | Type | Description |
| ----------- | -------- | ----------- |
| Experimental data | Folder | Contains the experimental data from [[1]](https://www.nature.com/articles/s41597-019-0106-6) and [[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) that was used in the nonlinear regression and estimation of short-time exponents for Fig. 5, Supplementary Fig. 14, and Supplementary Fig. 16. |
| Synthetic Data for Regression | Folder | Contains the synthetic data generated for Fig. 4 and Supplementary Figs. 3-12 to validate the estimation of the short-time exponent from mean mRNA count measurements. |
| Steady-state data | Folder | Contains the data from sampling the steady-state mRNA count distributions of various $N$ = 3,4,5 state models and comparing with the corresponding effective telegraph model distribution, investigated in Fig. 2, and Supplementary Figs. 1-2. |
| `Powerlaw_calc.ipynb` | Jupyter notebook (Julia) | Code for Fig. 3 - solving moment equations to investigate power-law behaviour in the mRNA count statistics. |
| `Example_DataRegression.ipynb` | Jupyter notebook (Julia) | Code for performing the non-linear regression and estimation of model parameters applied to the yeast data in Fig. 5 and Supplementary Fig. 14 and the mouse data in Supplementary Fig. 16. |
| `mRNA_dist_FSP.ipynb` | Jupyter notebook (Julia) | Code for Fig. 2 - solving the chemical master equation for the steady-state mRNA count distribution of the 5-state model and effective telegraph model and subsequent calculation of the Wasserstein distance. |

## Package dependencies
All Julia calculations were performed in v1.8.5.
To execute the code included here the following Julia packages are required:
- [Catalyst.jl](https://github.com/SciML/Catalyst.jl)
- [FiniteStateProjection.jl](https://github.com/SciML/FiniteStateProjection.jl)
- [MomentClosure.jl](https://github.com/augustinas1/MomentClosure.jl)
- [DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl)
- [Sundials.jl](https://github.com/SciML/Sundials.jl)
- [LinearAlgebra.jl](https://github.com/JuliaLang/LinearAlgebra.jl)
- [Plots.jl](https://github.com/JuliaPlots/Plots.jl)
- [Latexify.jl](https://github.com/korsbo/Latexify.jl/tree/master)
- [Colors.jl](https://github.com/JuliaGraphics/Colors.jl)
- [CairoMakie.jl](https://docs.makie.org)
- [LsqFit.jl](https://julianlsolvers.github.io/LsqFit.jl/latest/)
- [GLM.jl](https://juliastats.org/GLM.jl)
- [BlackBoxOptim.jl](https://github.com/robertfeldt/BlackBoxOptim.jl)
- [SpecialFunctions.jl](https://specialfunctions.juliamath.org)
- [StatsBase.jl](https://juliastats.org/StatsBase.jl)
- [DataFrames.jl](https://dataframes.juliadata.org)
- [CSV.jl](https://csv.juliadata.org)
- [XLSX.jl](https://felipenoris.github.io/XLSX.jl)

## Citation

Our paper can be cited in the following way:

Nicoll, A. G., Szavits-Nossan, J., Evans, M. R., & Grima, R. (2025). Transient power-law behaviour following induction distinguishes between competing models of stochastic gene expression. Nature Communications, 16(1), 2833. [doi:10.1038/s41467-025-58127-4](https://www.nature.com/articles/s41467-025-58127-4)

```
@article{nicoll_transient_2025,
	title = {Transient power-law behaviour following induction distinguishes between competing models of stochastic gene expression},
	volume = {16},
	copyright = {2025 The Author(s)},
	issn = {2041-1723},
	url = {https://www.nature.com/articles/s41467-025-58127-4},
	doi = {10.1038/s41467-025-58127-4},
	language = {en},
	number = {1},
	urldate = {2025-03-24},
	journal = {Nature Communications},
	author = {Nicoll, Andrew G. and Szavits-Nossan, Juraj and Evans, Martin R. and Grima, Ramon},
	month = mar,
	year = {2025},
	note = {Publisher: Nature Publishing Group},
	keywords = {Bioinformatics, Computational models, Transcription},
	pages = {2833},
}
```

This repository can be cited in the following way:

Andrew Nicoll. (2024). agnflame/PowerLaw: Pre-release (v0.1.0). Zenodo. [https://doi.org/10.5281/zenodo.14245774](https://doi.org/10.5281/zenodo.14245774)

```
@misc{nicoll_agnflamepowerlaw_2024,
	title = {agnflame/{PowerLaw}: {Pre}-release},
	url = {https://doi.org/10.5281/zenodo.14245774},
	publisher = {Zenodo},
	author = {Nicoll, Andrew},
	month = nov,
	year = {2024},
	doi = {10.5281/zenodo.14245774},
}
```

## References

[[1]](https://www.nature.com/articles/s41597-019-0106-6) Li, G., Neuert, G. Multiplex RNA single molecule FISH of inducible mRNAs in single yeast cells. Sci Data 6, 94 (2019). https://doi.org/10.1038/s41597-019-0106-6

[[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) S. Hao and D. Baltimore, RNA splicing regulates the temporal order of TNF-induced gene expression, Proceedings of the National Academy of Sciences 110, 11934 (2013). https://doi.org/10.1073/pnas.1309990110
