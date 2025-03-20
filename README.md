# Biostatistics Data Analysis Shiny App
This is an R Shiny app designed for basic biostatistics data analysis. It allows users to upload a dataset, perform summary statistics, and visualize data using scatter plots, histograms, and boxplots. The app is user-friendly and includes error handling for invalid inputs.

## Features
- File Upload: Upload a CSV file containing your dataset.
- Summary Statistics: View summary statistics for a selected variable.
- Scatter Plot: Create scatter plots with an optional linear regression line.
- Histogram: Visualize the distribution of a selected variable.
- Boxplot: Create boxplots with an optional grouping variable.
- Error Handling: Provides user feedback for invalid inputs or errors.

## How to Use
1. Upload a Dataset:
   - The app accepts CSV files. Ensure your dataset is in the correct format.
   - Example dataset:
 
     Age, Weight, Height, Gender
     25, 70, 175, Male
     30, 80,  180, Female
     35, 85, 182, Male
     40, 90, 185, Female
     45, 95, 188, Male

2. Select Variables -
   - Choose variables for summary statistics, scatter plots, histograms, and boxplots.
   - For boxplots, you can optionally select a grouping variable.

3. View Outputs - 
   - Summary statistics are displayed in text format.
   - Plots are displayed in the main panel.

4. Error Handling -
   - If an invalid file or variable is selected, the app will display an error message.

## How to Run the App
1. Clone this repository to your local machine - 
   git clone https://github.com/PriyankaItagi/R-Shiny-App.git

2. Open the app.R file in RStudio or your preferred R environment.

3. Install the required R packages if you don't already have them:
install.packages("shiny")
install.packages("ggplot2")
install.packages("dplyr")

4. Run the app:
In RStudio, click the Run App button.
Alternatively, run the following command in the R console:
shiny::runApp("path/to/your/app.R")

