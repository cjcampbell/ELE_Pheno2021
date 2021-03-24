
# Load Fric et al reanalyses ---------------------------------------------
library(XLConnect)
library(tidyverse)
tmp = tempfile(fileext = ".xlsx")

download.file("https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2Fele.13739&file=ele13739-sup-0002-TableS2.xlsx",  destfile = tmp, mode="wb")

# Load the fourth ("bottom") set of rows, corresponding to the more-heavily filtered data used to compare to the LS letter:
fricData <- readWorksheetFromFile(file = tmp, sheet = "~latitude|altitude+year", header = TRUE, startRow = 346, endRow = 434)

# Rename columns to reflect peak, onset, and termination coefs.
names(fricData)[2:9] <- paste0(names(fricData)[2:9], "_peak")
names(fricData)[10:17] <- paste0(gsub(".1", "", names(fricData)[10:17]), "_onset")
names(fricData)[18:25] <- paste0(gsub(".2", "", names(fricData)[18:25]), "_term")

# Remove extraneous detail from name column:
fricData<- fricData %>% 
  dplyr::mutate(verbatimName = Name,
         Name = sub("^(\\S*\\s+\\S+).*", "\\1", Name)) %>% 
  dplyr::rename(name = Name)

saveRDS(fricData, file.path("data", "fricData.rds"))

# Briefly check out these data:
dat_fr %>% group_by(verbatimName_fr) %>% dplyr::summarise(n = n()) %>% arrange(desc(n))
## Four species evaluated separately in Eurasia / NoAm, apparently

# Run LS analyses ---------------------------------------------------------

## Code here contains slight file path modifications for convenience ##
library(knitr)
knitr::purl(file.path("~/Larsen-Shirey2020_EcoLettersComment", "LarsenShirey_Reanalysis.Rmd"), output = file.path("LS_Reanalysis", "LarsenShirey_Reanalysis.R"))

# Ran through that .R and saved output in the subdir.
# Also one file from Larsen-Shirey2020_EcoLettersComment/data (GitHub) into LS_Reanalysis/data subdirectory b/c I was having trouble reading it from GitHub.
