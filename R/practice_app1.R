# load packages
library(palmerpenguins)
library(tidyverse)

# filter data ----
body_mass_df <- penguins |>
  filter(body_mass_g %in% 3000:4000)

# plot
ggplot(na.omit(body_mass_df),
       aes(x = flipper_length_mm, y = bill_length_mm,
           color = species, shape = species)) +
  geom_point() +
  scale_color_manual(values = c("Adelie" = "#FEA346",
                                "Chinstrap" = "#B251F1",
                                "Gentoo" = "4BA4A4")) +
  scale_shape_manual(values = c("Adelie" = 19,
                                "Chinstrap" = 17,
                                "Gentoo" = 15))

# filter for a yearly dataframe
yearly_df <- penguins |>
  filter(year %in% 2008)
