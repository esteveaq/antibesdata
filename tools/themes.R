library(tidyverse)
library(showtext)
library(sysfonts)
library(ggtext)
library(glue)

#Social Caption fonts
sysfonts::font_add(
  family = "FontAwesome6Brands",
  regular = "tools/fonts/Font Awesome 6 Brands-Regular-400.otf" # Update the path
)

#Plot fonts
font_add_google("Dosis", "dosis")
setfont <- "dosis"
showtext_auto()  # Enable the use of showtext for plots

# Define icons and user information
twitter_icon <- "&#xf099;"  # Unicode for Twitter
github_icon <- "&#xf09b;"   # Unicode for GitHub
twitter_handle <- "@AntibesData"
github_repo <- "esteveaq.github.io/antibesdata"

# Combine into an HTML caption
social_caption <- glue(
  "
  <span style='font-family:\"FontAwesome6Brands\"; color:#1DA1F2;'>{twitter_icon}</span> {twitter_handle} &nbsp; | &nbsp;
  <span style='font-family:\"FontAwesome6Brands\"; color:#333;'>{github_icon}</span> {github_repo} &nbsp; 
  <br>Données : Ville d’Antibes sur data.gouv.fr
  "
)

social_caption2 <- glue(
  "
  <span style='font-family:\"FontAwesome6Brands\"; color:#1DA1F2;'>{twitter_icon}</span> {twitter_handle} &nbsp; | &nbsp;
  <span style='font-family:\"FontAwesome6Brands\"; color:#333;'>{github_icon}</span> {github_repo} &nbsp; 
  <br>Données : Ville d’Antibes sur data.gouv.fr,  {date_caption}
  "
)

social_caption3 <- glue(
  "
  <span style='font-family:\"FontAwesome6Brands\"; color:#1DA1F2;'>{twitter_icon}</span> {twitter_handle} &nbsp; | &nbsp;
  <span style='font-family:\"FontAwesome6Brands\"; color:#333;'>{github_icon}</span> {github_repo} &nbsp; 
  <br>Données : Ville d’Antibes sur data.gouv.fr, 27 septembre 2024
  "
)

# Colors
darkblue <- "#0E1E38"


# Themes -------

## tt. -------
tt <- theme(
  
                # Title
                plot.title = element_text(margin = margin(t = 15, b = 25, l = 0), 
                                          hjust = 0,
                                          family = setfont,
                                          face = "bold", 
                                          color ="black",
                                          size = 22,
                ),
                
                # Subtitle
                 plot.subtitle = element_textbox_simple(
                   margin = margin(b = 5, l = 0),
                   hjust = 0,
                   size = 12,
                   family = setfont,
                   colour ="gray25"),
                
                #Caption
                plot.caption = element_textbox_simple(
                  margin = margin(t = 25, r = 2, b = 3),
                  family = setfont,
                  face = "bold",
                  size = 12,
                  halign = 1,
                  vjust = -10,
                  colour ="gray40"
                ),
                
                # Panel
                panel.background = element_rect(fill = "#FAE5C6", color = NA), # Set plot panel to beige
                panel.grid.major.x = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
                panel.grid.major.y = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
                panel.grid.minor.x = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
                panel.grid.minor.y = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
                
                # Plot
                plot.background = element_rect(fill = "#FAE5C6", color = NA),  # Set background to beige
                plot.margin = margin(l = 25, b = 15, r = 10),
                
                # Axis
                axis.ticks = element_blank(),
                axis.text.y = element_text( 
                  margin = margin(l = 10, r = 0),
                  hjust = 1,
                  vjust = 0,
                  family = setfont,
                  face = "bold", 
                  color ="gray40",
                  size = 12,
                ),
                axis.text.x = element_text(
                  size = 12,
                  family = setfont,
                  color ="gray40", 
                  face = "bold"),   # Remove y-axis tick labels
                axis.title.x = element_blank(),  # Remove x-axis title
                axis.title.y = element_blank()
)


## tt.maires -------

