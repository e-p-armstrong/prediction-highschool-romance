library(tidyverse)
library(tidymodels)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# Data source: https://archive.ics.uci.edu/ml/datasets/student+performance
df_init <- read_delim("student/student-mat.csv",delim=";")

df
df <- select(df_init, romantic, freetime, goout, G3,)
filter(df, romantic == "yes") # There's a good number of normies, ~ 1/3. Aim 
                              # for above 75% accuracy.
                              # G3 is out of 20

df <- mutate(df, romantic = ifelse(romantic == "yes", 1, 0))

group_by(df,romantic) |> summarize(count = n())
132/395

split <- initial_split(df, prop=0.75, strata = romantic)
df_train <- training(split)
df_train
df_test <- testing(split)
df_test

write_delim(df, file = "student/student-mat-clean.csv",delim = ",")
write_delim(df_train, file = "student/student-mat-clean-train.csv",delim = ",")
write_delim(df_test, file = "student/student-mat-clean-test.csv",delim = ",")

# For decision tree, categorical
df_2 <- select(df_init, romantic, freetime, studytime, higher, famrel, traveltime, Pstatus, goout, G3, activities, health)
df_2 <- mutate(df_2, romantic = ifelse(romantic == "yes", 1, 0))
df_2 <- mutate(df_2, higher = ifelse(higher == "yes", 1, 0))
df_2 <- mutate(df_2, activities = ifelse(activities == "yes", 1, 0))
df_2
df_2 <- mutate(df_2, across(everything(), as.character))

df_2

split_2 <- initial_split(df_2, prop=0.75, strata = romantic)
df_train_2 <- training(split_2)
df_train_2
df_test_2 <- testing(split_2)
df_test_2

write_delim(df_2, file = "student/student-mat-clean-dt.csv",delim = ",")
write_delim(df_test_2, file = "student/student-mat-clean-dt-test.csv",delim = ",")
write_delim(df_train_2, file = "student/student-mat-clean-dt-train.csv",delim = ",")

ggplot(df,aes(x = G3, color = as.factor(romantic))) +
  geom_histogram() +
  labs(x = "Grades/20 (higher = better)", y = "Count", color = "Has a romantic relationship? 0 = no")
