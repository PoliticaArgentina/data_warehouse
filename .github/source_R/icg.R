#### AUTOMATE ICG DOWNLOAD
#### github actions

# Needed libraries
library(magrittr) # A Forward-Pipe Operator for R, CRAN v2.0.1
library(rvest) # Easily Harvest (Scrape) Web Pages, CRAN v1.0.0
library(haven) # Import and Export 'SPSS', 'Stata' and 'SAS' Files, CRAN v2.3.1
library(janitor) # Simple Tools for Examining and Cleaning Dirty Data, CRAN v2.1.0
library(dplyr) # A Grammar of Data Manipulation, CRAN v1.0.5
library(readr) # Read Rectangular Text Data, CRAN v1.4.0
library(glue) # Interpreted String Literals, CRAN v1.4.2 

 
# DATA SOURCE URL AND PATH
main = "https://www.utdt.edu"
url = "https://www.utdt.edu/ver_contenido.php?id_contenido=17876&id_item_menu=28756"


# GET .zip FILE LINK 

link <- rvest::read_html(url) %>% 
  rvest::html_nodes("a.noicon") %>% # Look for all URLs
  rvest::html_attr('href') %>%
  as_tibble() %>% 
  dplyr::filter(stringr::str_detect(value,"\\.zip")) %>% # ICG dta.zip file
  dplyr::transmute(value = as.character(glue::glue("{main}{value}"))) %>%  # Create file link 
  dplyr::pull() 


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
icg_file <-list.files(temp2, pattern = ".dta$", full.names=TRUE)


# Load data from temfile path workflow

# Set default value for try()

default <- NULL

df <- base::suppressWarnings(base::try(default <-  haven::read_dta(icg_file) %>% 
                                         janitor::clean_names(),
                                       silent = TRUE))

# Fail safely when online source is not available

  if(is.null(default)){
    df <- base::message("Fail to download data. Source is not available // La fuente de datos no esta disponible")
  
    save(x, file = paste0("opinAr/data_raw/download_fail", make.names(Sys.time()), ".txt")) # Create infomative error file
    
    } else {

      
      waves <- df %>% 
        dplyr::mutate(fecha = base::as.Date(base::paste0(ano,"-",mes,"-01"))) %>% 
        dplyr::select(ola, fecha) %>% 
        dplyr::group_by(ola) %>% 
        dplyr::arrange(fecha) %>% 
        dplyr::slice(2) %>% 
        dplyr::ungroup() %>% 
        dplyr::mutate(mes = lubridate::month(fecha), ano = lubridate::year(fecha)) %>% 
        dplyr::select(-fecha)
      
      
      # Write icg microdata .dta file
          
    haven::write_dta(data = df, path = "opinAr/data_raw/icg.dta") 
    
    # Write waves file
    
    readr::write_csv(waves, "opinAr/data_raw/icg_waves.csv") 
    
    }