tt.maires <- theme(
  
  
  # Titles and caption
  plot.title = element_text(margin = margin(t = 13, b = 5, l = 4), 
                            hjust = 0,
                            family = setfont,
                            face = "bold", 
                            color ="gray4",
                            size = 20,
                            ),
  plot.subtitle = element_textbox_simple(
                            margin = margin(b = 10, l = 4),
                            hjust = 0,
                            family = setfont,
                            face = "bold",
                            size = 14,
                            colour ="gray25"),
  plot.caption = element_textbox_simple(
    margin = margin(t = 10, r = 10, b = 3),
    family = setfont,
    face = "bold",
    size = 16,
    halign = 1,
    vjust = -10,
    colour ="gray40",
    ),
  
  # Panel 
  panel.background = element_rect(fill = "#FAE5C6"), # Set plot panel to beige
  panel.grid.major.x = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
  panel.grid.minor.x = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
  plot.background = element_rect(fill = "#FAE5C6"),  # Set background to beige
  plot.margin = margin(b = 6, l = 5),
  panel.grid.major = element_blank(),
  
  # Axis
  axis.ticks = element_blank(),
  axis.text.y = element_blank(),   # Remove y-axis tick labels
  axis.text.x = element_text(family = setfont, size = 12, face = "bold"),   # Remove y-axis tick labels
  axis.title.x = element_blank(),  # Remove x-axis title
  axis.title.y = element_blank(), # Remove y-axis title
  
  # Legend 
  legend.position = c(0.86, 0.17),  # Overlay legend in bottom-right corner
  legend.direction = "vertical",  # Single column legend
  legend.background = element_rect(fill = "#FAE5C6", color = "#FAE5C6", size = 0.3), # Add background
  legend.key = element_rect(fill = "#FAE5C6"), # Transparent keys
  legend.title = element_text(size = 14, color = "gray20", family = setfont, face = "bold"), # Style legend title
  legend.text = element_text(size = 12, family = setfont)                  # Style legend text
)


## tt2 -------

tt2 <- theme(
  
        # Fonts
        text = element_text(family = setfont),
        
        # Plot panel background
        panel.background = element_rect(fill = "#FAE5C6"),
        plot.background = element_rect(fill = "#FAE5C6"),
        plot.margin = margin(t = 0,  
                             r = 30,  
                             b = 0,  
                             l = 15),
        
        
        panel.margin = unit(0, "lines"),      # Reduce the space between the plot and panel
        panel.margin = unit(1, "lines"),    # Increase space between facets
        
        # Grid lines
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        
        # Title
        plot.title = element_text(margin = margin(t = 13, b = 3, l = -5), 
                                  hjust = 0,
                                  family = setfont,
                                  face = "bold", 
                                  color ="black",
                                  size = 18),
        
        # Subtitle 
        plot.subtitle = element_textbox_simple(
          margin = margin(b = 5, l = -5),
          hjust = 0,
          family = setfont,
          size = 14,
          colour ="gray25"),
        
        # Facet titles
        strip.background = element_blank(), # Light gray background, no contour
        strip.text = element_text(hjust = 0.5, vjust = 0.5, size = 12, face = "bold"),           # Bold text, centered
        strip.text.x = element_text(margin = margin(t = 0, b = 0)),      # Adjust vertical spacing
        strip.text.y = element_text(margin = margin(r = 0, l = 0)),      # Adjust horizontal spacing
        strip.placement = "outside",             # Place facet strip titles outside
        
        # Axis 
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),          # Remove y-axis title on the left
        axis.text.y = element_blank(),           # Remove y-axis text on the left
        axis.title.y.right = element_blank(),    # Remove title from right axis
        axis.text.y.right = element_text(        # Style y-axis labels on the right
          margin = margin(l = 5, r = 10), 
          hjust = 0.1, 
          size = 8, 
          color = "gray40"
        ),
        axis.line.x = element_line(color =  darkblue),
        
        # Ticks 
        axis.ticks.x = element_line(color = "gray40", linewidth = .5),
        axis.ticks.y = element_blank(),
        
        # Captions
        plot.caption = element_textbox_simple(
          margin = margin(t = 10, r = 2, b = 3),
          family = setfont,
          face = "bold",
          size = 12,
          halign = 1,
          vjust = -10,
          colour ="gray40",
        )
        
      )


