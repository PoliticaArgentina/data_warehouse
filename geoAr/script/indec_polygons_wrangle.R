library(tidyverse)
library(sf)
library(ggplot2)


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
  st_write("geo/provincias.geojson")



# SIMPLIFY PROVS
mapa_arg %>%
  st_crop(xmin = -78.844299, ymin = -56.918980,
          xmax = -53.531800, ymax = -20.341163) %>% 
  st_simplify(dTolerance = .005) %>% 
  st_write("geo/provincias_simplified.geojson")



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
  st_write("geo/localidades.geojson")


mapa_arg_deptos %>%
  st_crop(xmin = -78.844299, ymin = -56.918980,
          xmax = -53.531800, ymax = -20.341163) %>% 
  st_simplify(dTolerance = .005) %>% 
  st_write("geo/localidades_simplified.geojson")


