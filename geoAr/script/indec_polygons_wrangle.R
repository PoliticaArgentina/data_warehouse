#### GET AND SIMPLIFY ARG POLYGONS
#### Juan Pablo Ruiz Nicolini


library(tidyverse) # Easily Install and Load the 'Tidyverse', CRAN v1.3.0
library(sf) # Simple Features for R, CRAN v0.9-7
library(ggplot2) # Create Elegant Data Visualisations Using the Grammar of Graphics, CRAN v3.3.3
library(rmapshaper) # Client for 'mapshaper' for 'Geospatial' Operations, CRAN v0.4.4

#### MAP ARGENTINA w/ PROVS

#create a couple temp files

temp <- tempfile()

temp2 <- tempfile()

#download the zip folder from the internet save to 'temp' 
download.file("https://www.indec.gob.ar/ftp/cuadros/territorio/codgeo/Codgeo_Pais_x_prov_datos.zip",temp)
#unzip the contents in 'temp' and save unzipped content in 'temp2'
unzip(zipfile = temp, exdir = temp2)
#finds the filepath of the shapefile (.shp) file in the temp2 unzip folder
#the $ at the end of ".shp$" ensures you are not also finding files such as .shp.xml 
your_SHP_file<-list.files(temp2, pattern = ".shp$",full.names=TRUE)

#read the shapefile. Alternatively make an assignment, such as f<-sf::read_sf(your_SHP_file)
mapa_arg <- sf::read_sf(your_SHP_file) %>% 
  select(codprov_censo = link, geometry)


mapa_arg %>%
  st_crop(xmin = -78.844299, ymin = -56.918980,
          xmax = -53.531800, ymax = -20.341163) %>% 
  st_write("../data_warehouse/geoAr/data_raw/provincias.geojson")



# SIMPLIFY PROVS
mapa_arg %>% 
  rmapshaper::ms_simplify() %>%
  st_crop(xmin = -78.844299, ymin = -56.918980,
          xmax = -53.531800, ymax = -20.341163) %>% 
  st_write("../data_warehouse/geoAr/data/provincias_simplified.geojson")



#### MAP ARGENTINA w/DEPTOS


temp <- tempfile()

temp2 <- tempfile()

#download the zip folder from the internet save to 'temp' 
download.file("https://www.indec.gob.ar/ftp/cuadros/territorio/codgeo/Codgeo_Pais_x_dpto_con_datos.zip",temp)
#unzip the contents in 'temp' and save unzipped content in 'temp2'
unzip(zipfile = temp, exdir = temp2)
#finds the filepath of the shapefile (.shp) file in the temp2 unzip folder
#the $ at the end of ".shp$" ensures you are not also finding files such as .shp.xml 
your_SHP_file<-list.files(temp2, pattern = ".shp$",full.names=TRUE)

#read the shapefile. Alternatively make an assignment, such as f<-sf::read_sf(your_SHP_file)
mapa_arg_deptos <- sf::read_sf(your_SHP_file)  %>% 
  transmute(codprov_censo = str_sub(link, 1, 2),
            coddepto_censo = str_sub(link, 3, 5))



mapa_arg_deptos %>%
  st_crop(xmin = -78.844299, ymin = -56.918980,
          xmax = -53.531800, ymax = -20.341163) %>%
  st_write("../data_warehouse/geoAr/data_raw/localidades.geojson")


mapa_arg_deptos %>% 
  rmapshaper::ms_simplify() %>%
  st_crop(xmin = -78.844299, ymin = -56.918980,
          xmax = -53.531800, ymax = -20.341163) %>% 
  st_write("../data_warehouse/geoAr/data/localidades_simplified.geojson")


## CHECK SHAPE



library(patchwork) # The Composer of Plots, CRAN v1.1.1

simple <- sf::read_sf("geoAr/data/localidades_simplified.geojson") %>%
  dplyr::filter(codprov_censo == "02") %>% 
  ggplot2::ggplot()+
  ggplot2::geom_sf()



raw <-  sf::read_sf("geoAr/data_raw/localidades.geojson")  %>%
  dplyr::filter(codprov_censo == "02") %>% 
  ggplot2::ggplot()+
  ggplot2::geom_sf()





simple + raw


### CENSUS TRACT
# Polygons compiled in one geojson from https://sitioanterior.indec.gob.ar/codgeo.asp

read_sf("geoAr/data_raw/radios_censales.geojson") %>% 
  rmapshaper::ms_simplify(keep_shapes = TRUE) %>% 
  st_write("geoAr/data/radios_simplified.geojson")



