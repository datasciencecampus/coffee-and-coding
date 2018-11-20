#####
#creating coffee and coding hex with ons standard colours
#inspired by https://github.com/departmentfortransport/coffee-and-coding
#####

#install.packages(hexSticker)
library(hexSticker)

#set path to image, could be a url
imgpath <- "images/coffee_pipe_steam.png"
#save location of output
writeto <- "images/ons_cnc_hex.png"

#ONS colours as defined in:
#https://onsdigital.github.io/pattern-library/visual-language-colors.html
ons_green <- "#b2bb1c" 
ons_blue <-  "#00456a"
ons_black <- "#333333"

#choose colours for hex  
background_col <- ons_green
edge_col <- ons_blue

#now create the hex using hexSticker package
sticker(subplot = imgpath
        , s_x = 1.05
        , s_y = 1.05
        , s_width = 0.7 #leave s_height blank to maintain aspect ratio
        , package = "" #leave blank, or separate words with 6 spaces to accommodate steam ()
        #, p_x = 0.975                     
        #, p_y = 1.385
        #, p_color = "#003C5" #package (title) text colour
        , p_family = "Aller_Rg"
        , p_size = 5
        , h_size = 1.2
        , h_fill = background_col
        , h_color = edge_col
        # , spotlight = TRUE
        # , l_x = 1
        # , l_y = 0.8
        # , l_width = 3
        # , l_alpha = 0.3
        # , url = "coffee.coding@ons.gov.uk"
        , u_x = 1
        , u_y = 0.08
        # , u_color = ons_black #url text colour
        , u_family = "Aller_It"
        , u_size = 1.5
        , filename = writeto)
