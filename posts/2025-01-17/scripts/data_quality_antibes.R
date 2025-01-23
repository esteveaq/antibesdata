library(tidyverse)
library(paletteer)

source("tools/themes.R") # themes

# IMPORT -----
df_antibes <- read_csv("posts/2025-01-17_metadonnees/data/results_antibes.csv")
df_cannes <- read_csv("posts/2025-01-17_metadonnees/data/results_cannes.csv")
df_nice <- read_csv("posts/2025-01-17_metadonnees/data/results_nice.csv")

# CLEANING -----
df <-
    tibble(
      antibes = mean(df_antibes$values),
      cannes = mean(df_cannes$values),
      nice = mean(df_nice$values)
    )

df <-
    pivot_longer(df, 
                 cols = everything(), 
                 names_to = "ville", 
                 values_to = "mean_quality")

# standardize cols names and variables
  df <-
  df %>%
    mutate(across(c(ville, mean_quality), str_to_title)) %>%
    mutate(mean_quality = as.numeric(mean_quality)) %>%
    mutate(ville = as_factor(ville))
  
# adding useful cols
  df <-
    df %>% 
    mutate(taux = scales::percent(mean_quality))

# PLOT -----

# col chart
plot_quality <-
 df %>%
    ggplot(aes(x = ville, y = mean_quality))+
      geom_col(aes(y = 1), alpha = 0.4) +
      geom_col(aes(fill = mean_quality)) +
      geom_text(aes(label = taux),
                    vjust = 2,
                     hjust = 0.4,
                    size = 8,
                    color = "black",
                    fontface = "bold",
                    family = setfont) + tt6
  
# labels and colors   
  plot_quality <-
  plot_quality +
    scale_y_discrete(expand = c(0, 0)) + # force origin at 0
    scale_fill_paletteer_c("ggthemes::Red-Green-Gold Diverging") +
    labs(
      title = "Antibes en tête dans la qualité des données",
      subtitle = "Qualité des metadonnées publiées sur opendata.gouv.fr. moyenne en (%) <br>Janvier 2025",
      caption = social_caption) 
  plot_quality
  
  