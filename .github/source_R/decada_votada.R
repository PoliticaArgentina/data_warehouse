#### AUTOMATE DECADA VOTADA DOWNLOAD
#### github actions https://www.decadavotada.com.ar/doc.html
### Alternative URL Source Data https://www.decadavotada.andytow.com/doc.html

# Needed libraries


install.packages(c("magrittr", "janitor",
                   "dplyr", "readr", "glue", "purrr"))


library(magrittr) # A Forward-Pipe Operator for R, CRAN v2.0.1
library(janitor) # Simple Tools for Examining and Cleaning Dirty Data, CRAN v2.1.0
library(dplyr) # A Grammar of Data Manipulation, CRAN v1.0.5
library(readr) # Read Rectangular Text Data, CRAN v1.4.0
library(glue) # Interpreted String Literals, CRAN v1.4.2 
library(purrr) # Functional Programming Tools, CRAN v0.3.4




# GET .zip FILE LINK 
# link = "https://www.decadavotada.com.ar/DecadaVotadaCSV.zip"

# GET .zip FILE LINK - ALTERNATIVE SOURCE
link = "https://www.decadavotada.andytow.com/DecadaVotadaCSV.zip"

# Download file from URL 

# Create temfiles

temp <- tempfile()

temp2 <- tempfile()

# Download .zip


# DO NOT VALIDATE SSL CERTIFICATE
options(download.file.method="curl", download.file.extra="-k -L")


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

dim_data <- dim(data$data[[1]])[1] # FILAS EN DATA DE FUENTE DE DATOS

# CANTIDAD DE REGISTROS EN REPOSITORIO
test <- readr::read_csv("https://github.com/PoliticaArgentina/data_warehouse/raw/master/legislAr/data_raw/asuntos-diputados.csv", 
                        col_names = TRUE) 

dim_test <- dim(test)[1]


# Fail safely when online source is not available

if(dim_test <= dim_data){
  
  message("No new data @ 'La Decada Votada'" )
  
  df <- data.frame(msje =  glue::glue("No new data @ 'La Decada Votada' on {format(Sys.time(), 
    '%a %b %d %X %Y')}"))
  
  write.csv(df, file = glue::glue("legislAr/data_check/check_{Sys.Date()}.csv"))
  
  
} else {
  
  
  data %>% 
    purrr::map2(.x = data$data, 
                .y = data$file, 
                .f = ~write_csv(.x, 
                                file = glue::glue("legislAr/data_raw/{.y}")))
  
  
}









