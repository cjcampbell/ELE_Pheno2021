library(tidyverse)

githubURL <- "https://github.com/RiesLabGU/Larsen-Shirey2020_EcoLettersComment/blob/master/data/phenometrics.RData?raw=TRUE"
load(url(githubURL))

#let's take a look at these data
head(pheno.data)
# note how onset is before term, so the phest estimates are correctly labeled

#### get Latitude coef for each spp

# first write a function to get the Lat model coef for each spp
onset_coef_fun <- function(spp_name){
  
  mdf <- filter(pheno.data, name == spp_name)
  spp_lm <- lm(onset~rndLat+year, data = mdf)
  
  out_df <- data.frame(
    name = spp_name,
    onset_coef = spp_lm$coefficients[['rndLat']],
    p_value = summary(spp_lm)$coefficients[,4][['rndLat']]
    )
  
  return(out_df)
}

offset_coef_fun <- function(spp_name){
  
  mdf <- filter(pheno.data, name == spp_name)
  spp_lm <- lm(term~rndLat+year, data = mdf)
  
  out_df <- data.frame(
    name = spp_name,
    offset_coef = spp_lm$coefficients[['rndLat']],
    p_value = summary(spp_lm)$coefficients[,4][['rndLat']]
  )
  
  return(out_df)
}


# get a list of the 22 spp
spp_list <- unique(pheno.data$name)

### get model coef for each spp

#Onset First
onset_coef_list <- lapply(spp_list, onset_coef_fun)
onset_coef_df <- bind_rows(onset_coef_list) %>% 
  mutate(slope = case_when(onset_coef > 0 & p_value < 0.05 ~ "positive",
                           onset_coef < 0 & p_value < 0.05 ~ "negative",
                           p_value >= 0.05 ~ "not-sig"))

onset_coef_sum <- onset_coef_df %>% 
  group_by(slope) %>% 
  summarise(slope_count = n()) %>% 
  mutate(phenometric = "Onset")


#Offset
offset_coef_list <- lapply(spp_list, offset_coef_fun)
offset_coef_df <- bind_rows(offset_coef_list) %>% 
  mutate(slope = case_when(offset_coef > 0 & p_value < 0.05 ~ "positive",
                           offset_coef < 0 & p_value < 0.05 ~ "negative",
                           p_value >= 0.05 ~ "not-sig"))

offset_coef_sum <- offset_coef_df %>% 
  group_by(slope) %>% 
  summarise(slope_count = n()) %>% 
  mutate(phenometric = "Termination")

# bind two datasets together
total_coef <- rbind(onset_coef_sum, offset_coef_sum)
total_coef$phenometric <- factor(total_coef$phenometric, levels = c("Onset", "Termination"))

ggplot() +
  geom_bar(total_coef, mapping = aes(x = phenometric, y = slope_count,
                                     fill = slope), stat = "identity") +
  scale_fill_manual(values = c("blue", "grey", "dark green"))