# Load dependencies
library(plotly)
library(dplyr)
library(tidyr)
library(tibble)
library(ggplot2)
library(reshape2)
library(knitr)

# SWD to source file location
# Read in Spotify Top Songs 2017 csv
tracks <- read.csv("data/toptracks2017.csv", stringsAsFactors = FALSE)

# Isolating each metric so I can examine each one individually first, I could have just used the tracks
# dataframe and targeted each column but I wasn't sure of what I would be doing later so I made
# them most manageable to begin with

# ARTISTS
artists <- select(tracks, name, artists)

# Tracks per artist
artist_popularity <- artists %>% select(artists) %>% count(artists) %>% arrange(-n)
total_artists <- nrow(artist_popularity)
top_artists <- artist_popularity %>% filter(n > 1)

# Top artists table
artist_col <- c("Artist Name","Number of Tracks")
kable(top_artists, row.names = NA, col.names = artist_col, caption = "Artists With More Than One Track")

# DANCEABILITY ---------------------------------------------------------------------------------------------
dance <- select(tracks, name, artists, danceability)

# Danceability histogram
dance_hist <- plot_ly(tracks, x = ~danceability) %>% 
                      add_histogram(name = "danceability")
plotly_build(dance_hist)

# Max and min
# Yes this could have just made a new dataframe for max and  min
danceability_max_track <- tracks[tracks$danceability == max(tracks$danceability), 2]
danceability_max_artist <- tracks[tracks$danceability == max(tracks$danceability), 3]
danceability_min_track <- tracks[tracks$danceability == min(tracks$danceability), ]

# ENERGY ---------------------------------------------------------------------------------------------------
energy <- select(tracks, name, artists, energy)

# Energy histogram
energy_hist <- plot_ly(energy, x = ~energy) %>% add_histogram(name = "energy")
plotly_build(energy_hist)

# Max and min
energy_max_track <- tracks[tracks$energy == max(tracks$energy), ]
energy_min_track <- tracks[tracks$energy == min(tracks$energy), ]

# KEY ------------------------------------------------------------------------------------------------------
key <- select(tracks, name, artists, key) 
key_names <- c("C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B")
key_count <- key %>% count(key)
key_count$key <- key_names

# Key bar chart
key_chart <- plot_ly(key_count, x = ~key, y = ~n, type = "bar")
plotly_build(key_chart)

# LOUDNESS -------------------------------------------------------------------------------------------------
loud <- select(tracks, name, artists, loudness)

# Loudness histogram
loud_hist <- plot_ly(loud, x = ~loudness) %>% add_histogram(name = "loudness")
plotly_build(loud_hist)

# Max and min
loudness_max_track <- tracks[tracks$loudness == max(tracks$loudness), ]
loudness_min_track <- tracks[tracks$loudness == min(tracks$loudness), ]

# MODE (1 Major or 0 Minor)  -------------------------------------------------------------------------------
mode_count <- tracks %>% count(mode)
total_major <- mode_count[mode_count$mode == 1, 2]
total_minor <- mode_count[mode_count$mode == 0, 2]
mode_names <- c("minor", "major")
mode_count <- mode_count %>% mutate(name = mode_names)

