library(tidyverse)
library(lubridate)

# Data on kahdessa tiedostossa
saraketyypit <- cols(
  sijainti = col_character(),
  pistetunnus = col_integer(),
  pvm = col_character(),
  Kaikki = col_integer(),
  suunta = col_skip(),
  suuntaselite = col_skip(),
  kaista = col_skip()
)
lm_2019 <- read_delim("liikennemaarat/liikennemaara_vrk_2019-01-01-2019-12-31.csv",
                      delim = ";", col_types = saraketyypit)
lm_rest <- read_delim("liikennemaarat/liikennemaara_vrk_2020-01-01-2022-06-24.csv",
                      delim = ";", col_types = saraketyypit)
liikenne <- rbind(lm_2019, lm_rest)
rm(lm_2019, lm_rest)

# Muunnetaan pvm string päivämääräksi ja pilkotaan
liikenne_per_paiva <-
  liikenne %>% 
  mutate(
    pvm = ymd(pvm),
    vuosi = year(pvm),
    viikko = week(pvm),
    vuodenpaiva = yday(pvm)
  )

liikenne_per_viikko <-
  liikenne_per_paiva %>%
  group_by(vuosi, viikko) %>%
  summarise(summa = sum(Kaikki))

ggplot(data = liikenne_per_viikko) +
  geom_line(mapping = aes(x = viikko, y = summa, group = vuosi, colour = vuosi))
