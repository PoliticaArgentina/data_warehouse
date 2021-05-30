# FIX 2003 PRESIDENT DATA

library(tidyverse)


fix_2003_presidential_data <- read_csv("data/00.PRESIDENCIAL/presi_gral2003.csv") %>% make_long() %>%
  filter(!is.na(votos)) %>%
  mutate(listas = case_when(
    listas == "0020" ~ "0133", # RECODE LISTS WITH SAME CANDIDATE
    listas == "0023" ~"0137",
    listas == "0052" ~"0132",
    T ~listas
  )) %>% group_by(codprov, depto, coddepto, circuito, mesa, electores, listas) %>%
  summarise_at(vars(votos), funs(sum)) %>%
  pivot_wider(id_cols = c(codprov, depto, coddepto, circuito, mesa, electores),
                     names_from = listas, values_from = votos) %>%
  ungroup() %>%
  mutate_if(is.numeric, funs(ifelse(is.na(.), 0, .)))



write_csv(fix_2003_presidential_data, "data/00.PRESIDENCIAL/presi_gral2003.csv")
