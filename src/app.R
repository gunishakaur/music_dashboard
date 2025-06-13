# Libraries Used
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(plotly)

# Load dataset
music_data <- read.csv("../data/raw/global_music_data.csv")

# UI
ui <- dashboardPage(
  dashboardHeader(title = "🎧 Global Music Dashboard"),
  dashboardSidebar(
    width = 350,
    tags$head(tags$style(HTML("
        font-size: 20px;
      }
      .sidebar .form-group, .sidebar select, .sidebar input {
        margin: auto;
        width: 80%;
        text-align: center;
      }
      .sidebar .control-label {
        font-size: 22px;
        font-weight: bold;
      }
    "))),
    br(),
    selectInput("country", "Country:", choices = unique(music_data$Country)),
    sliderInput("age_range", "Age Range:", min = min(music_data$Age), max = max(music_data$Age), value = c(20, 40)),
    selectInput("subscription", "Subscription:", choices = unique(music_data$Subscription.Type))
    
  ),
  dashboardBody(
    fluidRow(
      valueBoxOutput("total_users"),
      valueBoxOutput("avg_minutes"),
      valueBoxOutput("popular_genre"),
      valueBoxOutput("top_platform")
    ),
    fluidRow(
      box(title = "Listening Time Distribution by Subscription",
          plotlyOutput("violin_plot"), width = 6),
      box(title = "Genre Proportion in Selected Country",
          plotlyOutput("genre_pie"), width = 6)
    ),
    fluidRow(
      box(title = "Age vs Minutes Streamed",
          plotlyOutput("age_scatter"), width = 12)
    )
  ),
  dashboardBody(
    tags$style(HTML("body {background-color: #f4f7f9;}"))
  )
)

server <- function(input, output) {
  
  filtered_data <- reactive({
    music_data |>
      filter(Country == input$country,
             Age >= input$age_range[1] & Age <= input$age_range[2],
             Subscription.Type == input$subscription)
  })
  
  output$total_users <- renderValueBox({
    valueBox(nrow(filtered_data()), "Total Users", icon = icon("users"), color = "blue")
  })
  
  output$avg_minutes <- renderValueBox({
    avg <- round(mean(filtered_data()$Minutes.Streamed.Per.Day, na.rm = TRUE), 1)
    valueBox(avg, "Avg Minutes per Day", icon = icon("clock"), color = "green")
  })
  
  output$popular_genre <- renderValueBox({
    genre <- filtered_data() |> count(Top.Genre) |> arrange(desc(n)) |> slice(1) |> pull(Top.Genre)
    valueBox(genre, "Top Genre", icon = icon("music"), color = "purple")
  })
  
  output$top_platform <- renderValueBox({
    platform <- filtered_data() |> count(Streaming.Platform) |> arrange(desc(n)) |> slice(1) |> pull(Streaming.Platform)
    valueBox(platform, "Top Platform", icon = icon("headphones"), color = "orange")
  })
  
  output$violin_plot <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = Subscription.Type, y = Minutes.Streamed.Per.Day, fill = Subscription.Type)) +
      geom_violin(trim = FALSE) + geom_boxplot(width = 0.1, fill = "white") + theme_minimal()
    ggplotly(p)
  })
  
  output$genre_pie <- renderPlotly({
    genre_count <- filtered_data() |> count(Top.Genre)
    plot_ly(genre_count, labels = ~Top.Genre, values = ~n, type = 'pie') |>
      layout(title = paste("Genres in", input$country))
  })
  
  output$age_scatter <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = Age, y = Minutes.Streamed.Per.Day, color = Subscription.Type)) +
      geom_point(alpha = 0.7) + geom_smooth(method = "lm", se = TRUE) +
      labs(x = "Age", y = "Minutes per Day")
    ggplotly(p)
  })
}

shinyApp(ui, server)
