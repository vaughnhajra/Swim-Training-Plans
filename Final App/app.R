library(shiny)
library(plotly)
library(bslib)

overview_content_swimming <- "<h1>Welcome To Your Swim Training Companion</h1>

<h3>Overview</h3>

<p>Swim Training Plan is a comprehensive web application designed to streamline your swimming training experience. Whether you're a beginner looking to improve your skills or a seasoned swimmer aiming to enhance performance, this app has you covered.</p>

<h3>Why Online?</h3>

<p>Swim Training Plan was developed with one goal in mind: to make swimming training more accessible, personalized, and effective for everyone. We understand the challenges swimmers face in structuring their training programs, which is why we've created a user-friendly platform that provides tailored workout plans and resources.</p>

<h3>How Do I Use It?</h3>

<p>Using Swim Training Plan is simple and intuitive. Begin by entering your basic information. Based on this information, the app generates personalized training plans suited to your individual needs and goals.</p>

<h3>Do I have to Pay Anything?</h3>

<p>We believe that access to quality training resources should not be limited by financial barriers. By offering Swim Training Plan for free, we ensure that swimmers of all backgrounds can benefit from expertly crafted training programs, empowering them to reach their full potential in the water.</p>

<h3>Get Started Today!</h3>

<p>Explore the various tabs to access your daily workouts, training plans, intensity tracking, swimming drills, and more. Whether you're training for competition or simply looking to stay fit, Swim Training Plan is your ultimate companion in achieving your swimming goals.</p>
"

overview_daily_workout <- "
<h3>How to Get Workout</h3>

<p>To View Today's workout, click on the 'Get Workout' button to download your workout as a pdf. View it on your computer, phone, or print it out and take it to the pool!</p>

<h3>Overview</h3>

<p>There are three main components of a swim practice. Warm-up, the pre-set, and the main set. Warm up is a time to get your mind focusesd and your body ready to go. The pre-set (drills in this case) is designed to work on technique while preparing for the main set. The main set is the focus of the workout, often challenging and targeting different energy systems.</p>

<h3>Navigating a Practice.</h3>

<p>A recommended approach to going through a swim practice is to take it one set at a time. Warm up each day is the same, with it serving as an opportunity to both relax and focus on the upcoming set. Then, work through your drills at a pace that suits you (take as long as you need!). Take a couple of minutes before starting the main set, and try not to take excessive breaks during the main set.</p>

<h3>What are the intensity numbers?</h3>

<p>Think of intensity numbers as if they were gears on a five-speed bike, where 1 is the easiest (and slowest) and 5 is high intensity (and fast). Intensities 1 and 2 are typically used for warm-up and drills. Intensities 3 and 4 are for aerobic work and threshold training. Intensity 5 is a focus on speed and maximum effort.</p>

<h3>Can I swim and do other sports too?</h3>

<p>Yes! These training plans are designed to be simple and compliment other sports</p>
"

# Define UI for application
# Define UI function for application
ui <- function(request) {
  navbarPage(
    title = "Swim Training Plan",
    id = "nav",
    tabPanel("Overview", icon = icon("user"),
             sidebarLayout(
               sidebarPanel(
                 # Sidebar content (stays the same)
                 h3("Your Information"),
                 # Help text with pop-up modal
                 actionLink("help", "How is this used?"),
                 p(),
                 textInput("name_input", label = "Your first name:", value = ""),
                 sliderInput("age", "Age:",
                             min = 8, max = 18, value = 8, step = 1),
                 radioButtons("sex_input", label = "Sex Assigned at Birth:", choices = c("Male", "Female", "Prefer Not to Specify")),
                 # Help text with pop-up modal
                 h5("Base Interval ", actionLink("base_explanation", "(click for help)"),":"),
                 selectInput("base_interval_input", label = NULL, 
                             choices = c("1:00","1:05","1:10", "1:15", "1:20","1:25", "1:30", "1:35","1:40", "1:45", "1:50","1:55", "2:00"), selected = "1:30"),
                 bookmarkButton(),
                 helpText("Bookmark to Save Preferences")
               ),
               mainPanel(
                 tags$div(HTML(overview_content_swimming))
               )
             )
    ),
    tabPanel("Today's Workout", icon = icon("table"),
             sidebarLayout(
               sidebarPanel(
                 # Sidebar content
                 sliderInput("week", "Week Number",
                             min = 1, max = 10, value = 1, step = 1),
                 sliderInput("day", "Day Number",
                             min = 1, max = 5, value = 1, step = 1),
                 downloadButton('downloadReport', label = "Get Workout (PDF)")
               ),
               mainPanel(
                 tags$div(HTML(overview_daily_workout))
                 )
             )
    ),
    tabPanel("Training Plan", icon = icon("chart-bar"),
             mainPanel(
               # Main content for page 2
               uiOutput("startSwim"),
               plotlyOutput("plot3"),
               uiOutput("startSwim_caption"),
               uiOutput("volume"),
               plotlyOutput("plot1"),
               uiOutput("intensity"),
               plotlyOutput("plot2")
             )
    ),
    tabPanel("Swimming Drills", icon = icon("play"),
             mainPanel(
               # Main content for page 3
               uiOutput("videos")
             )
    )
  )
}

