# Load the tidyverse package
library(tidyverse)
set.seed(12042018)

# Create tibbles for main and practice trials
main_words <- tibble(
  word = c("apple", "chair", "table", "grape", "plant",
           "water", "bread", "sugar", "train", "plane",
           "brush", "clock", "sweep", "swipe", "crane",
           "flame", "flock", "globe", "grind", "group",
           "haste", "heart", "honor", "judge", "laugh",
           "light", "liver", "mango", "mirth", "ocean",
           "onion", "piano", "pluck", "quart", "quiet",
           "quill", "quote", "ruler", "saint", "scary",
           "shine", "shred", "sleek", "sloth", "snack",
           "speak", "spork", "squat", "stare", "swoop"),
  type = "word",
  trial_type = "experimental"
)

main_nonwords <- tibble(
  word = c("blorf", "snibb", "plurt", "dramp", "flibb",
           "glorf", "prasp", "quibb", "trimp", "zworp",
           "brump", "clorb", "dworp", "florp", "grisp",
           "jwump", "klirp", "mlorp", "nrimp", "plasp",
           "qrump", "slurb", "twasp", "vlump", "wrump",
           "xlorp", "zrimp", "blasp", "dresp", "drisp",
           "frasp", "glasp", "hrump", "jlorp", "knasp",
           "lwump", "mrump", "nlorp", "prump", "qrasp",
           "skump", "trasp", "vlasp", "wrasp", "xrimp",
           "zlorp", "blump", "crasp", "dwasp", "flasp"),
  type = "nonword",
  trial_type = "experimental"
)

practice_words <- tibble(
  word = c("fruit", "brick", "climb", "drown", "elbow"),
  type = "word",
  trial_type = "practice"
)

practice_nonwords <- tibble(
  word = c("blarp", "snorp", "plimp", "drorp", "florp"),
  type = "nonword",
  trial_type = "practice"
)

# Combine all words and nonwords into one file
all_words = bind_rows(main_words, main_nonwords, practice_words, practice_nonwords) %>%
  rename("Word" = "word",
         "Word type" = "type")
write.csv(all_words, "all_words.csv", row.names = FALSE)

# Initialize an empty data frame to store demographic data
demographics_df <- data.frame(
  ID = integer(),
  age = integer(),
  language = integer()
)

# Function to simulate data for a single participant's trials
simulate_participant_data <- function(participant_id, age, language, n_trials = 50) {
  
  # Simulate reaction times and accuracy
  rt = rnorm(2 * n_trials + 10, mean = ifelse(language == 1, 500, 520), sd = 50)
  acc = rbinom(2 * n_trials + 10, 1, prob = ifelse(language == 1, 0.95, 0.93))
  acc = ifelse(acc == 1, "correct", "incorrect")
  
  # Sample stimuli for main trials
  sampled_words = sample_n(main_words, n_trials)
  sampled_nonwords = sample_n(main_nonwords, n_trials)
  
  # Combine into a data frame for main trials
  df_main = bind_rows(sampled_words, sampled_nonwords) %>% 
    mutate(
      ID = participant_id,
      accuracy = sample(acc, 2 * n_trials),
      rt = sample(rt, 2 * n_trials),
      trial_type = "experimental"
    ) %>% 
    select(word, ID, accuracy, rt, trial_type)
  
  # Randomize main trials
  df_main = df_main[sample(nrow(df_main)), ]
  
  # Sample stimuli for practice trials
  sampled_practice_words = sample_n(practice_words, 5)
  sampled_practice_nonwords = sample_n(practice_nonwords, 5)
  
  # Combine into a data frame for practice trials
  df_practice = bind_rows(sampled_practice_words, sampled_practice_nonwords) %>% 
    mutate(
      ID = participant_id,
      accuracy = sample(acc, 10),
      rt = sample(rt, 10),
      trial_type = "practice"
    ) %>% 
    select(word, ID, accuracy, rt, trial_type)
  
  # Combine practice and main trials
  df = bind_rows(df_practice, df_main)
  
  # Add trial_number column
  df = df %>% mutate(trial_number = row_number())
  
  # Introduce 5% missing data in rt and accuracy
  n_missing = floor(0.05 * nrow(df))
  missing_indices = sample(1:nrow(df), n_missing)
  df$rt[missing_indices] = NA
  df$accuracy[missing_indices] = NA
  
  # Write the data frame to a CSV file
  write.csv(df, paste0("participant_", participant_id, "_trials.csv"), row.names = FALSE)
}

# Simulate data for 100 participants
set.seed(12042018)  # for reproducibility

for (i in 1:100) {
  age = sample(18:35, 1)
  language = sample(1:2, 1)
  
  # Add demographic data to the demographics data frame
  demographics_df <- rbind(demographics_df, data.frame(ID = i, age = age, language = language))
  
  # Simulate trial data
  simulate_participant_data(i, age, language)
}

# Write the demographics data frame to a CSV file
write.csv(demographics_df, "participant_demographics.csv", row.names = FALSE)
