
# Load Fric et al reanalyses ---------------------------------------------
library(XLConnect)
tmp = tempfile(fileext = ".xlsx")
download.file("https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2Fele.13739&file=ele13739-sup-0002-TableS2.xlsx",  destfile = tmp, mode="wb")

# Load the fourth ("bottom") set of rows, corresponding to the more-heavily filtered data used to compare to the LS letter:
fricData <- readWorksheetFromFile(file = tmp, sheet = "~latitude|altitude+year", header = TRUE, startRow = 346, endRow = 434)

names(fricData) <- gsub(".1", "_peak", gsub(".2", "_onset", gsub(".3", "_term", names(mdf)) ))

write.csv(file.path("Fric_data", "fricData.csv"))

# Run LS analyses ---------------------------------------------------------

## Code here contains slight file path modifications for convenience ##
library(knitr)
knitr::purl(file.path("~/Larsen-Shirey2020_EcoLettersComment", "LarsenShirey_Reanalysis.Rmd"), output = file.path("LS_Reanalysis", "LarsenShirey_Reanalysis.R"))

# Ran through that .R and saved output in the subdir.
# Also one file from Larsen-Shirey2020_EcoLettersComment/data (GitHub) into LS_Reanalysis/data subdirectory b/c I was having trouble reading it from GitHub.
