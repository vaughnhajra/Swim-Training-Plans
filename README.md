# Creating Optimized Swimming Training Plans
**by: Vaughn Hajra - Spring, 2024**

Seminar in Scientific Computing, Kenyon College (COMP 401)

Link to Web Application: [bit.ly/swim_training](bit.ly/swim_training)


# Running the App Locally & Editing Code

# Project Overview
Figures mentioned in this section are display below the overview section.

## Project Objectives & Background

#### Project Objectives:

1. Determine what factors are important for developing age group swimmers, based on survey data of elite 18-year- old swimmers
2. Develop a free, online web application for individuals to create personalized training plans using R Shiny

#### Project Background:

This project has two components: first, to uncover the factors driving swimmers to elite status by age 18, and second, to translate these findings into practical training plans for younger swimmers. Through analysis of survey responses and coach input, the project identifies elements that contribute to success in competitive swimming. A major component of the project is the development of an accessible R Shiny web application, offering free access to tailored workout plans. These plans are personalized based on individual skill level and biological factors, making quality training more widely available within the swimming community.

## Web Application Overview:

• Four main pages are used to create the website (*Overview*, *Daily Workout*, *Training Plan*, *Drills*)

• ***Overview:*** Takes user information and describes the goals of the project. Also allows for easy bookmarking for later via a custom hyperlink.

• ***Today’s Workout:*** Allows users to download their daily practice as a pdf. Also includes text that gives advice on navigating a swim workout.

• ***Training Plan:*** Provides charts and descriptions of elite swimmers’ timelines (Figure 4), example volume (Figure 2) and example intensity (Figure 3).

• ***Swimming Drills:*** Provides links to video explanations and examples of all drills used in the training program.

## Project Methods

• R studio and shinyapps.io were used for shiny app development and deployment (coding was done in HTML and R)

• Survey data of 40 top-100 swimmers (at age 18) was used to identify key indicators of success

• R Markdown (using knitr) and custom parameters (calculated with user inputs) are used to create daily PDF practices for swimmers

## Project Conclusions

• The Data from elite 18-year-olds show that they typically start swimming at age six, focus on just swimming at ten, specialize in a stroke or event at 14, and adopt two-a-days at 14. (Figure 4, based on survey)

• Five practices per week over a ten-week program are created. Specific practice recommendations are Threshold, Aerobic, VO2 Max, Recovery, and Individual Medley. These practices aim to improve general swimming ability. (coach input)

## Discussion & Future Improvements

• A pilot testing program would be both useful and valuable for improving the quality of practices.

• There currently is no event/stroke specialization included, and this would be an improvement for high school swimmers.

• A future project could create a package to easily manipulate training intervals in R.

## Acknowledgements & References

• Thank you to Kosuke Kojima providing the survey data used in this project.

• Thank you to the computing seminar at Kenyon College for advice and feedback!

• Source for Equity Considerations:

• “Segregation & Swimming Timeline in the United States.” Portland Center Stage, 6
Oct. 2022, www.pcs.org/features/segregation-swimming-timeline-in-the-united- states#:~:text=1920%2D1940%3A%20Cities%20across%20the,of%20pools%20in%2 0Washington%2C%20D.C.

# Figures 

<img width="1045" alt="image" src="https://github.com/vaughnhajra/comp401/assets/33579452/cd62bd13-12fe-4222-a467-4085af3f2d3d">

Figure 1: Web Application Homepage

<img width="591" alt="image" src="https://github.com/vaughnhajra/comp401/assets/33579452/4f4b73d7-e779-4ea3-8962-ce762eba137b">

Figure 2: Example Training Plan Volume

<img width="663" alt="image" src="https://github.com/vaughnhajra/comp401/assets/33579452/a515888d-b90a-44e8-a490-3ad07c500e5a">

Figure 3: Example Training Plan Intensity over Time

<img width="954" alt="image" src="https://github.com/vaughnhajra/comp401/assets/33579452/0b75661c-1dcf-456d-a60e-6eb76246a9e5">

Figure 4: Cumulative Percentages of Elite Swimmer Milestones by Age
