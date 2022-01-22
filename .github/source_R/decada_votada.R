#### AUTOMATE DECADA VOTADA DOWNLOAD
#### github actions https://www.decadavotada.com.ar/doc.html

# Needed libraries
library(magrittr) # A Forward-Pipe Operator for R, CRAN v2.0.1
library(janitor) # Simple Tools for Examining and Cleaning Dirty Data, CRAN v2.1.0
library(dplyr) # A Grammar of Data Manipulation, CRAN v1.0.5
library(readr) # Read Rectangular Text Data, CRAN v1.4.0
library(glue) # Interpreted String Literals, CRAN v1.4.2 
library(purrr) # Functional Programming Tools, CRAN v0.3.4




# GET .zip FILE LINK 
link = "https://www.decadavotada.com.ar/DecadaVotadaCSV.zip"

# Download file from URL 

# Create temfiles

temp <- tempfile()

temp2 <- tempfile()

# Download .zip

download.file(url = link,  temp)


# Unzip files
# 
unzip(zipfile = temp, exdir = temp2)

# Select .dta file path

csv_files <-list.files(temp2, pattern = ".csv$", full.names=TRUE)

files <- tidyr::separate(data = tidyr::as_tibble(csv_files),
                         col = value, 
                         into = c("url", "file"), 
                         sep = "/", remove = FALSE)


data <- files %>% 
  dplyr::mutate(data = purrr::map2(.x = url,
                                   .y =  value,
                                   ~ readr::read_csv(.y, col_names = FALSE)))


#### CHEQUEO SI HAY DATOS MAS NUEVOS####


# FECHA DE ULTIMA VOTACION EN REPOSITORIO
test <- readr::read_csv("https://github.com/PoliticaArgentina/data_warehouse/raw/master/legislAr/data_raw/asuntos-diputados.csv") %>% 
  select(fecha = 5) %>% 
  arrange(desc(fecha)) %>% 
  slice(1) %>% 
  pull(fecha)



new <- data %>% 
  filter(stringr::str_detect(file , "asuntos-di")) %>% 
  select(data) %>% 
  purrr::flatten_dfr()  %>% 
  select(fecha = 5) %>% 
  arrange(desc(fecha)) %>% 
  slice(1) %>% 
  pull(fecha)
  


# Load data from temfile path workflow

# Set default value for try()


default <- NULL



# Fail safely when online source is not available

  if(test > new){
    
    message("No new data @ 'La Decada Votada' " )
   
    } else {

      
      data %>% 
        purrr::map2(.x = data$data, 
                    .y = data$file, 
                    .f = ~write_csv(.x, 
                                    file = glue::glue("legislAr/data_raw/{.y}")))
      
      
    
    }