## gt_theme -------
gt_theme <- function(tbl_medals_gt) {
  tbl_medals_gt %>%
    tab_options(
    table.font.names = setfont,         # Custom Google font
    table.background.color = "#FAE5C6",  # Background for entire table
    table.font.size = px(14),             # Font size
    column_labels.font.weight = "bold"  # Bold column labels
    )
}

## tt3 -------

tt3 <- theme(
  
  # Fonts
  text = element_text(family = setfont),
  
  # Plot panel background
  panel.background = element_rect(fill = "#FAE5C6"),
  plot.background = element_rect(fill = "#FAE5C6"),
  plot.margin = margin(t = 0,  
                       r = -10,  
                       b = 15,  
                       l = 10),
  
  # Grid lines
  panel.grid.major.x = element_blank(),
  panel.grid.major.y = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
  panel.grid.minor.x = element_blank(),
  panel.grid.minor.y = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
  
  # Title
  plot.title = element_text(margin = margin(t = 13, b = 8, l = -5), 
                            hjust = 0,
                            family = setfont,
                            face = "bold", 
                            color ="black",
                            size = 18),
  
  # Subtitle 
  plot.subtitle = element_textbox_simple(
    margin = margin(b = 30, l = -5),
    hjust = 0,
    family = setfont,
    size = 14,
    colour ="gray25"),
  
  # Axis 
  axis.title.x = element_blank(),
  axis.title.y = element_text(size = 14, hjust = 1, vjust = 1),
  axis.line.x = element_line(color =  "#3D2358"),
  axis.text.x = element_text(size = 14, angle = 45, vjust = 1.1, hjust = 1.1),
  axis.text.y = element_text(size = 14),
  
  # Ticks 
  axis.ticks.x = element_blank(),
  axis.ticks.y = element_blank(),
  
  # Captions
  plot.caption = element_textbox_simple(
    margin = margin(t = 15, r = 2, b = 3),
    family = setfont,
    face = "bold",
    size = 12,
    halign = 1,
    vjust = -10,
    colour ="gray40"
  ),

 # Legend
 legend.direction = "vertical",  # Single column legend
 legend.background = element_rect(fill = "#FAE5C6", color = "#FAE5C6", size = 0.3), # Add background
 legend.key = element_rect(fill = "#FAE5C6"), # Transparent keys
 legend.title = element_text(size = 14, color = "gray20", family = setfont, face = "bold"), # Style legend title
 legend.text = element_text(size = 12, family = setfont)                  # Style legend text
)

## tt4 -------

tt4 <-
  theme(
    # Fonts
    text = element_text(family = setfont),
    
    # Plot panel background
    panel.background = element_rect(fill = "#FAE5C6"),
    plot.background = element_rect(fill = "#FAE5C6"),
    plot.margin = margin(t = 0,  
                         r = 30,  
                         b = 30,  
                         l = 0),
    
    # Grid lines
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    
    # Title
    plot.title = element_text(margin = margin(t = 13, b = 10, l = -15), 
                              hjust = 0,
                              family = setfont,
                              face = "bold", 
                              color ="black",
                              size = 22),
    
    # Subtitle 
    plot.subtitle = element_textbox_simple(
      margin = margin(b = 15, l = -15),
      hjust = 0,
      family = setfont,
      size = 16,
      colour ="gray25"),
     
    # Axis 
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_text(size = 14, family = setfont, hjust = 1, color = darkblue),
    axis.text.x = element_blank(),
    
    # Ticks 
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    
    # Captions
    plot.caption = element_textbox_simple(
      margin = margin(t = 5, r = 2, b = 3),
      family = setfont,
      face = "bold",
      size = 14,
      halign = 1,
      vjust = -10,
      colour ="gray40"
    ),
    
    # Legend
    legend.position = "none",  # Overlay legend in bottom-right corner
  )

## tt5 -------