# Define server logic
server <- function(input, output) {
  
  output$volume <- renderUI({
    tags$div(
      tags$h3("Volume - What is it?"),
      tags$p("Tracking yardage is crucial for ensuring you're avoiding overtraining and gradually building into a program. By incrementally increasing volume, you minimize the risk of injury and allow your body to adapt progressively."),
      tags$p("Understanding the general flow of a season helps put volume into context. The initial weeks typically serve as an introduction phase, gradually ramping up as intensity increases. The middle chunk, where volume and intensity peak, is often the most challenging but also where you'll reap the most benefits in terms of performance improvement."),
      tags$p("During the taper phase, volume decreases while maintaining intensity. Tapering allows your body to recover fully from training stress, resulting in enhanced performance. It's during this period of rest and reduced volume that swimmers often achieve their peak performance levels.")
    )
  })
  
  output$intensity <- renderUI({
    tags$div(
      tags$h3("Intensity - Why track it?"),
      tags$p("Tracking intensity levels is essential for optimizing training effectiveness. It ensures that workouts are appropriately challenging without risking overexertion or burnout. Monitoring intensity helps tailor training to individual needs, whether focusing on skill development or endurance improvement."),
      tags$p("Intensity tracking provides valuable insights into performance progression over time. By systematically adjusting intensity levels, swimmers can target specific training adaptations, such as aerobic endurance, anaerobic capacity, or speed. This structured approach maximizes training outcomes and minimizes the risk of plateauing.")
    )
  })
  
  output$startSwim <- renderUI({
    tags$div(
      tags$h3("How Serious Should I Take Swimming?"),
      tags$p("Swimming varies for each individual. Encourage young swimmers to follow their passion in training. Data from elite 18-year-olds shows they typically start at 6, focus on just swimming at 10, specialize in a stroke or event at 14, and adopt two-a-days at 14."),
      tags$p("Remember, not every swimmer becomes a top 100 athlete and success is defined in many ways. It's wise for kids to explore multiple sports in elementary school. If they're passionate about swimming in middle school, they can start focusing more on it. High school may be the time to consider double practices while maintaining versatility."),
      tags$p("Here's a plot based on survey data from elite 18 year-old swimmers:")
    )
  })
  
  output$startSwim_caption <- renderUI({
    tags$div(
      tags$p("startAge is the age at which they started swimming. mainAge is when swimming became their 'main' sport. doublesAge is when the swimmers started two practices per day, and specializationAge is when they focused on a specific stroke or event type.")
    )
  })
  
  
  observeEvent(input$help, {
    showModal(
      modalDialog(
        title = "Your Information",
        HTML("<h3>First Name</h3>
             <p>Your first name is used for personalization for the daily workout.</p>
             <h3>Age</h3>
             <p>Your age is used to help calculate how often and intense workouts should be, based on existing research.</p>
             <h3>Sex Assigned at Birth</h3>
             <p>Research has shown that adolescents experience puberty at different times. In swimming, boys and girls develop at slightly different ages as they experience puberty. By controlling for biological sex, we can create the best plan for you!</p>
             <h3>Base Interval Selection</h3>
             <p>Base interval is designed to make your workouts tailored to your individual ability. To learn more about Base Interval, please click on the appropriate help section.</p>"),
        easyClose = TRUE,
        footer = NULL
      )
    )
  })
  
  observeEvent(input$base_explanation, {
    showModal(
      modalDialog(
        title = "Selecting your Base Interval",
        HTML("<h3>What Is a Base Interval?</h3>
             <p>Your base interval is used to calculate intervals for your swimmming training and workout information. By using this, we can program plans for swimmers of all levels!</p>
             <h3>What Interval is Best for Me?</h3>
             <p>Your base interval is typically the fastest time you could hold for 10 100s frestyle, with ten seconds of rest in-between each. To test this on your own, do a full warm up, have a clock or watch available, and keep track of your times for 10x100s freestyle with ten seconds of rest!</p>"),
        easyClose = TRUE,
        footer = NULL
      )
    )
  })
  
  output$downloadReport <- downloadHandler(
    filename = 'daily_workout.pdf',
    content = function(file) {
      # Get the path to the Rmd file within the shiny package directory
      src <- system.file("Daily_Workout.Rmd", package = "shiny")
      
      # Copy the Rmd file to the temp directory
      file.copy(src, 'Daily_Workout.Rmd', overwrite = TRUE)
      
      # Render the Rmd file
      id <- showNotification(
        "Creating Your PDF...", 
        duration = NULL, 
        closeButton = FALSE
      )
      on.exit(removeNotification(id), add = TRUE)
      
      library(rmarkdown)
      out <- render('Daily_Workout.Rmd', 
                    params = list(
                      day = input$day,
                      week = input$week,
                      name = input$name_input,
                      age = input$age,
                      base = input$base_interval_input
                      # Add more parameters as needed
                    ),
                    output_file = file, 
                    pdf_document()
      )
      file.rename(out, file)
    }
  )
  

  
  
  
  # Placeholder data for warmup
  output$warmup <- renderTable({
    warmup <- data.frame(
      Distance = c("2-300", "4x50", "4x50"),
      Interval = c("-", "1:10", "1:00"),
      Drill = c("Easy, warm up swim", "Kick, Choice", "Freestyle Pull"),
      Intensity = c(1, 2, 2)
    )
    warmup
  })
  
  # Placeholder data for drills
  output$drills <- renderTable({
    flyDrills <- data.frame(
      Distance = c("4x25", "3x25", "3x25", "2x25"),
      Interval = c("1:00", "0:45", "0:45", "1:00"),
      Drill = c("Flow Drill", "Single Arm Butterfly", "2-2-2 Butterfly", "Skate Drill"),
      Intensity = c(1, 2, 2, 2)
    )
    flyDrills
  })
  
  # Placeholder data for main set
  output$main <- renderTable({
    VO2max <- data.frame(
      Distance = c("4x25", "2x50", "10x50", "4x50"),
      Interval = c("1:00", "0:50", "1:30", "1:00"),
      Drill = c("Variable Sprint", "perfect technique", "Best Average", "recovery"),
      Intensity = c(4, 3, 5, 1)
    )
    VO2max
  })


  # Placeholder data
  df <- data.frame(Week = 1:10, Volume = c(10000, 15000, 20000, 25000, 27000, 28000, 29000, 30000, 20000, 15000))
  
  # Render Plot 1
  output$plot1 <- renderPlotly({
    # Create a bar plot with Plotly
    p <- plot_ly(df, x = ~Week, y = ~Volume, type = 'bar', hoverinfo = 'text',
                 text = ~paste("Week: ", Week, "<br>Volume: ", Volume, " yards")) %>%
      layout(title = "Example Training Plan: Total Volume",
             xaxis = list(title = "Week"),
             yaxis = list(title = "Total Volume (yards)"))
    
    # Return the plot
    p
  })
  
  output$plot2 <- renderPlotly({
    # Create a dataframe with placeholder data
    df <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSqerkoqOPTZBHynQZdYiQyegg6rNRAUXdUZ9h5HwTG3hP3Plv1I9qaYKE374ogZWqxMNeFgwOB6Ccp/pub?gid=0&single=true&output=csv")
    
    # Create the plot with Plotly
    p <- plot_ly(df, x = ~Day, y = ~Intensity,mode = 'lines+markers',
                 text = ~paste("Week: ", Week, "<br>Day: ", Day, "<br>Practice Type: ", Practice.Type)) %>%
      layout(title = "Example Intensity Progression Over Time",
             xaxis = list(title = "Day"),
             yaxis = list(title = "Intensity (%)"))
    
    # Return the plot
    p
  })
  
  output$plot3 <- renderPlotly({
    # Create data frame
    df_ages <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRPoE6xu1bzQSmx-cl2rEjLo5fvOK1xcgAI2fgyP7pWpHy2sRPXUZyT8bEgCgbFw-QgQYeTm3qx9m-D/pub?gid=0&single=true&output=csv")
    
    # Create an empty dataframe to store the cumulative percentages
    age_df_cumulative <- data.frame(age = 3:20)
    
    # Calculate the cumulative percentage of swimmers who have achieved each milestone at each age
    for (i in 1:ncol(df_ages)) {
      milestone <- colnames(df_ages)[i]
      age_counts <- table(cut(df_ages[[i]], breaks = c(3:21), right = FALSE))
      cumulative_percentages <- cumsum(age_counts) / sum(age_counts) * 100
      age_df_cumulative[milestone] <- cumulative_percentages
    }
    
    # Remove the 'subject' column if it exists
    if ("subject" %in% colnames(age_df_cumulative)) {
      age_df_cumulative <- age_df_cumulative[, -which(names(age_df_cumulative) == "subject")]
    }
    
    
    # Rearrange the columns of the dataframe
    age_df_cumulative <- age_df_cumulative[, c("age", "startAge", "mainAge", "doublesAge", "specializationAge")]
    
    # Convert the dataframe to long format for plotting
    age_df_long <- reshape2::melt(age_df_cumulative, id.vars = "age")
    
    
    # Plot the data with smoothed lines and shaded areas
    plot <- plot_ly(data = age_df_long, x = ~age, y = ~value, color = ~variable, type = 'scatter', mode = 'lines',
                    line = list(shape = "spline"), fill = 'tozeroy', legendgroup = ~variable)
    
    # Customize the plot
    plot <- plot %>% layout(title = "Cumulative Percentages by Age",
                            xaxis = list(title = "Age"),
                            yaxis = list(title = "Percentage at Benchmark"))
    
    # Display the plot
    plot
  })
  
  
  
  # Placeholder for list of YouTube videos
  output$videos <- renderUI({
    tags$div(
      tags$h3("Introduction"),
      p("Welcome to the Drills section! Click on each drill for a brief video explanation and example. Drills in this section use the same name as in your daily practice."),
      tags$h3("Freestyle Drills"),
      tags$ul(
        tags$li(a("Freestyle Catch-Up", href = "https://www.youtube.com/watch?v=qpczzwoXbyQ", target="_blank")),
        tags$li(a("One Arm Freestyle", href = "https://www.youtube.com/watch?v=6YXOT_HQtjM&list=PLc9Carp4PLBjhe0HmFB8AnLiHajgQh-dE&index=2", target="_blank")),
        tags$li(a("6-Kick Switch (Freestyle)", href = "https://www.youtube.com/watch?v=wBE0Dk1BE5s&list=PLc9Carp4PLBjhe0HmFB8AnLiHajgQh-dE&index=3", target="_blank")),
        tags$li(a("Closed Fist (Freestyle)", href = "https://www.youtube.com/watch?v=X6YRADCA4ps&list=PLc9Carp4PLBjhe0HmFB8AnLiHajgQh-dE&index=4", target="_blank"))
      ),
      tags$h3("Backstroke Drills"),
      tags$ul(
        tags$li(a("12-Kick Switch (Backstroke)", href = "https://www.youtube.com/watch?v=DjvJVIWKphE&list=PLY9EJgRqHRh5dtdljUM7oR0v-7uHmUEqn&index=3", target="_blank")),
        tags$li(a("3 Strokes, 12 Kicks", href = "https://www.youtube.com/watch?v=9s6Nn-yPtgE&list=PLY9EJgRqHRh5dtdljUM7oR0v-7uHmUEqn&index=4", target="_blank")),
        tags$li(a("Backstroke Catch-Up", href = "https://www.youtube.com/watch?v=a4AwwaKxk2Y&list=PLY9EJgRqHRh5dtdljUM7oR0v-7uHmUEqn&index=6", target="_blank")),
        tags$li(a("Double-Arm Backstroke", href = "https://www.youtube.com/watch?v=FoUJ6-WzvBk&list=PLY9EJgRqHRh5dtdljUM7oR0v-7uHmUEqn&index=7", target="_blank"))
      ),
      tags$h3("Breaststroke Drills"),
      tags$ul(
        tags$li(a("2-Kick, 1 Pull", href = "https://www.youtube.com/watch?v=mrW1QN44ZGQ", target="_blank")),
        tags$li(a("Streamline Kick", href = "https://www.youtube.com/watch?v=FSpu7sOOs-I&list=PLY9EJgRqHRh5E0pbo7ybNO9PofF_KQJGB", target="_blank")),
        tags$li(a("Breaststroke Pull, Freestyle Kick", href = "https://www.youtube.com/watch?v=-2-mdGviPHc&list=PLY9EJgRqHRh5E0pbo7ybNO9PofF_KQJGB&index=5", target="_blank")),
        tags$li(a("Breaststroke Sculling", href = "https://www.youtube.com/watch?v=coiVAKNdOBI", target="_blank"))
      ),
      tags$h3("Butterfly Drills"),
      tags$ul(
        tags$li(a("Flow Drill", href = "https://www.youtube.com/watch?v=miJL8ppnnlg&list=PLY9EJgRqHRh5zj4YE0SnKP6XKaTCjFXZg", target="_blank")),
        tags$li(a("Single Arm Butterfly", href = "https://www.youtube.com/watch?v=Zj77HGobUjI&list=PLY9EJgRqHRh5zj4YE0SnKP6XKaTCjFXZg&index=2", target="_blank")),
        tags$li(a("2-2-2 Butterfly", href = "https://www.youtube.com/watch?v=bBGd8ZcWgMU&list=PLY9EJgRqHRh5zj4YE0SnKP6XKaTCjFXZg&index=5", target="_blank")),
        tags$li(a("Skate Drill", href = "https://youtu.be/v1DE_Q7oj6A?si=zLgk3mWjPA_7Lpan&t=46", target="_blank"))
        
      ),
      br(),
      tags$h4("Aknowledgements"),
      p("Thank you to the Swimming YouTube Channels who have been kind enough to share drills and explanations to the public!")
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server, enableBookmarking = "url")
