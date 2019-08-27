# Load data
raw_data <- read.csv('~/Downloads/201905312141.csv')

# Remove empty data
cpd_data <- subset(raw_data, survey.counselor_ratings_created_at != '')

# Remove test data
cutoff_day <- "2019-3-1"
cpd_data <- subset(cpd_data, as.Date(survey.counselor_ratings_created_at) > as.Date(cutoff_day))

# Drop empty client levels
cpd_data$clients__id <- droplevels(cpd_data$clients__id)

# Amount of sessions per client
sessions_per_client <- xtabs(~clients__id,data=cpd_data)
hist(sessions_per_client)
psych::describe(as.numeric(sessions_per_client))
