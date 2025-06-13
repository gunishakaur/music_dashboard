# DSCI_532_Music_dashboard

Music dashboard

## Motivation

Target audience: Music Industry Analysts and Streaming Service Providers

The global music industry thrives on understanding user preferences and engagement trends. With the rise of streaming platforms, analyzing user behavior has become essential for shaping marketing strategies, optimizing subscription models, and curating personalized music recommendations. This dashboard enables industry analysts and streaming providers to explore global music consumption trends based on demographic factors, subscription types, and streaming habits. Users can interactively filter and visualize data to uncover insights on listening time distribution, top genres, and platform preferences.

## App Description

A short video walkthrough of the app demonstrating its features, target audience, and functionalities can be accessed here [![Video link](https://github.ubc.ca/mds-2024-25/DSCI_532_individual-assignment_gkaur201/blob/master/img/demo.mp4)] or if file is large please click on this link [![Watch the Video](https://drive.google.com/file/d/13DDF8NCmBvqu8NSjdsjOawR48GnqH-V2/view?usp=drive_link)] it will direct you to google drive.

## Instalation Instructions

1. Clone the repository:  

   ```shell
   git clone git@github.ubc.ca:mds-2024-25/DSCI_532_individual-assignment_gkaur201.git
   cd DSCI_532_individual-assignment_gkaur201
   ```  

2. Make sure you have RStudio installed. If not, please go to <https://posit.co/downloads/>

3. Install the following packages by running the following commands in your RStudio console:

   ```R
   install.packages(c("shiny", "shinydashboard", "ggplot2", "dplyr", "plotly"))
   ```

4. Open the `app.R` file in RStudio by navigating to `src/app.R` in the directory

5. Run the application by hitting the `Run App` button in RStudio or type in terminal `shiny::runApp("app.R")`

6. The app will open in your default web browser.


