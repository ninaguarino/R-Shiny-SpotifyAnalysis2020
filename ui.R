library(shiny)
library(shinythemes)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)


ui <- fluidPage(
    theme = shinytheme("journal"),
    
    tags$head(
        tags$style(
            HTML(".navbar .navbar-nav {float: right; }"),
            HTML(".nav-tabs>li>a {font-size: 18px; font-family: Calibri;} "),
            HTML(
                ".tabPanel .navbar-default .navbar-inner .navbar-nav>li>a:focus, .navbar-default .navbar-nav>li>a:hover, a:active  {color: black; font-family: inherit;}"
            ),
            HTML(".navbar-custom-menu>.navbar-nav>li>.dropdown-menu {background-color: black;}"),
            type = "text/css",
            "body {padding-top: 80px; color: black;
            #background-color: #ffffff;}",
            HTML(
                ".navbar-default {float: center; color:#1DB954; background-color:#1DB954;}"
            ),

            HTML("table table-striped table-hover {background-color:#1DB954;}"),
            tags$head(tags$style(
                HTML(
                    '.info-box {background-color:#1DB954; font-size: 20px} .info-box-icon {height: 5px; line-height: 5px;} .info-box-content {color:black; padding-top: 0px; padding-bottom: 10px;}'
                )
            )),
            
        ),
        tags$head(tags$style(HTML("a {color:#1DB954}"))),
        tags$head(tags$style('body, fluidRow {color:black;}')),
        tags$head(tags$style(
            HTML("a:hover, a:active {color:#1DB954; }")
        )),
        
    ),
    navbarPage(
        title = "Spotify Top Tracks Analysis",
        id = "nav",
        position = "fixed-top",
        
        tabPanel(
            "DATASET OVERVIEW",
            icon = icon('spotify'),
            fluidRow(
                infoBoxOutput("topTrack", width = 3),
                infoBoxOutput("topArtist", width = 3),
                infoBoxOutput("avgTrackPop", width = 3),
                infoBoxOutput("avgArtistPop", width = 3)
            ),
            
            fluidRow(
                box(
                    h4(
                        align = "center",
                        br(),
                        br(),
                        br(),
                        br(),
                        "Most Popular Tracks on Playlist"
                    ),
                    status = "success",
                    plotlyOutput("top10Tracks"),
                    height = 375
                ),
                
                box(
                    h4(
                        align = "center",
                        br(),
                        br(),
                        br(),
                        br(),
                        "Most Popular Artists on Playlist"
                    ),
                    status = "success",
                    plotlyOutput("top10Artists"),
                    height = 375,
                ),
            ),
            
            fluidRow(
                br(),
                br(),
                br(),
                br(),
                br(),
                br(),
                br(),
                br(),
                h4(
                    "Data contains Spotify's Top Tracks of 2020 and was collected in Jupyter Notebook using the ",
                    tags$a(href = "https://spotipy.readthedocs.io/en/2.16.1/",
                           "Python Spotipy Library"),
                    " and the ",
                    tags$a(href = "https://developer.spotify.com/documentation/web-api/",
                           "Spotify Web API"),
                    style = "text-align: center; line-height: 150%;"
                )
            ),
        ),
        
        
        navbarMenu(
            "EXPLORE",
            icon = icon("poll"),
            
            tabPanel(
                "AUDIO ANALYSIS",
                fluidRow(
                    tabBox(
                        id = "introduction",
                        width = "100%",
                        tabPanel(
                            "Track Popularity",
                            h5("The popularity of a track is a value between 0 and 100, with 100 being the most popular.
                                      The popularity is calculated by algorithm and is based, in the most part, on the total number of
                                      plays the track has had and how recent those plays are. Generally speaking, songs that are being played
                                      a lot now will have a higher popularity than songs that were played a lot in the past.
                                      Duplicate tracks (e.g. the same track from a single and an album) are rated independently.
                                      Artist and album popularity is derived mathematically from track popularity.
                                      Note that the popularity value may lag actual popularity by a few days: the value is not updated in real time.",
                            )
                        ),
                        tabPanel(
                            "Danceability",
                            h5("Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo,
                                      rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable."
                        )),
                        tabPanel(
                            "Energy",
                            h5("Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity.
                                      Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while
                                      a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range,
                                      perceived loudness, timbre, onset rate, and general entropy."
                        )),
                        tabPanel(
                            "Key",
                            h5("The key the track is in. Integers map to pitches using standard Pitch Class notation.
                                      E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on."
                        )),
                        tabPanel(
                            "Loudness",
                            h5("The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful
                                      for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate
                                      of physical strength (amplitude). Values typical range between -60 and 0 db."
                        )),
                        tabPanel(
                            "Mode",
                            h5("Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived.
                                      Major is represented by 1 and minor is 0."
                        )),
                        tabPanel(
                            "Speechiness",
                            h5("Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry),
                                      the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words.
                                      Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered,
                                      including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks."
                        )),
                        tabPanel(
                            "Acousticness",
                            h5("A confidence measure from 0.0 to 1.0 of whether the track is acoustic.
                                      1.0 represents high confidence the track is acoustic."
                        )),
                        tabPanel(
                            "Instrumentalness",
                            h5("Predicts whether a track contains no vocals. “Ooh” and “aah” sounds are treated as instrumental in this context.
                                      Rap or spoken word tracks are clearly “vocal”. The closer the instrumentalness value is to 1.0,
                                      the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks,
                                      but confidence is higher as the value approaches 1.0."
                        )),
                        tabPanel(
                            "Liveness",
                            h5("Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live.
                                      A value above 0.8 provides strong likelihood that the track is live."
                        )),
                        tabPanel(
                            "Valence",
                            h5("A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track.
                                      Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric),
                                      while tracks with low valence sound more negative (e.g. sad, depressed, angry)."
                        )),
                        tabPanel(
                            "Tempo",
                            h5("The overall estimated tempo of a track in beats per minute (BPM). In musical terminology,
                                      tempo is the speed or pace of a given piece and derives directly from the average beat duration."
                        )),
                        tabPanel("Duration ms",
                                 h5("The track length in milliseconds.")
                    )),
                    
                ),
                fluidRow(align = "center",
                         plotlyOutput("audioPlot"),
                         br(),
                         br()),
                
                
                
                fluidRow(align = "center",
                         br(),
                         br(),
                         br(),
                         h2("Density of Audio Characteristics"),
                         plotOutput("avgChar"))
                
                
            ),
            
            
            tabPanel("ARTIST/TRACK ANALYSIS",
                     fluidRow(
                         box(
                             h4(align = "center", "Artists With The Most Top Tracks"),
                             status = "success",
                             plotlyOutput("artistTopTracks"),
                             height = 375
                         ),
                         
                         box(
                             h4(align = "center", "Artists Follow Count VS Artist Popularity"),
                             status = "success",
                             plotlyOutput("artistPop"),
                             height = 375
                         ),
                    
                         box(
                             h4(
                                 align = "center",
                                 br(),
                                 br(),
                                 br(),
                                 br(),
                                 "Artists Follow Count VS Track Popularity"
                             ),
                             status = "success",
                             plotlyOutput("followersToTrackPop"),
                             height = 375
                         ),
                         
                     )),
            
            tabPanel("LINEAR MODELS",
                     fluidRow(
                         align = "center",
                         h2("Audio Characteristics"),
                         box(
                             br(),
                             br(),
                             br(),
                             br(),
                             br(),
                             selectizeInput(inputId = "x1", 
                                            label = "Select Variable X", 
                                            choices = colNames, 
                                            selected = 'Valence'), align = 'center',
                             
                             selectizeInput(inputId = "y1", 
                                            label = "Select Variable Y", 
                                            choices = colNames, 
                                            selected = 'Energy'), align = 'center'),

                             
                        
                              box(status = "success",
                                  plotOutput("customPlot"), height = 450),
                     
                              ),
                     
                     fluidRow(
                         align = "center",
                         h2(
                             align = "center",
                             br(),
                             "Artists vs Track Popularity"
                         ),
                         status = "success",
                         plotOutput("lmArtists"),
                         height = 375
                     )
                     )
            
        ),
        
        
        tabPanel(
            "DATA",
            icon = icon("database"),
            tabPanel("SPOTIFY TOP TRACKS DATA",
                     fluidRow(column(
                         6,
                         hr(),
                         DT::dataTableOutput("spotifyTable")
                     ))),
            
        ),
        
        tabPanel(
            "ABOUT ME",
            icon = icon("linkedin"),
            
            fluidRow(
                img(src = "https://i.imgur.com/kJPrloG.jpg", width = "17%", style = "display: block; margin-left: auto; margin-right: auto;"),
                h3(strong("NINA GUARINO"), style = "text-align: center"),
                h5("guarinonina@gmail.com", style = "text-align: center")
            ),
            #hr(),
            
            fluidRow(column(
                8,
                align = "center",
                offset = 2,
                
                h4(
                    tags$a(href = "https://linkedin.com/in/ninaguarino",
                           "LinkedIn"),
                    HTML('&nbsp;'),
                    HTML('&nbsp;'),
                    HTML('&nbsp;'),
                    tags$a(href = "https://github.com/ninaguarino",
                           "GitHub")
                ),
                
            )),
            hr(),
            fluidRow(
                column(2, ""),
                column(
                    1,
                    h4(icon("briefcase"), style = "text-align: right; line-height: 165%;"),
                    br(),
                    br(),
                    h4(icon("graduation-cap"), style = "text-align: right; line-height: 220%;"),
                    br(),
                    br(),
                    h4(icon("heart"), style = "text-align: right; line-height: 170%;")
                ),
                column(
                    6,
                    h4(
                        "Currently working as a Music Data Specialist (TVC) with Google/YouTube in NYC and
                        studying part-time at The NYC Data Science Academy.",
                        style = "text-align: left; line-height: 150%;"
                    ),
                    br(),
                    h4(
                        "Earned a Bachelors Degree in Computing and Informatics, Computer Science and a Graduate Certificate in Computational Data Analytics at Rowan University.",
                        style = "text-align: left; line-height: 150%;"
                    ),
                    br(),
                    h4(
                        "When I'm not behind the computer screen, you can find me surfing, skiing, playing guitar, and collecting vinyls.",
                        style = "text-align: left; line-height: 150%;"
                    )
                ),
                column(3, "")
            )
        )
    )
    
    
    
)
