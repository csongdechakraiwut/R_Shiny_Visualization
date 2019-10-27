library(dplyr)
library(ggplot2)
library(plotly)
library(shinydashboard)


# Call the data table
df<- read.csv("./kickstarter_cleaned-data.csv", stringsAsFactors = FALSE)



##Overview Page
cat_overview<-df%>% select(binary_state)%>%group_by(binary_state)%>%summarise(count=n())

##Category Page

cat_successful_main<- df %>% select(category_slug,binary_state)%>%filter(binary_state=='successful')%>%group_by(category_slug) %>% summarise(count=n())
cat_successful_main$ratio1<-round((cat_successful_main$count/173721)*100)

cat_failed_main<- df %>% select(category_slug,binary_state)%>%filter(binary_state=='failed')%>%group_by(category_slug)%>% summarise(count=n())
cat_failed_main$ratio2<-round((cat_failed_main$count/257217)*100)

## Filter no 0 from goal_usd and avg_per backer

df_o<-df %>%  filter(avg_per_backer!=0 & goal_usd !=0)

# Supporter Analysis Page

scatter_main<- df_o %>% select(avg_per_backer,binary_state,days_to_deadline,binary_state)
scatter_successful_main<- df_o %>% select(avg_per_backer,binary_state,days_to_deadline) %>% filter(binary_state=='successful')
scatter_failed_main<- df_o %>% select(avg_per_backer,binary_state,days_to_deadline) %>% filter(binary_state=='failed')

# Requested Goal Analysis

goal<-df_o %>% select(goal_usd,days_to_deadline,binary_state)
goal_sucessful<-df_o %>% select(goal_usd,days_to_deadline,binary_state) %>%  filter(binary_state=='successful')
goal_failed<-df_o %>% select(goal_usd,days_to_deadline,binary_state) %>%  filter(binary_state=='failed')


