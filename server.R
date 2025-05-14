library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)

shinyServer(function(input, output, session) {
  tpm_df_wide<- read.csv("TPMs_table_100genes.csv")
  
  tpm_df <- tpm_df_wide %>%
    pivot_longer(
      cols = -GeneID,
      names_to = "Sample",
      values_to = "TPM"
    )
  
  observe({                                            # update select input with gene IDs
    genes <- unique(tpm_df$GeneID)
    updateSelectInput(
      session, 
      inputId = "gene", 
      choices = genes,
      selected = genes[1]
    )
  })
  
  output$exprPlot <- renderPlot({                      # render the ggplot for selected gene
    req(input$gene)                                    # ensure a gene is selected
    sub <- filter(tpm_df, GeneID == input$gene)        # filter for the chosen gene
    
    ggplot(sub, aes(x = Sample, y = TPM)) +            # ggplot chart
      geom_col(fill = 'aquamarine2') + 
      labs(                                            # chart description
        title = paste("Expression of", input$gene),
        x = "Sample",
        y = "TPM",
      ) +                                              # selecting theme and position of labels
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
})
