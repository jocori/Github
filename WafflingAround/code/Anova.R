# Anova 

# Load libraries
library(readr) # to read in data
library(here) # so all collaborators can easily get data
library(ggplot2)
library(dplyr)

waffle <- read_delim(here("data", "WaffleDivorce.csv"), 
                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

## remove slavery columns :(
waffle <- waffle[,-c(11,13)]

waffle$Region <- NA

waffle <- waffle %>%
  mutate(Region = case_when(
    waffle$Location %in% c('Alabama', 'Arkansas', 'Kentucky',
                           'Louisiana', 'Mississippi', 'Oklahoma',
                           'Tennessee', 'Texas', 'West Virginia',
                           'Delaware', 'Florida', 'South Carolina',
                           'North Carolina', 'Maryland', 'Virginia', 'Georgia') ~ "South",
    waffle$Location %in% c('Maine', 'New Hampshire', 'Massachusetts',
                           'Rhode Island', 'Connecticut', 'New York',
                           'New Jersey', 'Pennsylvania',
                           'District of Columbia', 'Vermont') ~ "North East",
    waffle$Location %in% c('North Dakota', 'South Dakota', 'Minnesota',
                           'Nebraska', 'Kansas', 'Missouri',
                           'Wisconsin', 'Illinois', 'Indiana', 'Michigan',
                           'Ohio', 'Iowa') ~ "Midwest",
    waffle$Location %in% c('Alaska', 'Washington', 'Oregon',
                           'California', 'Hawaii', 'Idaho',
                           'Nevada', 'Montana', 'Wyoming', 'Colorado',
                           'New Mexico', 'Arizona', 'Utah') ~ "West"
  ))

# Reorder Category based on Group
waffle$Location <- factor(waffle$Location, levels = unique(waffle$Location))

ggplot(waffle, aes(x = Location, y = Divorce, fill = Region)) +
  geom_bar(stat = "identity", position = "dodge") +  # position = "dodge" separates the bars
  labs(title = "Bar Plot with Two Groups", x = "Category", y = "Value") +
  theme_minimal()


boxplot(waffle$Divorce ~ waffle$Region)
boxplot(waffle$WaffleHouses ~ waffle$Region)



lm.model <- lm(waffle$Divorce ~ waffle$Region)
summary(lm.model)

lm.model_two <- lm(waffle$WaffleHouses ~ waffle$Region)
summary(lm.model_two)
confint(lm.model_two)
