create_dirs_for_days <- function(days) {
  # Get the current working directory
  working_dir <- getwd()
  
  # Define the path for the posts folder inside the working directory
  posts_dir <- file.path(working_dir, "posts")

  # Loop over each day in the list
  for (day in days) {
    # Create directories for data, plots, and scripts inside each day folder in posts/
    day_dir <- file.path(posts_dir, day)

    dir.create(file.path(day_dir, "data"), recursive = TRUE)
    dir.create(file.path(day_dir, "plots"), recursive = TRUE)
    dir.create(file.path(day_dir, "scripts"), recursive = TRUE)
    
    # Copy index_template.qmd to index.qmd in the day folder if the template exists
    template_path <- file.path(posts_dir, "index_template.qmd")
    index_path <- file.path(day_dir, "index.qmd")
    
    if (file.exists(template_path)) {
      file.copy(template_path, index_path)
    } else {
      warning("Template file 'index_template.qmd' not found in posts directory.")
    }
    cat("Created", day_dir, "with data, plots, scripts\n")
  }
}

# Call the function with a vector of days
create_dirs_for_days(c(
                      "2025-01-22", 
                      "2025-01-23"
                      )
                    )