tt5 <-
  theme(
    # Fonts
    text = element_text(family = setfont),
    
    # Plot panel background
    panel.background = element_rect(fill = "#FAE5C6"),
    plot.background = element_rect(fill = "#FAE5C6"),
    plot.margin = margin(t = 0,  
                         r = 20,  
                         b = 15,  
                         l = 20),
    
    # Title
    plot.title = element_text(margin = margin(t = 13, b = 3, l = -5), 
                              hjust = 0,
                              family = setfont,
                              face = "bold", 
                              color ="black",
                              size = 18),
    
    # Subtitle 
    plot.subtitle = element_textbox_simple(
      margin = margin(b = 15, l = -5),
      hjust = 20,
      family = setfont,
      size = 14,
      colour ="gray25"),
    
     # Axis 
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_text(size = 10, family = setfont, hjust = 1.1, color = darkblue),
    axis.text.x = element_blank(),
    

    # Captions
    plot.caption = element_textbox_simple(
      margin = margin(t = 15, r = 2, b = 5),
      family = setfont,
      face = "bold",
      size = 12,
      halign = 1,
      vjust = -10,
      colour ="gray40"
    ),
    
    # Legend
    legend.position = "none",  # Overlay legend in bottom-right corner
  )

## tt6 -------


tt6 <-
  theme(
    # Fonts
    text = element_text(family = setfont),
    
    # Plot panel background
    panel.background = element_rect(fill = "#FAE5C6"),
    plot.background = element_rect(fill = "#FAE5C6"),
    plot.margin = margin(t = 0,  
                         r = 15,  
                         b = 0,  
                         l = 25),
    # Grid lines
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    
    # Axis 
    axis.title.y = element_blank(),
    axis.title.x = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_text(size = 18, family = setfont, color = darkblue, face = "bold"),
    axis.line.x = element_line(color =  "#3D2358"),
                               
    # Ticks 
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    
    # Title
    plot.title = element_text(margin = margin(t = 13, b = 3, l = -5), 
                              hjust = 0,
                              family = setfont,
                              face = "bold", 
                              color ="black",
                              size = 18),
    # Subtitle 
    plot.subtitle = element_textbox_simple(
      margin = margin(b = 15, l = -5),
      hjust = 20,
      family = setfont,
      size = 14,
      colour ="gray25"),
    
    # Captions
    plot.caption = element_textbox_simple(
      margin = margin(t = 5, r = 2, b = 5),
      family = setfont,
      face = "bold",
      size = 12,
      halign = 1,
      vjust = -10,
      colour ="gray40"
    ),
    
    # Legend
    legend.position = "none",  # Overlay legend in bottom-right corner
  )


## tt7 -------

tt7 <- theme(
  
  # Fonts
  text = element_text(family = setfont),
  
  # Plot panel background
  panel.background = element_rect(fill = "#FAE5C6"),
  plot.background = element_rect(fill = "#FAE5C6", colour = NA),
  plot.margin = margin(t = 0,  
                       r = 10,  
                       b = 5,  
                       l = 10),
  # Facet titles
  strip.background = element_blank(),
  strip.text = element_blank(),        
  
  # Grid lines
  panel.grid.major.x = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
  panel.grid.major.y = element_blank(),
  panel.grid.minor.x = element_blank(),
  panel.grid.minor.y = element_blank(),
  
  # Title
  plot.title = element_text(margin = margin(t = 13, b = 8, l = 0), 
                            hjust = 0,
                            family = setfont,
                            face = "bold", 
                            color ="black",
                            size = 18),

  # Subtitle 
  plot.subtitle = element_textbox_simple(
    margin = margin(b = 20, l = 0),
    hjust = 0,
    family = setfont,
    size = 14,
    colour ="gray25"),
  
  # Axis 
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.line.x = element_blank(),
  axis.text.x = element_text(size = 14),
  axis.text.y = element_text(size = 15),
  
  
  # Ticks 
  axis.ticks.x = element_blank(),
  axis.ticks.y = element_blank(),
  
  # Captions
  plot.caption = element_textbox_simple(
    margin = margin(t = 8, r = 2, b = 2),
    family = setfont,
    face = "bold",
    size = 14,
    halign = 1,
    vjust = -10,
    colour ="gray45"
  ),
  
  # Legend
  legend.position = "none",  # Overlay legend in bottom-right corner
)

## tt8 -------

