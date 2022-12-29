library(tidyverse)
library(tidymodels)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
df <- read_delim("student/student-mat.csv",delim=";")
df
df <- select(df, romantic, studytime, freetime, goout, absences,G3)
filter(df, romantic == "yes") # There's a good number of normies, ~ 1/3. Aim 
                              # for above 75% accuracy.

df <- mutate(df, ifelse(romantic == "yes", 1, 0))
