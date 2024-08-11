# Transient power-law behaviour in stochastic gene expression models

Data and code for the paper ['Transient power-law behaviour following induction distinguishes between competing models of stochastic gene expression'](https://www.biorxiv.org/content/10.1101/2023.12.30.573521v1).

Please direct any questions regarding the paper to the authors. For any questions regarding the code please raise an issue or contact Andrew.

![Illustration of the power law result for the short-time behaviour of the mean mRNA count following gene induction.](./Repo%20Images/PowerLaw_example.png "Transient power-law behaviour in stochastic gene expression")

![An example of the steady-state mRNA count distribution of both a 5-state model and its effective telegraph model.](./Repo%20Images/5statemodel_example.png "Steady-state mRNA count distribution")

The following table contains a description of the uploaded data and any relevant code used in the analysis and figures in the aforementioned paper, as well as a description of the data format.

| Name | Type | Description |
| ----------- | -------- | ----------- |
| Experimental data | Folder | Contains the experimental data from [[1]](https://www.nature.com/articles/s41597-019-0106-6) and [[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) that was used in the nonlinear regression and estimation of short-time exponents for Fig. 5, Fig. S11, and Fig. S13. |
| Synthetic Data for Regression | Folder | Contains the synthetic data generated for Fig. 4 and Figs. S2-S9 to validate the estimation of the short-time exponent from mean mRNA count measurements. |
| Steady-state data | Folder | Contains the data from sampling the steady-state mRNA count distributions of various N = 3,4,5 state models and comparing with the corresponding effective telegraph model distribution, investigated in Fig. 2, Fig. S1, and Fig. S14. |
| Powerlaw_calc.ipynb | Jupyter notebook (Julia) | Code for Fig. 3 - solving moment equations to investigate power-law behaviour in the mRNA count statistics. |
| Example_DataRegression | Jupyter notebook (Julia) | Code for performing the non-linear regression and estimation of model parameters applied to the yeast data in Figs. 5 and S11 and the mouse data in Fig. S13. |
| mRNA_dist_FSP.ipynb | Jupyter notebook (Julia) | Code for Fig. 2 - solving the chemical master equation for the steady-state mRNA count distribution of the 5-state model and effective telegraph model and subsequent calculation of the Wasserstein distance. |

## Package dependencies
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

## References

[[1]](https://www.nature.com/articles/s41597-019-0106-6) Li, G., Neuert, G. Multiplex RNA single molecule FISH of inducible mRNAs in single yeast cells. Sci Data 6, 94 (2019). https://doi.org/10.1038/s41597-019-0106-6

[[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) S. Hao and D. Baltimore, RNA splicing regulates the temporal order of TNF-induced gene expression, Proceedings of the National Academy of Sciences 110, 11934 (2013). https://doi.org/10.1073/pnas.1309990110