tt8 <- theme(
  
  # Fonts
  text = element_text(family = setfont),
  
  # Plot panel background
  panel.background = element_rect(fill = "#FAE5C6"),
  plot.background = element_rect(fill = "#FAE5C6", colour = NA),
  plot.margin = margin(t = 5,  
                       r = 10,  
                       b = 5,  
                       l = 10),
  panel.spacing = unit(2, "lines"),
  
  # Facet titles
  strip.background = element_blank(),
  strip.text = element_text(size = 14,
                            face = "bold",
                             margin = margin(t = -1)),        
  
  # Grid lines
  panel.grid.major.x = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
  panel.grid.major.y = element_blank(),
  panel.grid.minor.x = element_blank(),
  panel.grid.minor.y = element_blank(),
  
  # Title
  plot.title = element_text(margin = margin(t = 13, b = 6, l = -5), 
                            hjust = 0,
                            family = setfont,
                            face = "bold", 
                            color ="black",
                            size = 18),
  
  # Subtitle 
  plot.subtitle = element_textbox_simple(
    margin = margin(b = 15, l = -5),
    hjust = 0,
    family = setfont,
    size = 14,
    colour ="gray25"),
  
  # Axis 
  axis.title.x = element_text(hjust = 1),
  axis.title.y = element_blank(),
  axis.line.x = element_blank(),
  axis.text.x = element_text(size = 12),
  axis.text.y = element_text(size = 12, 
                             margin = margin(r = -15)),
  
  
  # Ticks 
  axis.ticks.x = element_blank(),
  axis.ticks.y = element_blank(),
  
  # Captions
  plot.caption = element_textbox_simple(
    margin = margin(t = 8, r = 2, b = 2),
    family = setfont,
    face = "bold",
    size = 12,
    halign = 1,
    vjust = -10,
    colour ="gray40"
  ),
  
  # Legend
  legend.position = "none",  # Overlay legend in bottom-right corner
)



## tt9 -------

tt9 <- theme(
  
  # Fonts
  text = element_text(family = setfont),
  
  # Plot panel background
  panel.background = element_rect(fill = "#FAE5C6"),
  plot.background = element_rect(fill = "#FAE5C6", colour = NA),
  
  # Grid lines
  panel.grid.major.x =  element_blank(),
  panel.grid.major.y = element_line(color = "gray", linewidth = 0.5, linetype = "dotted"),
  panel.grid.minor.x = element_blank(),
  panel.grid.minor.y = element_blank(),
  
  # Title
  plot.title = element_text(margin = margin(t = 13, b = 6, l = -5), 
                            hjust = 0,
                            family = setfont,
                            face = "bold", 
                            color ="black",
                            size = 18),
  # Subtitle 
  plot.subtitle = element_textbox_simple(
    margin = margin(b = 15, l = -5),
    hjust = 0,
    family = setfont,
    size = 14,
    colour ="gray25"),
  
  # Axis 
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.line.x = element_blank(),
  axis.text.x = element_text(size = 18, family = setfont, color = darkblue, face = "bold"),
  axis.text.y = element_text(size = 12),
  
  
  # Ticks 
  axis.ticks.x = element_blank(),
  axis.ticks.y = element_blank(),
  
  # Captions
  plot.caption = element_textbox_simple(
    margin = margin(t = 8, r = 2, b = 2),
    family = setfont,
    face = "bold",
    size = 12,
    halign = 1,
    vjust = -10,
    colour ="gray40"
  ),
  
  # Legend
  legend.position = "none",  # Overlay legend in bottom-right corner
)

# COLORS -----

# Define the hex codes
custom_palette <- c(
  "#9BAE64",
  "#82BCF1",
  "#93B6D6",
  "#D38035",
  "#769047",
  "#BD6B37",
  "#824B79",  # highlightmain
  "#946285",  # Replacement 2 (lighter)
  "#A57992",  # Replacement 3 (lighter)
  "#3D2358",
  "#D8A85E",
  "#C49755",
  "#B08955"
)


custom_palette1 <- c(
  "Athlétisme" = "#D38035",
  "Carabine" = "#3D2358",
  "Gymnastique Artistique" = "#FD9CB4",
  "Trampoline" ="#BD6B37",          
  "Pistolet" = "#5F3C24",
  "Tennis De Table" = "#9BAE64",
  "Tir" = "#400101",    
  "voile" = "#50B4F2",                 
  "Gymnastique" = "#824B79",      
  "Natation" =  "#1D6FA1",
  "Or" = "#F2D785",
  "Argent" = "#CACACA",
  "Bronze" = "#D98162"
  )
 
