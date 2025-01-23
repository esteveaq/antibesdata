library(tidyverse)
library(readxl)
library(treemapify)
library(grid)
source("scripts/themes.R")

#IMPORT -----
jardins <- read_csv("data/antibes-jardins-partages.csv")
glimpse(jardins)

# CLEANING -----
jardins$site[jardins$site == 'Saint Maymes'] <- c("Saint Maymes 1", "Saint Maymes 2") # give a number to each duplicate value


# ANALYSIS -----
jardins_tree <-
jardins %>% 
  summarize(site, surface_m2) 

# PLOT -----
plot_jardin_tree <- 
jardins_tree %>%
  ggplot(aes(fill = site, area = surface_m2, label = paste0(site,sep = "\n", surface_m2, " m²"))) +
  geom_treemap(color = "#FAE5C6", size = 5,  alpha = 1) +
  geom_treemap_text(fontface = "bold", 
                    colour = "white", 
                    place = "center",
                    family = setfont,
                    grow = FALSE) + 
  scale_fill_manual(values = custom_palette_treemap) +
  theme(legend.position = "none")

plot_jardin_tree <-
plot_jardin_tree +
  labs(title = "Les jardins partagés à Antibes Juan-les-Pins",
       subtitle = "Surface des jardins partagés en m2",
       caption = social_caption2) + tt5

# OUTPUT -----

plot_jardin_tree


