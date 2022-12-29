library(tidyverse)
library(tidymodels)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# Data source: https://archive.ics.uci.edu/ml/datasets/student+performance
df <- read_delim("student/student-mat.csv",delim=";")

df
df <- select(df, romantic, studytime, freetime, goout, absences,G3)
filter(df, romantic == "yes") # There's a good number of normies, ~ 1/3. Aim 
                              # for above 75% accuracy.
                              # G3 is out of 20

df <- mutate(df, romantic = ifelse(romantic == "yes", 1, 0))
df

split <- initial_split(df, prop=0.75, strata = romantic)
df_train <- training(split)
df_test <- testing(split)
df_test
write_delim(df, file = "student/student-mat-clean.csv",delim = ",")
write_delim(df_train, file = "student/student-mat-clean-train.csv",delim = ",")
write_delim(df_test, file = "student/student-mat-clean-test.csv",delim = ",")

ggplot(df,aes(x = G3, color = as.factor(romantic))) +
  geom_histogram() +
  labs(x = "Grades/20 (higher = better)", y = "Count", color = "Has a romantic relationship? 0 = no")
