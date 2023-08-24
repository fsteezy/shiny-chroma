library(shiny)
library(chRoma)


ui <- fluidPage(
  titlePanel("chRoma Embedding Analysis"),
  sidebarLayout(
    sidebarPanel(
      fileInput("embeddingFile", "Upload Embedding Data", accept = ".csv"),
      actionButton("analyzeButton", "Analyze Embedding")
    ),
    mainPanel(
      plotOutput("embeddingPlot")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$analyzeButton, {
    req(input$embeddingFile)
    embeddings <- read.csv(input$embeddingFile$datapath)
    # Assuming your data has columns like x, y, label
    output$embeddingPlot <- renderPlot({
      chRoma::chRoma_plot(embeddings, x = "x", y = "y", label = "label")
    })
  })
}

shinyApp(ui, server)


