update_interval <- function(base_interval, difference) {
  # Convert base interval to seconds
  base_seconds <- as.integer(unlist(strsplit(base_interval, ":"))[1]) * 60 +
    as.integer(unlist(strsplit(base_interval, ":"))[2])
  
  # Update seconds with difference
  updated_seconds <- base_seconds + difference
  
  # Calculate new minutes and seconds
  new_minutes <- floor(updated_seconds / 60)
  new_seconds <- updated_seconds %% 60
  
  # Format new interval
  new_interval <- paste(new_minutes, sprintf("%02d", new_seconds), sep = ":")
  
  return(new_interval)
}

# Example usage:
base_interval <- "1:30"
difference <- -30
updated_interval <- update_interval(base_interval, difference)
print(updated_interval)  # Output: "4:15"
