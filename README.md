# ELE_Pheno2021

We evaluated three lines of evidence that LS's analyses contained an error, swapping onset and termination phenology metrics.

1) We evaluated the code documentation provided by LS and found no errors in analyses or figure generation. Code to do so is in `LS_Reanalysis/LarsenShirey_Reanalysis_Edited.R`
2) We compared the model response results of LS's reanalysis and Fric et al.'s analyses when pruned to the same 22-species list. The adapted Fric et al.'s model output looked more similar to LS's reanalysis than to one with transposed metrics, and appear to more closely support LS's conclusions than Fric et al.'s stated reenalysis. The code we generated for this step is in the `R` subdirectory.
3) We conducted new species-specific linear models of the 22 focal species from LS using the dataset `pheno.data`. Model coefficients look highly similar to LS's reanalysis. The code we generated for this step is in the `scripts` subdirectory.