custom_palette_treemap <- c(
  "#590202",
  "#4D6600",
  "#1D6FA1",
  "#D38035",
  "#769047",
  "#824B79",
  "#3D2358",
  "#5F3C24"
  
  
)

custom_palette_medailles <-
c("Or" = "#F2D785", 
  "Argent" = "#CACACA", 
  "Bronze" = "#D98162")


custom_palette_water_temp <- c(
  "#06283B", 
  "#27598E",
  "#457ECD",
  "#81B0C7", 
  "#FEFE8D", 
  "#FFCF5D",
  "#FC972F",
  "#A61414",
  "#590202"
)


custom_palette2 <- c(
  '#9bae64',
  '#99af70',
  '#97b07c',
  '#95b287',
  '#93b393',
  '#91b49f',
  '#8eb5aa',
  '#8cb6b6',
  '#8ab7c2',
  '#88b9ce',
  '#86bad9',
  '#84bbe5',
  '#82bcf1',
  '#83bcef',
  '#85bbec',
  '#86bbea',
  '#88bae8',
  '#89bae6',
  '#8ab9e3',
  '#8cb9e1',
  '#8db8df',
  '#8fb8dd',
  '#90b7db',
  '#92b6d8',
  '#93b6d6',
  '#98b2c9',
  '#9eadbb',
  '#a3a8ae',
  '#a8a4a0',
  '#aea093',
  '#b39b86',
  '#b89678',
  '#be926b',
  '#c38e5d',
  '#c88950',
  '#ce8442',
  '#d38035',
  '#cb8136',
  '#c38338',
  '#bc843a',
  '#b4853b',
  '#ac873c',
  '#a4883e',
  '#9d8940',
  '#958b41',
  '#8d8c42',
  '#868d44',
  '#7e8f46',
  '#769047',
  '#7c8d46',
  '#828a44',
  '#888743',
  '#8e8442',
  '#948140',
  '#9a7e3f',
  '#9f7a3e',
  '#a5773c',
  '#ab743b',
  '#b1713a',
  '#b76e38',
  '#bd6b37',
  '#b8683c',
  '#b36642',
  '#ae6348',
  '#a9604d',
  '#a45e52',
  '#a05b58',
  '#9b585e',
  '#965663',
  '#915368',
  '#8c506e',
  '#874e73',
  '#824b79',
  '#844d7a',
  '#854f7b',
  '#86517c',
  '#88537d',
  '#8a557e',
  '#8b567f',
  '#8c5880',
  '#8e5a81',
  '#905c82',
  '#915e83',
  '#926084',
  '#946285',
  '#956486',
  '#976687',
  '#986888',
  '#9a6a89',
  '#9b6c8a',
  '#9c6e8c',
  '#9e6f8d',
  '#9f718e',
  '#a1738f',
  '#a27590',
  '#a47791',
  '#a57992',
  '#9c728d',
  '#946b88',
  '#8b6384',
  '#825c7f',
  '#7a557a',
  '#714e75',
  '#684770',
  '#60406b',
  '#573866',
  '#4e3162',
  '#462a5d',
  '#3d2358',
  '#4a2e58',
  '#573959',
  '#64445a',
  '#714f5a',
  '#7e5a5a',
  '#8a665b',
  '#97715c',
  '#a47c5c',
  '#b1875d',
  '#be925d',
  '#cb9d5e',
  '#d8a85e',
  '#d6a75d',
  '#d5a55d',
  '#d3a45c',
  '#d1a25b',
  '#d0a15a',
  '#cea05a',
  '#cc9e59',
  '#cb9d58',
  '#c99b57',
  '#c79a56',
  '#c69856',
  '#c49755',
  '#c29655',
  '#c19555',
  '#bf9355',
  '#bd9255',
  '#bc9155',
  '#ba9055',
  '#b88f55',
  '#b78e55',
  '#b58c55',
  '#b38b55',
  '#b28a55',
  '#B08955'
)

