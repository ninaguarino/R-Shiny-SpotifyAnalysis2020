library(data.table)
library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(reshape2)

setwd("~/Documents/The NYC Data Science Academy/Spotify - R Shiny App/SpotifyTopTracks2020Analysis")

# Opening CSV
spotifyTopTracks <- fread(file = './spotifyData.csv',header = TRUE, sep = "\t")
spotifyTopTracks

tikTokDanceTracks <- fread(file = './tikTokDancesData.csv',header = TRUE, sep = "\t")
tikTokDanceTracks

# New column: Top Track Count that measures how many tracks an artist has in the top hits
spotifyTopTracks$`Top Track Count` <- as.numeric(ave(spotifyTopTracks$`Artist Name`, spotifyTopTracks$`Artist ID`, FUN = length))
spotifyTopTracks


# Artists with 2+ Top Tracks
artistTopTrackCount <- spotifyTopTracks %>% select(`Artist Name`, `Top Track Count`) %>% arrange(spotifyTopTracks, desc(`Top Track Count`))
artistTopTrackCount <- artistTopTrackCount[order(-artistTopTrackCount$`Top Track Count`)]
artistTopTrackCount <- artistTopTrackCount[(artistTopTrackCount$`Top Track Count`) > 1]
artistTopTrackCount <- distinct(artistTopTrackCount)
artistTopTrackCount

# Artist Data Desc
artistsDesc <- spotifyTopTracks %>% select(`Artist Name`, `Artist Popularity`, `Artist Followers`)
artistsDesc <- artistsDesc[order(-artistsDesc$`Artist Popularity`)]
artistsDesc <- distinct(artistsDesc)
artistsDesc

# Track Data Desc
tracksDesc <- spotifyTopTracks %>% select(`Track Title`, `Artist Name`, `Artist Followers`, `Track Popularity`)
tracksDesc <- tracksDesc[order(-tracksDesc$`Track Popularity`)]
tracksDesc

# Top Data
top10Tracks <- head(tracksDesc,10)
top10Tracks
top10Artists <- head(artistsDesc,10)
top10Artists

# Avg Char Data
chars = spotifyTopTracks %>% select(9:20)
chars

avgChars <- data.frame(chars)
avgChars

# Cust Artist + Chars
custArtisChars = spotifyTopTracks %>% select(2, 9:20)
custArtisChars

custArtisChars <- data.frame(custArtisChars)
custArtisChars

# Col names for custom input plot
colNames = colnames(spotifyTopTracks)[c(9:19)]
colNames