# Mode pie chart (One might even say...pie ala mode haha)
mode_pie <- plot_ly(mode_count, labels = ~name, values = ~n, type = "pie",
                    textposition = "inside",
                    textinfo = "label",
                    insidetextfont = list(color = '#FFFFFF')) %>%
  layout(title = "Modes of the Top Tracks",
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
plotly_build(mode_pie)

# SPEECHINESS ---------------------------------------------------------------------------------------------
speech <- select(tracks, name, artists, speechiness)

# Speechiness histogram
speech_hist <- plot_ly(speech, x = ~speechiness) %>% add_histogram(name = "speechiness")
plotly_build(speech_hist)

# Max and min
speechiness_max_track <- tracks[tracks$speechiness == max(tracks$speechiness), ]
speechiness_min_track <- tracks[tracks$speechiness == min(tracks$speechiness), ]

# ACOUSTICNESS ---------------------------------------------------------------------------------------------
acoustic <- select(tracks, name, artists, acousticness)

# Acousticness histogram
acoust_hist <- plot_ly(acoustic, x = ~acousticness) %>% add_histogram(name = "acousticness")
plotly_build(acoust_hist)

# Max and min
acoustic_max_track <- tracks[tracks$acoustic == max(tracks$acoustic), ]
acoustic_min_track <- tracks[tracks$acoustic == min(tracks$acoustic), ]

# INSTRUMENTALNESS — NEED TO WORK ON THIS ------------------------------------------------------------------
instrumental <- select(tracks, name, artists, instrumentalness)

# Instrumentalness histogram
instrumentalness_hist <- plot_ly(instrumental, x = ~instrumentalness) %>% 
                         add_histogram(name = "instrumentalness")
plotly_build(instrumentalness_hist)

# Instrumentalness bar
instrumentalness_bar <- plot_ly(instrumental, x = ~name, y = ~instrumentalness, type = "bar")
plotly_build(instrumentalness_bar)

# Instrumentalness count
instrumentalness_count <- instrumental %>% count(instrumentalness)

# Instrumentalness pie
instrumentalness_pie <- plot_ly(instrumentalness_count, labels = ~instrumentalness, values = ~n, type = 'pie') %>%
  layout(title = 'Instrumentalness of Top Tracks',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
plotly_build(instrumentalness_pie)

# Max and min
# instrumental_max_track <- tracks[tracks$instrumental == max(tracks$instrumental), 2]
# instrumental_max_artist <- tracks[tracks$instrumental == max(tracks$instrumental), 3]
# instrumental_min_track <- tracks[tracks$instrumental == min(tracks$instrumental), 2]
# instrumental_min_artist <- tracks[tracks$instrumental == min(tracks$instrumental), 3]

# LIVENESS -------------------------------------------------------------------------------------------------
liveness <- select(tracks, name, artists, liveness)

# Liveness histogram
liveness_hist <- plot_ly(liveness, x = ~liveness) %>% add_histogram(name = "liveness")
plotly_build(liveness_hist)

# Max and min
liveness_max_track <- tracks[tracks$liveness == max(tracks$liveness), ]
liveness_min_track <- tracks[tracks$liveness == min(tracks$liveness), ]

# VALENCE --------------------------------------------------------------------------------------------------
valence <- select(tracks, name, artists, valence)

# Valence histogram
valence_hist <- plot_ly(valence, x = ~valence) %>% add_histogram(name = "valence")
plotly_build(valence_hist)

# Max and min
valence_max_track <- tracks[tracks$valence == max(tracks$valence), ]
valence_min_track <- tracks[tracks$valence == min(tracks$valence), ]

# TEMPO ----------------------------------------------------------------------------------------------------
tempo <- select(tracks, name, artists, tempo)

# Tempo histogram
tempo_hist <- plot_ly(tempo, x = ~tempo) %>% add_histogram(name = "tempo")
plotly_build(tempo_hist)

# Max and min
tempo_max_track <- tracks[tracks$tempo == max(tracks$tempo), ]
tempo_min_track <- tracks[tracks$tempo == min(tracks$tempo), ]

#DURATION --------------------------------------------------------------------------------------------------
# Tracks by ascending duration
duration_asc <- arrange(tracks, duration_ms) %>% select(name, duration_ms)

# Add average duration in ms
duration_avg <- duration_asc %>% 
  summarise(name = "Average Length",
            duration_ms = mean(duration_ms)) %>% 
  bind_rows(duration_asc)

# Set factor level order for top-bottom ascending duration
duration_avg$y <- factor(duration_avg$name,
                         levels = unique(duration_avg$name)[order(duration_avg$duration_ms, 
                         decreasing = TRUE)])

# Alternatively, set row number to column called number to replace "~y"
# duration_asc <- rownames_to_column(duration_asc, "number")

duration1 <- plot_ly(duration_avg, type="bar",
              orientation="h",
              x = ~duration_ms,
              y = ~y)
plotly_build(duration1)

# Let's change some colors
# Add column to handle plotly colors, this might be a yikes
duration_avg$color <- "rgba(204,204,204,1)"
duration_avg[1, "color"] <- "rgba(222,45,38,0.8)"

# Make it into a list
c <- as.vector(duration_avg$color)
  
# Another chart, this time with the average
duration2 <- plot_ly(duration_avg, type="bar",
              orientation="h",
              x = ~duration_ms,
              y = ~y,
              marker = list(color = c))
plotly_build(duration2)

# Histogram perhaps
duration_hist <- plot_ly(tracks, x = ~duration_ms) %>% add_histogram(name = "duration_ms")
plotly_build(duration_hist)

# CHANGE TIME IN MS TO HUMAN TIME (minutes and seconds)
track_time <- tracks %>% mutate(duration_minutes = format(as.POSIXct(Sys.Date())+duration_ms/1000, "%M:%S"))

# Max and min
# duration_max_track <- tracks[tracks$duration_ms == max(tracks$duration_ms), ]
# duration_min_track <- tracks[tracks$duration_ms == min(tracks$duration_ms), ]
duration_max_track <- track_time[tracks$duration_ms == max(tracks$duration_ms), ]
duration_min_track <- track_time[tracks$duration_ms == min(tracks$duration_ms), ]

# TIME SIGNATURE  ------------------------------------------------------------------------------------------
time <- count(tracks, time_signature)

# Time pie (no pun this time, sorry)
time_pie <- plot_ly(time, labels = ~time_signature, values = ~n, type = 'pie') %>%
  layout(title = 'Modes of the Top Tracks',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
plotly_build(time_pie)

# Observing multiple histograms that have values between 0 and 1
subplot(
  dance_hist, energy_hist, valence_hist, acoust_hist,
  nrows = 4, shareX = TRUE
)

# DISTINCTNESS ---------------------------------------------------------------------------------------------
track_distinct <- summarise_all(tracks, funs(n_distinct))
track_distinct_df <- gather(track_distinct, "metric", "distinctness", 1:16)
dist_bar <- plot_ly(track_distinct_df, x = ~metric, y = ~ distinctness, type = "bar")
plotly_build(dist_bar)

# Scatterplot
t <- list(family = "sans-serif",
          size = 12,
          color = "black")
p1 <- plot_ly(tracks, type="scatter",
              mode="markers",
              x = ~energy,
              y = ~loudness,
              # size = ~speechiness,
              color = ~(-duration_ms),
              colors = "BuPu",
              text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Loudness - Energy",
         yaxis = list(zeroline = FALSE),
         xaxis = list(zeroline = FALSE),
         font = t)
plotly_build(p1)

# CORRELATION HEAT MAP -------------------------------------------------------------------------------------
track_num <- select(tracks, -id, -name, -artists)
qplot(x = Var1, y = Var2, data = melt(cor(track_num)), fill = value, geom = "tile")

# ED SHEERAN -----------------------------------------------------------------------------------------------
ed <- filter(tracks, grepl("Ed Sheeran", artists))
ed1 <- plot_ly(ed, x = ~name, y = ~danceability, type = "bar")
plotly_build(ed1)
ed_summary <- select(ed, danceability, energy, loudness, speechiness, acousticness, liveness,
                    valence, tempo, duration_ms) %>% 
                    summarise_all(funs(mean))
ed_bar <- gather(ed_summary, "metric", "average", 1:9)

# THE CHAINSMOKERS -----------------------------------------------------------------------------------------
tsc <- filter(tracks, grepl("The Chainsmokers", artists))
tsc1 <- plot_ly(tsc, x = ~name, y = ~danceability, type = "bar")
plotly_build(tsc1)
tsc_summary <- select(tsc, danceability, energy, loudness, speechiness, acousticness, liveness,
                     valence, tempo, duration_ms) %>% 
                     summarise_all(funs(mean))
tsc_bar <- gather(tsc_summary, "metric", "average", 1:9)

# ALL TRACK AVERAGES ---------------------------------------------------------------------------------------
track_avg <- select(tracks, danceability, energy, loudness, speechiness, acousticness, liveness,
                    valence, tempo, duration_ms) %>% 
                    summarise_all(funs(mean))
track_avg_bar <- gather(track_avg, "metric", "average", 1:9)

# Compare Ed, TSC, and all track averages
top_two_compare <- left_join(ed_bar, tsc_bar, by = "metric")
all_avg_compare <- left_join(top_two_compare, track_avg_bar, by = "metric")
avg_name <- c("metric", "Ed", "TSC", "All")
names(all_avg_compare) <- avg_name
all_avg_compareX <- slice(all_avg_compare, 1:7)
all_avg_compareX <- slice(all_avg_compareX, -3)

avg_compare <- plot_ly(all_avg_compareX, x = ~metric, y = ~Ed, type = 'bar', name = "Ed Sheeran") %>%
  add_trace(y = ~TSC, name = "The Chainsmokers") %>%
  add_trace(y = ~All, name = "All Track Average") %>% 
  layout(yaxis = list(title = 'Count'), barmode = 'group')
plotly_build(avg_compare)

# allSummary <- as.data.frame(summary(tracks)) %>% select(Var2, Freq)

# All value averages to CSV --------------------------------------------------------------------------------
write_averages <- all_avg_compare %>% 
                 select(metric, All) %>% 
                 spread(metric, All)
write.csv(write_averages, "avg2017.csv")
