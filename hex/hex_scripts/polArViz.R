library(geomtextpath)
library(cowplot)

plot <- ggplot(pressure, aes(temperature, pressure)) +
  geom_textline(label = "{polArViz}", size = 16, vjust = -0.5,
                linewidth = 1, linecolor = "red4", linetype = 2,
                color = "deepskyblue4") +
  ggthemes::theme_fivethirtyeight()


logo <- "https://github.com/PoliticaArgentina/data_warehouse/raw/master/hex/polArverse.png"

ggdraw(plot) +
  draw_image(logo, width = .3, x = .4, y = 1, hjust = 1, vjust = 1) +
  ggsave("hex/polArViz.png")
