
# Goal: compare coefficients of each suite of models...

# Load LS model outputs:
dat_ls <- readRDS(file.path("~/ELE_Pheno2021","data", "LS_reanalysisData.rds"))
names(dat_ls)[-1] <- paste0(names(dat_ls)[-1], "_ls")

# Load Fric reanalyzed model outputs.
dat_fr <- readRDS("~/ELE_Pheno2021/data/fricData.rds")
names(dat_fr)[-1] <- paste0(names(dat_fr)[-1], "_fr")

mdf <- inner_join(dat_ls, dat_fr, by = "name")

mdf %>% filter(response_onset_fr == onset.response_ls)
mdf %>% filter(response_onset_fr == term.response_ls)

mdf %>% filter(response_term_fr == term.response_ls)
mdf %>% filter(response_term_fr == onset.response_ls)


mdf %>% dplyr::group_by(onset.response_ls) %>% dplyr::summarise(n = n())
mdf %>% dplyr::group_by(term.response_ls) %>% dplyr::summarise(n = n())

mdf %>% dplyr::group_by(response_onset_fr) %>% dplyr::summarise(n = n())
mdf %>% dplyr::group_by(response_term_fr) %>% dplyr::summarise(n = n())

mdf %>% select_at(vars(
  contains("onset")&contains("response"),contains("term")&contains("response"))) %>% 
  pivot_longer(cols = 1:4, names_to = c("par")) %>%
  dplyr::group_by(par, value) %>% dplyr::summarise(n = n()) %>% 
  dplyr::mutate(
    value = factor(value, levels = c(-1, 0, 1)),
    par = factor(par, levels = c("response_onset_fr", "onset.response_ls", "response_term_fr", "term.response_ls"))) %>% 
  ggplot() +
  aes(fill = factor(value), y = n, x = par) +
  geom_bar( position="stack", stat = "identity") +
  scale_fill_manual(breaks = c(-1, 0, 1), values = c("blue", "grey50", "forestgreen")) +
  theme_bw()

# Matches items from the """Figure 1""" exactly, not the """""reenalysis""""" column...
  

