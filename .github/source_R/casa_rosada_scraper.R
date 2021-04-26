# LIBRERIAS PARA SCRAPEAR casarosada.gob.ar
library(rvest)
library(xml2)
library(tidyverse)
library(glue)
library(lubridate)


# URL casarosada.gob.ar
link <- 'https://www.casarosada.gob.ar/informacion/discursos'

# OBTENGO FECGAS DE PRIMERA PAGINA DE casarosada.gob.ar
extract_dates <- read_html(link) %>% 
  html_nodes('div time') %>% 
  html_text(trim = T) %>% 
  as_tibble() 

# Descargo contenido html de casarosada.gob.ar
nodes <- read_html(link) %>% 
  rvest::html_nodes("a")  

# OBTENGO LINKS DE PRIMERA PAGINA DE casarosada.gob.ar
extract_url <-  html_attr(nodes, "href") %>%
  as_tibble() %>% 
  filter(str_detect(value,"informacion/discursos/\\d"),
         value!="") %>% 
  transmute(link = glue::glue("{link}{value}")) 
 
# FILTRO LINKS DE DISCURSOS LA ULTIMA SEMANA
speech_to_extract <- extract_dates %>% 
  mutate(date = dmy(value)) %>% 
  bind_cols(extract_url) %>% 
  filter(date > today()-7)


# SCRAPEO CONDICIONAL A HABER ENCONTRADO NUEVOS DISCURSOS PUBLICADOS

      if(length(speech_to_extract) > 0){ 
      
        
        # DESCARGA DISCURSO - BY DIEGO KOZ
        
        get_text <- function(link){
          tryCatch({
            
            pagina <- read_html(link)
            
            texto <- pagina %>% html_nodes('.jm-allpage-in') %>% 
              html_text(., trim = TRUE)
            
            titulo <- pagina %>%
              html_nodes('strong') %>%
              html_text(trim = TRUE) %>%
              as.data.frame() %>% 
              as_tibble() %>% 
              slice(1) %>% 
              pull(.)
            
            df <- tibble(texto=texto, titulo=titulo)
            
            #    df %>% 
            #      mutate(texto = str_remove_all(texto, pattern = titulo)) # Borrar titulo del cuerpo del txt?
            
            Sys.sleep(1)
            df
            
          },error = function(err) {glue::glue("error_in_link: {link}")})
        }
        
        
        # ITERAR FUNCION PARA LISTADO FILTRADO DE DISCURSOS
        discurso <- speech_to_extract %>% 
          mutate(discurso = map(link, get_text)) %>% 
          select(discurso) %>% 
          flatten_df() %>%
          bind_cols(speech_to_extract) %>% 
          group_by(link, date, titulo) %>% 
          nest()
        
        # GUARDO NUEVOS DISCURSOS


                  
 } else {
     
   message('No hay nuevos discursos para descrgar')}
 
      
      
      