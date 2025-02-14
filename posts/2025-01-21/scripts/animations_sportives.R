library(tidyverse)
library(readxl)
library(skimr)
library(plotly)
library(gghighlight)
library(patchwork)
source("scripts/themes.R") # themes

# IMPORT -----
      source <- read_csv("data/antibes-animations-sportives.csv")
      animations <- source

# INSPECT -----
      head(animations)
      unique(animations$ORGANISATEUR)
      colnames(animations)
      glimpse(animations)
      max(animations$`DATE FIN`)

# CLEANING -----

    # standardize cols names and variables in chr type
    animations <-
        animations %>% 
          rename_with(tolower) %>%
          rename_with(~ str_squish(.)) %>%
          rename_with(~ str_replace_all(., " ", "_")) %>%
          mutate(across(where(is.character), ~ str_squish(str_to_lower(.)))) %>%
          mutate(across(c(date_debut, date_fin), as.Date))
      
    # drop NA
    animations <-
      animations %>% 
      drop_na(date_debut, date_fin, organisateur) 
    
    skim(animations) # check no NAs remaining  
      
      
    # remove unwanted cols
    animations <-
        animations %>%      
          select(animations, date_debut, date_fin, organisateur, lieu_1)

    # adding useful cols
    animations <-
       animations %>% mutate(yd = year(date_debut),
               md = month(date_debut),
               dd = day(date_debut),
               yf = year(date_fin),
               mf = month(date_fin),
               df = day(date_fin),
               yearmonth = paste0(yd,"-", md)
               ) %>% arrange(yd, md, dd) %>%
        mutate(duration = (date_fin - date_debut)
      )

# EXTERNAL CLEANING USING OPEN REFINE -----
    
    # save file for Open refine
    write_csv(animations, "data/animations.csv")
    
    # Load open refined data
    animations <- read_csv("data/animations_openrefined.csv")
   
    # additional cleaning step 
    animations <- animations %>%
      mutate(organisateur = case_when(
        organisateur %in% c("asf boules", "as fontonne boule") ~ "as fontonne boules",
        TRUE ~ organisateur
      ))
    
    #filter year
    animations <- animations %>% filter(yd > 2019) 
    
    # Title case variables 
    animations <-
      animations %>%
      mutate(across(c(lieu_1, organisateur), str_to_title))

# ANALYSIS -----
    
    # Faceting : top organizers, locations, activities
    orgs <-
      animations %>% 
      count(organisateur) %>% arrange(-n)
    orgs
    
    lieux <-
      animations %>% 
      count(lieu_1) %>% arrange(-n)
    lieux
    
    activities <-
      animations %>% 
      count(animations) %>% arrange(-n)
    activities
    
    # Filter top 10 organisateurs
    top_orgs <- orgs %>% 
      slice_max(order_by = n, n = 10)
    
    # Filter top 10 lieux
    top_lieux <- lieux %>% 
      slice_max(order_by = n, n = 10)
    
    
    # Count
    count.animations.year <-
    animations %>%
    count(yd)  
    
    count.animations.yearmonth <-
    animations %>%
      count(yearmonth)

    # Averages
    mean(animations$duration) # mean duration
    skim(animations$duration) # other stats

# PLOT -----
  
  # Color 
    c_highlight <-"#1D6FA1"
    
  ## Col chart per month  
    
  df_plot.year.facet <-
    animations %>%
    group_by(yd, md, organisateur) %>%
    count() %>%
    mutate(yd = factor(yd, levels = c("2023", "2022", "2021", "2020")))  
  
  plot.year.facet <-
    df_plot.year.facet %>%
    ggplot(aes(x = md, y = n)) +
    geom_col(fill = c_highlight, alpha = 0.6) +
    geom_col(data = df_plot.year.facet %>% filter(yd == 2023), fill = c_highlight, alpha = 1) +
    geom_text( # axis labels
      data = data.frame(x = 12.9, y = seq(0, 40, by = 10)),
      aes(x, y, label = y),
      color = "black",
      family = setfont,
      hjust = 1, 
      vjust = -0.5, 
      size = 3.5
    ) +
    geom_text(data = count.animations.year %>% filter(yd == 2023),
              aes(x = 2, y = 34, label = paste0(n, " activités en 2023")),
              family = setfont,
              hjust = 0.3,
              fontface = "bold",
              color = c_highlight,
              size = 6) +
    geom_text(data = count.animations.year %>% filter(yd < 2023),
              aes(x = 2, y = 34, label = paste0(n, " activités")),
              family = setfont,
              color = c_highlight,
              hjust = 0.5,
              alpha = 0.6,
              size = 6) +
    scale_x_continuous( limits = c(0, 13),
                        expand = c(0, 0), 
                        breaks = seq(1, 12, by = 1),
                        labels = c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"),
                       ) +
    scale_y_continuous(expand = c(0, 0)) + #start axis origin at 0
    facet_wrap(~yd, ncol = 1, strip.position = "left", scales = 'free_x') + # scales free to repeat x axis on each facet
    theme(legend.position = "none") 
 
  p <- 
  plot.year.facet +
    labs(title = "Moins d'activités sportives à Antibes en 2023 par rapport à 2022",
         subtitle = "Nombre d'activités sportives organisées à Antibes par mois et par années.",
         caption = social_caption) + tt2
  p
                          
    ## Bar charts for top 10s  

      # Plot for top 10 organisateurs
      plot_orgs <- ggplot(top_orgs, aes(x = reorder(organisateur, n), y = n)) +
        geom_bar(stat = "identity", fill =  "#457ECD") +
        geom_text(aes(label = n), hjust = 1.8, size = 8, family = setfont, fontface = "bold", color = "white") +
        coord_flip() +
        labs(
          title = "Top 10 des organisateurs d'activités sportives à Antibes",
          subtitle = "Classement des organisations sportives d'Antibes Juan-Les-Pins, par nombre d'activités organisées. Période 2020-2023",
          caption = social_caption2
        ) + tt4
      
      # Plot for top 10 lieux
      plot_lieux <- ggplot(top_lieux, aes(x = reorder(lieu_1, n), y = n)) +
        geom_bar(stat = "identity", fill = "#FC972F") +
        geom_text(aes(label = n), hjust = 1.8, size = 8, family = setfont, fontface = "bold", color = darkblue) +
        coord_flip() +
        labs(
          title = "Top 10 des lieux d'activités sportives à Antibes",
          subtitle = "Classement des lieux d'Antibes Juan-Les-Pins, par nombre d'activités sportives acceuillies. <br>Période 2020-2023",
          caption = social_caption2
          
        ) + tt4
      
  # Combine the plots side by side
  plot_orgs
  plot_lieux
  
  
  
# OUTPUT ----
    plot_orgs 
    plot_lieux        
    p
  

