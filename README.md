# Transient power-law behaviour in stochastic gene expression models

Data and code for the paper ['Transient power-law behaviour following induction distinguishes between competing models of stochastic gene expression'](https://www.biorxiv.org/content/10.1101/2023.12.30.573521v1).

Please direct any questions regarding the paper to the authors. For any questions regarding the code please raise an issue or contact Andrew.

The following table contains a description of the uploaded data and any relevant code used in the analysis and figures in the aforementioned paper, as well as a description of the data format.

| Name | Type | Description |
| ----------- | -------- | ----------- |
| Experimental data | Folder | Contains the experimental data from [[1]](https://www.nature.com/articles/s41597-019-0106-6) and [[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) that was used in the non-linear regression and estimation of power-law exponents for Fig. 5 and Table I. |
| Linear regression synthetic data | Folder | Contains the synthetic data generated for Fig. 4 to validate the use of short-time mean mRNA count measurements to estimate the power-law exponent. |
| Steady-state data | Folder | Contains the data from sampling the steady-state mRNA count distributions of various N = 3,4,5 state models and comparing with the corresponding effective telegraph model distribution, investigated in Fig. 2. |
| Powerlaw_calc.ipynb | Jupyter notebook (Julia) | Code for Fig. 3 - solving moment equations to investigate power-law behaviour. |
| nlnreg_expdata.mlx | MATLAB file | Code for performing the non-linear regression estimation of prefactor and exponent from experimental data in Fig. 5. |
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

## References

[[1]](https://www.nature.com/articles/s41597-019-0106-6) Li, G., Neuert, G. Multiplex RNA single molecule FISH of inducible mRNAs in single yeast cells. Sci Data 6, 94 (2019). https://doi.org/10.1038/s41597-019-0106-6

[[2]](https://www.pnas.org/doi/10.1073/pnas.1309990110) S. Hao and D. Baltimore, RNA splicing regulates the temporal order of TNF-induced gene expression, Proceedings of the National Academy of Sciences 110, 11934 (2013). https://doi.org/10.1073/pnas.1309990110
