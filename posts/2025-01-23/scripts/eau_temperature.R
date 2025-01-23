library(tidyverse)
library(ggridges)
library(viridis)
library(slider)
library(patchwork)
library(paletteer)
source("scripts/themes.R") # themes


# IMPORT -----
source_est <- read_csv("data/2024-12-31_eau_temperature/antibes-eau-temperature-est-cap.csv")
source_ouest <- read_csv("data/2024-12-31_eau_temperature/antibes-eau-temperature-ouest-cap.csv")

df_est <-source_est
df_ouest <- source_ouest

# INSPECT -----
head(df_est)
names(df_est)
glimpse(df_est)
summary(df_ouest)

# CLEANING -----

# standardize and bind datasets
    fn_clean <- function(df, name) {
      # standardize cols
      df <-
        df %>% 
        select(-1, -2) %>%                  # remove useless cols
        rename_with(tolower) %>%                      # lower case variable names
        rename_with(~ str_squish(.)) %>%             
        rename_with(~ str_replace_all(.,"annee ", ""))
      
      # adding useful cols
      df <-
        df %>%
        mutate(region = name)
      
      # pivot longer
      df<-
        df %>%
        pivot_longer(cols = 2:6, names_to = "annee", values_to = "temperature")
      
      return(df)
    }
    
    df_ouest_clean <- fn_clean(df_ouest, "ouest")
    df_est_clean <- fn_clean(df_est, "est")
    
  # bind
  df_bind <- bind_rows(df_est_clean, df_ouest_clean)

# Manage dates
    df_bind_clean <-
      df_bind %>% 
        separate(jour, c("day", "month"), "-") %>%
        mutate(month = str_replace_all(month, "\\.", ""),
               month = str_to_title(month)) # Need to escape the dot (.) here
      
    # check  
    unique(df_bind_clean$month) # month col still needs cleaning 
    
    df_bind_clean <-
      df_bind_clean %>%
        mutate(month = recode(month,
                              "Janv" = "Jan",
                              "Fevr" = "Feb",
                              "Febr" = "Feb",
                              "Févr" = "Feb",
                              "Mars" = "Mar", 
                              "Avr" = "Apr",
                              "Mai" = "May", 
                              "Juin" = "Jun",
                              "Juil" = "Jul",
                              "Août" = "Aug",
                              "Sept" = "Sep",
                              "Oct" = "Oct",
                              "Déc" = "Dec"
                ))            
     
    # add date col 
    df_bind_clean <-
      df_bind_clean %>% 
        mutate(date = dmy(paste(day, month, annee, sep = "-"))) %>%
        select(region, date, temperature, year = annee, month, day) %>% # reorder
        drop_na() %>%                                                   # drop NA
        arrange(date)

    
# PLOT -----
    
    # NOTE : smoothing with a moving average method using slide_dbl() will not plot correctly because there are irregular missing dates in the data.
    # fixing this would require filling missing values with tidyr::complete() and then filling upwards the NA values or computing them, or 
    # using library(zoo) for something like rollmean(df_bind_clean$temperature, 3, fill = "extend"). We are chosing to use acutal values only for this analysis.

    
    # Line graph 
    plot_region_year <-
    df_bind_clean %>%
      drop_na() %>%
      mutate(date = update(date, year = 2024)) %>% # plot on synchronous x-axis, /!\ chose a leap year
      ggplot(aes(x = date, y = temperature, group = year)) + 
      geom_line(aes(color = region)) +
      scale_x_date(date_breaks = "1 month", date_labels = "%b") +
      facet_wrap(~region+year, nrow = 2) 
     plot_region_year
    
  
     df_bind_clean_plot <-
     df_bind_clean %>%
       filter(year > 2020) %>%
       mutate(region = recode(region, "est" = "Est du Cap",
                                      "ouest" = "Ouest du Cap")) %>%
       mutate(month = factor(month, 
                             levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")))
     
     
    # Ridges temperatures per year
    plot_ridges_year <-
      df_bind_clean_plot %>%
      group_by(year) %>%
      ggplot(aes(x = temperature, y = year, fill = after_stat(x))) +
      geom_density_ridges_gradient(color = darkblue) +  
      scale_fill_gradientn(colors = custom_palette_water_temp)   
    plot_ridges_year
    
    # Ridges for temperature by month
    plot_ridges_month <-
      df_bind_clean_plot %>%
      group_by(month) %>%
      ggplot(aes(x = temperature, y = fct_rev(month), fill = after_stat(x))) +
      geom_density_ridges_gradient(color = darkblue) +  
      scale_fill_gradientn(colors = custom_palette_water_temp)
    plot_ridges_month
    
    
# OUTPUT ----

  plot_ridges_year_final <-  
  plot_ridges_year + 
      facet_wrap(~region, ncol =1, strip.position = "top", scales = "free") +
     labs(
       title = "Baignade : l'année 2024 légèrement plus chaude que les précédentes",
       subtitle = "Distribution des revelés de température de l'eau au cap d'Antibes (Celsius), par années",
       x = "Température (Celsius)",
       caption = social_caption2) + tt8
  
  plot_ridges_month_final <-    
  plot_ridges_month + 
    facet_wrap(~region, ncol =1, strip.position = "top", scales = "free") +
    labs(
      title = "Antibes Juan-Les-Pins baignable une grande partie de l'année",
      subtitle = "Distribution des revelés de température de l'eau au cap d'Antibes (Celsius), par mois",
      x = "Température (Celsius)",
      caption = social_caption2) + tt8

    
    
      plot_ridges_month_final  
      plot_ridges_year_final
 
  