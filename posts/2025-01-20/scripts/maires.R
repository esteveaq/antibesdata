library(tidyverse)
library(janitor)
library(skimr)
source("scripts/themes.R")


# Idea : https://jrnold.github.io/priestley/articles/priestley.html

# IMPORT------

m <- read_csv2("data/antibes-maires-depuis1681.csv")

# INSPECT -----
          head(m)
          tail(m)
          glimpse(m)
          skim(m)
          summary(m)
          str(m)
          names(m)
          colnames(m)
          unique(m$MAIRE_NOM)
          janitor:::tabyl(m$MAIRE_NOM)  %>% arrange(-percent)


# CLEANING ------
        m <- 
          m %>%
          select(3:9) %>%
          select(-6) %>%
          mutate_if(is.character, as.factor) %>%
          mutate(duree = m$FIN_MANDAT-m$DEBUT_MANDAT_ANNEE) %>%
          ungroup() %>%
          arrange(MAIRE_NOM) %>%
          arrange(DEBUT_MANDAT_ANNEE) %>%
          group_by(MAIRE_NOM, MAIRE_PRENOM) %>%
          mutate(id = cur_group_id()) %>%
          mutate(dureetot = cumsum(duree)) %>%
          mutate(dureetotmax = max(dureetot)) %>%
          unite(idnom, c(MAIRE_PRENOM,MAIRE_NOM,id), remove = FALSE) 
        
        
        #make col with unique names
        m <- m %>%
          mutate(labelname = paste0(`MAIRE_PRENOM`, " ", `MAIRE_NOM`)) %>%
          group_by(labelname) %>%
          mutate(labelname = ifelse(row_number() == 1, labelname, NA_character_)) %>%
          ungroup()
        glimpse(m)


# ANALYSIS AND PLOTTING ------
       
      # PREP   
        #check labelname are unique
        print(m[c("idnom", "labelname")])
        
        #create CONTEXTE HISTORIQUE BOXES
        m <-
        m %>% 
          group_by(CONTEXTE_HISTORIQUE) %>%
          mutate(CONTEXTEmin = min(DEBUT_MANDAT_ANNEE),
                 CONTEXTEmax = max(FIN_MANDAT)) %>%
          ungroup()
        
        #create CONTEXTE HISTORIQUE bins, for the faceting
        m <-
          m %>%
          mutate(phase = cut(DEBUT_MANDAT_ANNEE,
                             breaks = c(1680,1800,1900,2020,2026),
                             labels = c("XVII-XVIIIeme", "XIXeme", "XXeme", "XXIeme"))) %>%
          filter(DEBUT_MANDAT_ANNEE > 1808)
          
      # PLOTS
        timeline <- 
        m %>%
          mutate(phase = fct_rev(phase)) %>%  # Reverse the order of facets
          ggplot(aes(
            x = DEBUT_MANDAT_ANNEE, 
            y = reorder(idnom, DEBUT_MANDAT_ANNEE), 
            )) +
          geom_segment(aes(xend = FIN_MANDAT, 
                           yend = idnom,
                           color = reorder(CONTEXTE_HISTORIQUE, FIN_MANDAT) # Color mapping for segments
                           ),  
                       linewidth = 6, lineend = "round"
                       ) +
          geom_text(
                      aes(label = labelname),
                      size = 4.5, 
                      hjust = 0.05,
                      nudge_y = 0.4, 
                      family = setfont,
                      color = "gray20"
          ) +
          geom_text(data = m %>%
                            filter(m$dureetotmax >= 9) %>%
                            group_by(idnom) %>%
                            summarise(dureetotmax = max(dureetotmax),
                                      DEBUT_MANDAT_ANNEE = min(DEBUT_MANDAT_ANNEE)),
                    aes(
                      x = DEBUT_MANDAT_ANNEE,
                      y = reorder(idnom, DEBUT_MANDAT_ANNEE), 
                      label = paste0(dureetotmax, " ans")
                      ),
                    size = 4,
                    hjust = 0.1,
                    vjust = 2.1,
                    nudge_y = 0.4,
                    family = setfont,
                    color = "white",
                    fontface = "bold"
                    ) +
          annotate(
            "label",
            x = -Inf,  # Position at the far left of the plot
            y = Inf,   # Position at the top of the plot
            label = "  
            
          Jean LEONETTI est maire d'Antibes depuis 1995, 
          et totalisera 31 années de mandats d'ici 2026.
          Il est aussi député des Alpes-Maritimes et
          président de la communauté d'agglomération 
          de Sophia Antipolis depuis 2002.
          L'élu détient le record de longévité après 
          Jean-Baptiste ROSTAN, qui a servi 34 ans 
          entre 1831 et 1865.",
            hjust = 0,  
            vjust = 1, 
            family = setfont,
            fontface = "bold",
            size = 4.5, 
            color = "gray30",  
            fill = "#FAE5C6",
            label.size = 0   # Removes the border around the label
          ) +
          annotate(
            "curve",
            x = 1928,   
            xend = 1990,     
            y = max(as.numeric(factor(m$idnom)))-0.5,  
            yend = max(as.numeric(factor(m$idnom))+0.1),    
            curvature = -0.2,              # Curve level
            arrow = arrow(length = unit(0.02, "npc"), type = "open"),
            colour = "gray30",            # Arrow color
            size = 1.2                   # Arrow thickness
          ) +
          labs(title = "Jean Leonetti : record de longévité à la mairie d'Antibes",
               subtitle = "Mandats des maires d'Antibes du XIXème siècle à nos jours",
               caption = social_caption,
               color ="Contexte historique") +
          scale_color_manual(values = custom_palette) +
          scale_fill_manual(values = custom_palette) +
          tt.maires +
          guides(color = guide_legend(reverse = TRUE)) +
          scale_x_continuous(
            limits = c(min(m$DEBUT_MANDAT_ANNEE)-1, max(m$FIN_MANDAT) + 1), # Add space
            expand = expansion(mult = 0.1)                      # Add 10% space on both sides
          )

# OUTPUT ------
        show(timeline)

# ggsave("timeline.png", 
#        plot = timeline, 
#        width = 577, 
#        height = 1215,
#        units = "px")

