[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4771039.svg)](https://doi.org/10.5281/zenodo.4771039)

Larsen et al. (2020) [https://doi.org/10.1111/ele.13731](https://doi.org/10.1111/ele.13731) wrote a technical comment re: Fric et al. (2020) [https://doi.org/10.1111/ele.13419](https://doi.org/10.1111/ele.13419). In Fric et al.’s response (2021) [https://doi.org/10.1111/ele.13739](https://doi.org/10.1111/ele.13739), the authors claim that Larsen et al. 2020 (LS) analyses contained an error. Specifically, they allege that LS swapped onset and termination phenology metrics. We evaluated three lines of evidence to evaluate this claim:


1) We worked through the code and documentation provided by LS and found no errors in analyses or figure generation. Code to do so is in the `1_LS_Reanalysis` subdirectory as `LarsenShirey_Reanalysis_Edited.R` (which has been lightly edited from the original [https://github.com/RiesLabGU/Larsen-Shirey2020_EcoLettersComment/blob/master/LarsenShirey_Reanalysis.Rmd](https://github.com/RiesLabGU/Larsen-Shirey2020_EcoLettersComment/blob/master/LarsenShirey_Reanalysis.Rmd) to convert to .R format and suppress extraneous analyses).

2) We compared the model response results of LS's reanalysis and Fric et al.'s analyses when pruned to the same 22-species list. Fric et al. 2021 did not include code to reproduce analysis, making a direct reproduction impossible; we extracted the model responses for those 22 species using the ~latitude|altitude+year model from the output MS Excel file included [https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2Fele.13739&file=ele13739-sup-0002-TableS2.xlsx](https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2Fele.13739&file=ele13739-sup-0002-TableS2.xlsx). The adapted Fric et al.'s model output looked more similar to LS's reanalysis than to one with transposed metrics, and appear to more closely support LS's conclusions than Fric et al.'s (2021) stated reanalysis. The code we generated for this step is in the `2_ModelResponseComparison` subdirectory. 

3) We independently generated species-specific linear models of the 22 focal species from LS using their released dataset `pheno.data`. Model coefficients look highly similar to LS's reanalysis. The code we generated for this step is in the `3_IndependentModelCoefficients` subdirectory. A pdf file containing code and results is in Shirey-Larsen_reanalysis.pdf [https://github.com/cjcampbell/ELE_Pheno2021/blob/master/Shirey-Larsen_reanalysis.pdf](https://github.com/cjcampbell/ELE_Pheno2021/blob/master/Shirey-Larsen_reanalysis.pdf). 

Overall, we find no evidence that LS made an error in their reanalysis and were unable to reproduce the relevant results of Fric et al. 2021.
