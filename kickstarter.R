library(dplyr)
library(ggplot2)
library(plotly)


#rm(list = ls())

df<- read.csv("./kickstarter_cleaned-data.csv", stringsAsFactors = FALSE)

View(df)

# Overview Section:

cat_overview<-df%>% select(binary_state)%>%group_by(binary_state)%>%summarise(count=n())


cat_successful_main<- df %>% select(category_slug,binary_state)%>%filter(binary_state=='successful')%>%group_by(category_slug) %>% summarise(count=n())
cat_successful_main$ratio1<-round((cat_successful_main$count/173721)*100)
View(cat_successful_main)

#cat_successful_sub<- df %>% select(category_slug,category_name,binary_state)%>%filter(binary_state=='successful')%>%group_by(category_name)

cat_failed_main<- df %>% select(category_slug,binary_state)%>%filter(binary_state=='failed')%>%group_by(category_slug)%>% summarise(count=n())
cat_failed_main$ratio2<-round(((cat_failed_main$count/257217)*100))
View(cat_failed_main)
#cat_failed_sub<- df %>% select(category_slug,category_name,binary_state)%>%filter(binary_state=='failed')%>%group_by(category_name)



## Pie Graph (Successful/Unsuccessful)

cat_overview_g <- plot_ly(cat_overview, labels = ~binary_state, values = ~count, type = 'pie') %>%
  layout(title = 'Kickstarter Success Rates Overview',
         xaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = FALSE))

cat_overview_g

unique(df$category_slug)
unique(df$category_name)

## Bar Graph
##>> For the subcategory - I will have a selectbar to sort out again. 

cat_successful_main_bar<-ggplot(data=cat_successful_main, aes(x=reorder(category_slug,ratio1), y=ratio1)) +
  geom_bar(stat="identity", position="dodge",fill='red4',color='orange')+
  xlab("Category") +ylab("Ratio") +theme_bw() +ggtitle("Successsful by Category")

cat_successful_main_bar

#cat_successful_sub_bar<-ggplot(data = cat_successful_sub,aes(x = category_name)) +
#  geom_bar(aes(fill = category_name))+ylab("Counts") +ggtitle("Successful by Subcatergory")+
#  scale_fill_discrete(name = "Subcategory")

#cat_successful_sub_bar

cat_failed_main_bar<-ggplot(data=cat_failed_main, aes(x=reorder(category_slug,ratio2), y=ratio2)) +
  geom_bar(stat="identity", position="dodge",fill='red4',color='orange')+
  xlab("Category") +ylab("Ratio") +theme_bw() +ggtitle("Failed by Category")

cat_failed_main_bar

#cat_failed_sub_bar<-ggplot(data = cat_failed_sub,aes(x = category_name)) +
#  geom_bar(aes(fill = category_name))+ylab("Counts") +ggtitle("failed by Subcatergory")+
#  scale_fill_discrete(name = "Subcategory")
#cat_failed_sub_bar


## radar Chart Category

  ## Successful

cat_successful_radar <- plot_ly(
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

cat_successful_radar

  ##failed
cat_failed_radar <- plot_ly(
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

cat_failed_radar

## Overall
cat_successful_failed_g<- plot_ly(
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

cat_successful_failed_g
names(df)
## Filter no 0 from goal_usd and avg_per backer

df_o<-df %>%  filter(avg_per_backer!=0 & goal_usd !=0)


## Scatter Plot (Day to deadline-avg per backers)

scatter_main<- df_o %>% select(avg_per_backer,binary_state,days_to_deadline,binary_state)
scatter_successful_main<- df_o %>% select(avg_per_backer,binary_state,days_to_deadline) %>% filter(binary_state=='successful')
scatter_failed_main<- df_o %>% select(avg_per_backer,binary_state,days_to_deadline) %>% filter(binary_state=='failed')

#Main Scatter Plot

scatter_main_g <- plot_ly(data = scatter_main, x = ~days_to_deadline, y = ~avg_per_backer, color = ~binary_state, colors = "Set1")%>% 
  layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Average Fund per Supporter ($)"))
scatter_main_g

# Successful Scatter Plot

scatter_successful_main_g <- plot_ly(data = scatter_successful_main, x = ~days_to_deadline, y = ~avg_per_backer) %>% 
  layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Average Fund per Supporter ($)"))
scatter_successful_main_g

# Failed _Scatter Plot

scatter_failed_main_g <- plot_ly(data = scatter_failed_main, x = ~days_to_deadline, y = ~avg_per_backer)%>% 
  layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Average Fund per Supporter ($)"))
scatter_failed_main_g

## Correlation between day since the first launched to goal($)

goal<-df_o %>% select(goal_usd,days_to_deadline,binary_state) %>% filter(goal_usd != 0)
goal_sucessful<-df_o %>% select(goal_usd,days_to_deadline,binary_state) %>%  filter(binary_state=='successful'&goal_usd!=0)
goal_failed<-df_o %>% select(goal_usd,days_to_deadline,binary_state) %>%  filter(binary_state=='failed'&goal_usd != 0)

goal_g <- plot_ly(data = goal, x = ~days_to_deadline, y = ~goal_usd, color = ~binary_state, colors = "Set1")%>% 
  layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Requested Goal (US$)"))

goal_g

names

goal_sucessful_g <- plot_ly(data = goal_sucessful, x = ~days_to_deadline, y = ~goal_usd)%>% 
  layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Requested Goal (US$)"))

goal_sucessful_g

goal_failed_g <- plot_ly(data = goal_sucessful, x = ~days_to_deadline, y = ~goal_usd)%>% 
  layout(xaxis = list(title = "Days Since The First Launched"), yaxis = list(title = "Requested Goal (US$)"))
goal_failed_g

getwd()
