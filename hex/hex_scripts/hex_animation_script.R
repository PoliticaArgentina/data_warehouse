library(magick)



discursAr <- magick::image_read("hex/discursAr.png")
legislAr <- magick::image_read("hex/legislAr.png")
electorAr <- magick::image_read("hex/electorAr.png")
geoAr <- magick::image_read("hex/geoAr.png")
opinAr <- magick::image_read("hex/opinAr.PNG")

logos <- c(discursAr, electorAr, geoAr, opinAr, legislAr)

logos <- image_scale(logos, "400x400")


# Create GIF
(animation1 <- image_animate(logos, fps = 1))


image_write(animation1, "hex/anim1.gif")


# https://git.io/JUpTQ
