shinyServer(function(input, output, session) {
  output$spotifyTable <- DT::renderDataTable({
    DT::datatable(spotifyTopTracks, rownames = FALSE)
  })
  
  fontSty <- list(family = "inherit",
                  size = 14,
                  color = 'black')
  
  # Audio Characteristic Analysis
  output$audioPlot <- renderPlotly({
    plot_ly(
      spotifyTopTracks,
      x = ~ `Track Popularity`,
      y = ~ get(input$introduction),
      color =  ~ get(input$introduction),
      size =  ~ get(input$introduction),
      type = 'scatter',
      mode = 'markers',
      marker = list(sizemode = 'diameter'),
      hoverinfo = "text",
      hovertext = paste(
        "Track Title:",
        spotifyTopTracks$`Track Title`,
        "<br> Artist Name :",
        spotifyTopTracks$`Artist Name`
      )
    ) %>%
      layout(
        font = fontSty,
        xaxis = list(title = "Track Popularity"),
        yaxis = list(title = ~ input$introduction)
      ) %>%
      colorbar(title = input$introduction)
    
  })

  output$avgChar <- renderPlot({
    avgChars %>%
      gather() %>%
      ggplot(aes(value)) +
      facet_wrap( ~ key, scales = "free") +
      geom_density(fill = "#1DB954",
                   color = "black") + 
      labs(x = "Characteristic", y = "Density") + 
      theme(strip.text.x = element_text(size=16, family="Roboto Medium"))
  })
  
  output$customAudioPlot <- renderPlotly({
    plot_ly(
      spotifyTopTracks,
      x = ~ get(input$x),
      y = ~ get(input$y),
      #color =  ~ get(input$introduction),
      #size =  ~ get(input$introduction),
      type = 'scatter',
      mode = 'markers',
      marker = list(sizemode = 'diameter')
    ) %>%
      layout(
        font = fontSty,
        xaxis = list(title = ~ input$x),
        yaxis = list(title = ~ input$y)
      )
  })
  
  # Unique Artists with 2+ Tracks on Playlist
  output$artistTopTracks <- renderPlotly({
    plot_ly(
      artistTopTrackCount,
      x = ~ artistTopTrackCount$`Top Track Count`,
      y = ~ artistTopTrackCount$`Artist Name`,
      type = 'bar',
      color = I('#1DB954'),
      marker = list(sizemode = 'diameter'),
      hoverinfo = "text"
    ) %>%
      layout(
        font = fontSty,
        xaxis = list(
          title = "Track Count",
          categoryorder = "category ascending",
          categoryarray = artistTopTrackCount$`Top Track Count`
        ),
        yaxis = list(title = "Artist Name")
      )
  })
  
  # Artist Name vs Popularity + Follower Count
  output$artistPop <- renderPlotly({
    plot_ly(
      artistsDesc,
      x = ~ `Artist Popularity`,
      y = ~ `Artist Followers`,
      color = ~ `Artist Name`,
      size =  ~ `Artist Followers`,
      type = 'scatter',
      mode = 'markers',
      marker = list(sizemode = 'diameter')
    ) %>%
      layout(
        font = fontSty,
        xaxis = list(title = "Artist Popularity"),
        yaxis = list(title = "Artist Followers")
      )
  })
  
  # Artist Name vs Popularity + Follower Count
  output$followersToTrackPop <- renderPlotly({
    plot_ly(
      tracksDesc,
      x = ~ `Track Popularity`,
      y = ~ `Artist Followers`,
      color = I('#1DB954'),
      type = 'bar',
      mode = 'markers',
      marker = list(sizemode = 'diameter'),
      hoverinfo = "text",
      hovertext = paste(
        "Track Title:",
        spotifyTopTracks$`Track Title`,
        "<br> Artist Name :",
        spotifyTopTracks$`Artist Name`
      )
    )  %>%
      layout(
        font = fontSty,
        xaxis = list(title = "Track Popularity"),
        yaxis = list(title = "Artist Followers")
      )
  })
  
  # Most popular tracks on playlist
  output$top10Tracks <- renderPlotly({
    plot_ly(
      top10Tracks,
      x = ~ top10Tracks$`Track Popularity`,
      y = ~ top10Tracks$`Track Title`,
      type = 'bar',
      color = I('#1DB954'),
      marker = list(sizemode = 'diameter')
    ) %>%
      layout(
        font = fontSty,
        xaxis = list(title = "Track Popularity", categoryorder = "array", categoryarray = top10Tracks$`Track Popularity`),
        yaxis = list(title = "Track Title")
      )
  })
  
  # Most popular artists on playlist
  output$top10Artists <- renderPlotly({
    plot_ly(
      top10Artists,
      x = ~ top10Artists$`Artist Popularity`,
      y = ~ top10Artists$`Artist Name`,
      type = 'bar',
      color = I('#1DB954'),
      marker = list(sizemode = 'diameter')
    ) %>%
      layout(
        font = fontSty,
        xaxis = list(title = "Artist Popularity"),
        yaxis = list(title = "Artist Name")
        
      )
  })
  
  # Top Artist
  output$topArtist <- renderInfoBox({
    infoBox(h1(head(artistsDesc$`Artist Name`, 1)), h3("Top Artist"))
  })
  
  # Top Track
  output$topTrack <- renderInfoBox({
    infoBox(h1(head(tracksDesc$`Track Title`, 1)), h3("Top Track"))
  })
  
  # Avg Artist Popularity
  output$avgArtistPop <- renderInfoBox({
    charVals <-
      spotifyTopTracks %>% select(4, 8:20) %>% summarise(across(everything(), list(mean)))
    charVals <- as.data.frame(charVals)
    infoBox(h1(charVals[1]), h3("Average Artist Popularity"))
  })
  
  # Avg Track Popularity
  output$avgTrackPop <- renderInfoBox({
    charVals <-
      spotifyTopTracks %>% select(4, 8:20) %>% summarise(across(everything(), list(mean)))
    charVals <- as.data.frame(charVals)
    infoBox(h1(charVals[2]), h3("Average Track Popularity"))
  })
  
  # Avg Characteristics
  output$avgChars <- renderInfoBox({
    charVals <-
      spotifyTopTracks %>% select(4, 8:20) %>% summarise(across(everything(), list(mean)))
    charVals <- as.data.frame(charVals)
    infoBox(h3(charVals[`~ get(input$introduction)` + '_1']))
  })
  
  output$custArtistChar <- renderInfoBox({
    plot_ly(
      custArtisChars,
      x = ~ custArtisChars$`Artist.Name`,
      y = ~ get(input$charSelection),
      #color =  ~ get(input$introduction),
      #size =  ~ get(input$introduction),
      type = 'scatter',
      mode = 'markers',
      marker = list(sizemode = 'diameter')
    )
  })
  
# Custom / interactive correlation plot
  output$customPlot <- renderPlot({
  ggplot(spotifyTopTracks, aes_string(input$x1, input$y1)) + 
      geom_point(colour="#1DB954") + geom_smooth(method = lm, fullrange = TRUE, color = "black") +
      labs(x = input$x1, y = input$y1) +
      theme(strip.text.x = element_text(size=16, family="Roboto Medium"))
  })
  
  # LM of track popularity, artist popularity, follow count
  output$lmArtists <- renderPlot({  
  ggplot(spotifyTopTracks) + 
    geom_jitter(aes(spotifyTopTracks$`Artist Popularity`, spotifyTopTracks$`Track Popularity`), colour="black") + geom_smooth(aes(spotifyTopTracks$`Artist Popularity`, spotifyTopTracks$`Track Popularity`), method=lm, se=FALSE) +
    geom_jitter(aes(spotifyTopTracks$`Artist Followers`, spotifyTopTracks$`Track Popularity`), colour="#1DB954") + geom_smooth(aes(spotifyTopTracks$`Artist Followers`, spotifyTopTracks$`Track Popularity`), method=lm, se=FALSE) +
    labs(x = "Artist Popularity and Artist Follow Count", y = "Track Popularity") +
      theme(strip.text.x = element_text(size=46, family="Roboto Medium"))
  })
  
})
