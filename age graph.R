library(plotly)

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
