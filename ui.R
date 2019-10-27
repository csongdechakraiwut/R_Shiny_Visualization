
shinyUI(dashboardPage(skin="green",
    dashboardHeader(title = "Kickstarter",
                    tags$li(a(href = 'https://www.kickstarter.com/',
                              img(src="Kickstarter-icon.png",height='20',width='20'),
                              title = "Link to the website"),
                            class = "dropdown")), 
    dashboardSidebar(
        
        sidebarMenu(
          ## Overview Page
            menuItem("Introduction", tabName = "Project_overview",icon=icon("adjust")),
            menuItem("Overview", tabName = "Overview",icon=icon("book-open")),
            menuItem("Category Analysis", tabName = "category",icon=icon("envira")),
            menuItem("Supporter Analysis", tabName = "supporter",icon=icon("street-view")),
            menuItem("Goal Analysis", tabName = "goal",icon=icon("bullseye")),
            menuItem("About Me", tabName = "contact",icon=icon("user-alt"))
                    ) 
                  ),
    dashboardBody(
      tabItems(
        ## Project Overview Page
        
        tabItem(tabName = "Project_overview",
                
                HTML('<center><img src="kickstarter_header.png" height="130" width="320"></center>'),
                h1(""),
                HTML('<center><img src="crowdfunding.png" height= "334" width="650"></center>'),
                
                h2(" What's crowdfunding?"),
                br(),
                h4("Crowdfunding is a form of crowdsourcing and alternative finance which is an alternative way of funding a project or venture by raising money from a large number of people, typically via the online platform.\  
                Even though there are many alternative practices of gathering money like mail order subscriptions, benefit evens and other method, the word crowfunding majorly cites to Internet platform to fund for a project.\
                Crowdfunding comprises with three main patities: the project initiator who comes up with the project or the idea to be funded, individuals or groups who want to support the idea, and a media platform that connects those parties together.
                Nowadays, crowdfunding has a huge in an online platform with varieties of projects and ideas that waiting to be supported ranging from non-profit donation to project ideas who seek to commercialize as a start-up entrepreneurial venture such as
                artistic and creative projects, medical expenses, travel, and community-oriented social entrepreneurship projects."),
                h6("Reference:", tags$h6(a(href="https://en.wikipedia.org/wiki/Crowdfunding","Wikipedia/Crowfunding"))),
                br(),
                h2(" Crowfundting Statistics"),
                HTML('<center><img src="crowdfunding_stat.png" height= "500" width="800"></center>'),
                h6("Reference:", align = "center", tags$h6(a(href="https://www.crowdfunding.com/","www.crowfunding.com [ Statistics]"),align = "center")),
                br(),
                h2(" R Shiny Project Motivation"),
                h3("Motivation:"),
                h4("An anlyternative of fundraising is enourmous. Lately, there are a lot of growing companies and campaigns from crowfunding sources. From www.crowfunding.com report, $10B have been raised through this channel with more than 90 millions supporters\
                   all togehter in 2019.Thus, the information that aboout the crowfunding is very interesting. to analyze in R Shiny Visualization Project."),
                h3("Data Source:"),
                h4("For this project, I got the dataset from www.Kaggle.com. The dataset distributor intended to know some insight findings of the data linking to a success rate of the project.
                   The blogger looked to observe 4 main factors that linked directly to a success rate of the project by the following:"),
                h4(" 1) Categorical Analysis"),
                h4(" 2) Supporter Analysis"),
                h4(" 3) Prospected Goal Analysis")

            ),
        
        #Tab for overview
        tabItem(tabName = "Overview",
                
                tabBox(
                  id = "overview_tab", width = 12,
                  
                  tabPanel("Overview",
                           h2("Kickstarter Success Rates Overview"),
                           column(12, fluidRow(box(plotlyOutput("overview_rev"), br(),
                                                  width = 900, height = "900px"))))
                  #height="900px"
                      )
                
                ),
        
        ## Category Page
        tabItem(tabName = "category",
                tabBox(
                  id = "category_tab", width = 12,
                  ## Overall by Category- Radar Chart
                  tabPanel("Overall",
                           h2("Kickstarter: Successful VS Unsucessful Project", align = "center"),
                          column(12, br(), fluidRow(plotlyOutput("rad_overall")))
                          ),
                  ## Successful
                  tabPanel("Sucessful Radar Chart",
                           h2("Successful Project by Categories:Radar Chart", align = "center"),
                          column(10, br(), fluidRow(plotlyOutput("rad_successful")))),
                          #column(12, br(), fluidRow(plotOutput("tbl_successful")))),
                  
                  tabPanel("Sucessful Bar Chart",
                           h2("Successful Project by Categories:Bar Chart", align = "center"),
                           #column(10, br(), fluidRow(plotlyOutput("rad_successful"))),
                           column(12, br(), fluidRow(plotOutput("tbl_successful")))),
                  
                  #Unsucessful
                  tabPanel("Failed Radar Chart",
                           h2("Unsucessful Project by Categories:Radar Chart", align = "center"),
                          column(10, br(), fluidRow(plotlyOutput("rad_failed")))),
                          #column(12, br(), fluidRow(plotOutput("tbl_failed")))),
                  
                  tabPanel("Failed Bar Chart",
                           h2("Unsucessful Project by Categories:Bar Chart", align = "center"),
                           #column(10, br(), fluidRow(plotlyOutput("rad_failed"))),
                           column(12, br(), fluidRow(plotOutput("tbl_failed")))),
                  
                  height = "1000px"
                      )),
        
        ## Suppoerter Analysis 
        tabItem(tabName = "supporter",
                tabBox(
                  id = "supporter_tab", width = 12,
                  ## Main Supporter Analysis
                  tabPanel("Overall",
                           h2("Supporter Analysis", align = "center"),
                           column(12, br(), fluidRow(plotlyOutput("supporter_main")))),
                  tabPanel("Successful Project",
                           h2("Supporter Analysis: Successful Project", align = "center"),
                           column(12, br(), fluidRow(plotlyOutput("supporter_main_successful")))),
                  tabPanel("Unsucessful Project",
                           h2("Supporter Analysis: Unsucessful Project", align = "center"),
                           column(12, br(), fluidRow(plotlyOutput("supporter_main_failed")))),
                  height = "4200px"         
                )),
        
        ## Goal Analysis 
        tabItem(tabName = "goal",
                tabBox(
                  id = "goal_tab", width = 12,
                  ## Main goal Analysis
                  tabPanel("Overall",
                           h2("Goal Analysis", align = "center"),
                           column(12, br(), fluidRow(plotlyOutput("goal_main")))),
                  tabPanel("Successful Project",
                           h2("Supporter Analysis: Successful Project", align = "center"),
                           column(12, br(), fluidRow(plotlyOutput("goal_main_successful")))),
                  tabPanel("Unsucessful Project",
                           h2("Supporter Analysis: Unsucessful Project", align = "center"),
                           column(12, br(), fluidRow(plotlyOutput("goal_main_failed")))),
                  height = "4200px"         
                )),
                           
        
        ## Contact
        tabItem(tabName = "contact",
                h2("Blogger Infomation:"),
                column(12,
                      box(htmlOutput("contact"), width = 12))
                )#,
        
              )
    
            )
          )
        )
      