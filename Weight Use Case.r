install.packages("shiny")
install.packages("plotly")
library(shiny)
library(plotly)
# Define UI
ui <- fluidPage(
  titlePanel("Calculator"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("method", "Select a parameter to calculate", choices = c('BMI', 'BMR'), selected = 'BMI')
    ),
    mainPanel(
      uiOutput('calculator_ui')
    )
  )
  
)
# Define server logic
server <- function(input, output, session) {
  output$calculator_ui <- renderUI({
    if (input$method == 'BMI') {
      tagList(
        titlePanel("BMI Calculator"),
        sidebarLayout(
          sidebarPanel(
            numericInput('weight', 'Enter your weight (in kg): ', value = 0),
            numericInput('height', 'Enter your height (in cm): ', value = 0),
            actionButton("calculate_bmi", "Calculate BMI")
          ),
          mainPanel(
            plotlyOutput("bmi_speedometer"),
            textOutput('bmi_output')
          )
        )
      )
    } else {
      tagList(
        titlePanel("BMR Calculator"),
        sidebarLayout(
          sidebarPanel(
            sliderInput("age", "Select your age", min = 15, max = 85, value = 25, step = 1),
            selectInput("gender", "Gender:", choices = c("Male", "Female")),
            numericInput("height", "Height (cm):", value = 170),
            numericInput("weight", "Weight (kg):", value = 70),
            selectInput("Activity","Select your activity level", choices = c("Sedentary: little or no exercise","Exercise 1-3 times/week","Exercise 4-5 times/week","Daily exercise or intense exercise 3-4 times/week","Intense exercise 6-7 times/week","Very intense exercise daily or physical job")),
            numericInput("calorie_intake","Enter your daily average calorie intake",value = 2000),
            actionButton("calculate_bmr", "Calculate BMR")
          ),
          mainPanel(
            plotlyOutput("bmr_speedometer"),
            textOutput("bmr_output"),
            
            textOutput("act_output"),
            textOutput("cal_output")
          )
        )
      )
    }
  })
  observeEvent(input$calculate_bmi, {
    cal_bmi <- input$weight / ((input$height / 100) ^ 2)
    output$bmi_output <- renderText({
      if (cal_bmi <= 24.9) {
        if (cal_bmi < 18.5) {
          paste('You are underweight. You need some gains!','Your BMI is:', cal_bmi)
        } else {
          paste('You have a perfectly normal weight!','Your BMI is:', cal_bmi)
        }
      } else {
        paste('You are overweight. You definitely need some workout!', 'Your BMI is:', cal_bmi)
      }
    })
    output$bmi_speedometer <- renderPlotly({
      plot_ly(
        type = "indicator",
        mode = "gauge+number",
        value = cal_bmi,
        domain = list(x = c(0, 1), y = c(0, 1)),
        gauge = list(
          axis = list(range = c(0, 40)),
          bar = list(color = "black"),
          bgcolor = "white",
          borderwidth = 2,
          bordercolor = "gray",
          steps = list(
            list(range = c(0, 18.5), color = "#FF4040"),
            list(range = c(18.5, 24.9), color = "lightgreen"),
            list(range = c(24.9, 40), color = "brown")
          )
        )
        
      )
    })
  })
  observeEvent(input$calculate_bmr, {
    age <- input$age
    gender <- input$gender
    height <- input$height
    weight <- input$weight
    # Calculate BMR based on Mifflin-St Jeor equation
    if (gender == "Male") {
      bmr <- 10 * weight + 6.25 * height - 5 * age + 5
    } else {
      bmr <- 10 * weight + 6.25 * height - 5 * age - 161
    }
    output$bmr_speedometer <- renderPlotly({
      plot_ly(
        type = "indicator",
        mode = "gauge+number",
        value = bmr,
        domain = list(x = c(0, 1), y = c(0, 1)),
        gauge = list(
          axis = list(range = c(0, 4000)),
          bar = list(color = "black"),
          bgcolor = "white",
          borderwidth = 2,
          bordercolor = "gray",
          steps = list(
            list(range = c(0, 1000), color = "brown"),
            list(range = c(1000, 2000), color = "red"),
            list(range = c(2000, 3000), color = "lightgreen"),
            list(range = c(3000, 4000), color = "darkgreen")
          )
        )
      )
    })
    output$bmr_output <- renderText({
      
      paste("Your Basal Metabolic Rate (BMR) is:", round(bmr, 2), "calories/day")
    })
    output$act_output = renderText({
      if(input$Activity == "Sedentary: little or no exercise"){
        paste(" Daily calorie needs : 2060 calories/day")
      }
      else if(input$Activity == "Exercise 1-3 times/week"){
        paste("Daily calorie needs : 2207 calories/day")
      }
      else if(input$Activity == "Exercise 4-5 times/week"){
        paste("Daily calorie needs : 2351 calories/day")
      }
      else if(input$Activity == "Daily exercise or intense exercise 3-4 times/week"){
        paste("Daily calorie needs : 2488 calories/day")
      }
      else if(input$Activity == "Intense exercise 6-7 times/week"){
        paste("Daily calorie needs : 2769 calories/day")
      }
      else{
        paste("Daily calorie needs : 3050 calories/day")
      }
    })
    output$cal_output = renderText({
      if(input$Activity == "Sedentary: little or no exercise"){
        needs = 2060;
        if(input$calorie_intake > needs){
          paste("You are consuming more calories than required.")
        }
        else{
          paste("You are in calorie deficit.You need to consume more calories!")
        }
      }
      else if(input$Activity == "Exercise 1-3 times/week"){
        needs = 2207;
        if(input$calorie_intake > needs){
          paste("You are consuming more calories than required.")
        }
        else{
          paste("You are in calorie deficit.You need to consume more calories!")
        }
        
      }
      else if(input$Activity == "Exercise 4-5 times/week"){
        needs = 2351;
        if(input$calorie_intake > needs){
          paste("You are consuming more calories than required.")
        }
        else{
          paste("You are in calorie deficit.You need to consume more calories!")
        }
      }
      else if(input$Activity == "Daily exercise or intense exercise 3-4 times/week"){
        needs = 2488;
        if(input$calorie_intake > needs){
          paste("You are consuming more calories than required.")
        }
        else{
          paste("You are in calorie deficit.You need to consume more calories!")
        }
      }
      else if(input$Activity == "Intense exercise 6-7 times/week"){
        needs = 2769;
        if(input$calorie_intake > needs){
          paste("You are consuming more calories than required.")
        }
        else{
          paste("You are in calorie deficit.You need to consume more calories!")
        }
      }
      else{
        needs = 3050;
        if(input$calorie_intake > needs){
          paste("You are consuming more calories than required.")
        }
        else{
          paste("You are in calorie deficit.You need to consume more calories!")
        }
      }
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)

