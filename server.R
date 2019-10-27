
shinyServer(function(input, output,session){
  

    ## Overview Page
  
    output$overview_rev <- renderPlotly({
        plot_ly(cat_overview, labels = ~binary_state, values = ~count, type = 'pie') %>%
        layout(title = '',
               xaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = FALSE))
     })
    ## Category Page
    
    output$rad_overall <- renderPlotly({
      
      plot_ly(
        type = 'scatterpolar',
        fill = 'toself'
      ) %>%
        add_trace(
          r = cat_successful_main$count,
          theta = cat_successful_main$category_slug,
          name = 'successful'
        ) %>%
        add_trace(
          r = cat_failed_main$count,
          theta = cat_failed_main$category_slug,
          name = 'Failed'
        ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,40000,1000)
            )
          )
        )
    })
    
    output$rad_successful <- renderPlotly({
    
      plot_ly(
        type = 'scatterpolar',
        r = cat_successful_main$count,
        theta = cat_successful_main$category_slug,
        fill = 'toself'
      ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,40000,2000)
            )
          ),
          showlegend = F
        )
    })
    
    output$tbl_successful <- renderPlot({
      
      ggplot(data=cat_successful_main, aes(x=reorder(category_slug,ratio1), y=ratio1)) +
        geom_bar(stat="identity", position="dodge",fill='red4',color='orange')+
        xlab("Category") +ylab("Ratio") +theme_bw() +ggtitle("Successsful by Category")
    })
    
    output$rad_failed <- renderPlotly({
      
      plot_ly(
        type = 'scatterpolar',
        r = cat_failed_main$count,
        theta = cat_failed_main$category_slug,
        fill = 'toself'
      ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,40000,2000)
            )
          ),
          showlegend = F
        )
    })
    
    output$tbl_failed <- renderPlot({
      
      ggplot(data=cat_failed_main, aes(x=reorder(category_slug,ratio2), y=ratio2)) +
        geom_bar(stat="identity", position="dodge",fill='red4',color='orange')+
        xlab("Category") +ylab("Ratio") +theme_bw() +ggtitle("Failed by Category")
    }) 
    
    ##Supporter Analysis
    output$supporter_main <- renderPlotly({
      plot_ly(data = scatter_main, x = ~days_to_deadline, y = ~avg_per_backer, color = ~binary_state, colors = "Set1")%>% 
        layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Average Fund per Supporter ($)"))
    })
    
    output$supporter_main_successful <- renderPlotly({
      plot_ly(data = scatter_successful_main, x = ~days_to_deadline, y = ~avg_per_backer) %>% 
        layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Average Fund per Supporter ($)"))
    })
    
    output$supporter_main_failed <- renderPlotly({
      plot_ly(data = scatter_failed_main, x = ~days_to_deadline, y = ~avg_per_backer)%>% 
        layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Average Fund per Supporter ($)"))
    })
    
    ##Goal Analysis
    
    output$goal_main <- renderPlotly({
      plot_ly(data = goal, x = ~days_to_deadline, y = ~goal_usd, color = ~binary_state, colors = "Set1")%>% 
        layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Requested Goal (US$)"))
    })
    
    output$goal_main_successful <- renderPlotly({
      plot_ly(data = goal_sucessful, x = ~days_to_deadline, y = ~goal_usd)%>% 
        layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Requested Goal (US$)"))
    })
    
    output$goal_main_failed <- renderPlotly({
      plot_ly(data = goal_sucessful, x = ~days_to_deadline, y = ~goal_usd)%>% 
        layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Requested Goal (US$)"))
    })
    
    # CONTACT
    output$contact = renderUI({
      HTML(paste("Paul Songdechakraiwut is a data scientist with a passion for data analytics, visualization,\
                 machine learning, statistical methodology, and programming. Primarily interested \
                 in helping businesses make data-driven, customer-centric decisions. <br><br>\
                 
                 <b>Contact Information</b>:<br>
                 Phone: (469) 463-6536<br>
                 Email: <a href = 'mailto:csongdechakraiwut@gmail.com'>csongdechakraiwut@gmail.com</a><br>
                 <a href = 'www.linkedin.com/in/csongdechakraiwut'>LinkedIn</a><br>"))
    })
})