#### AUTOMATE ICG DOWNLOAD
#### github actions

# Needed libraries
library(magrittr) # A Forward-Pipe Operator for R, CRAN v2.0.1
library(rvest) # Easily Harvest (Scrape) Web Pages, CRAN v1.0.0
library(haven) # Import and Export 'SPSS', 'Stata' and 'SAS' Files, CRAN v2.3.1
library(janitor) # Simple Tools for Examining and Cleaning Dirty Data, CRAN v2.1.0


# DATA SOURCE URL AND PATH
url = "https://www.utdt.edu/ver_contenido.php?id_contenido=17876&id_item_menu=28756"
xpath = "/html/body/main/section[2]/div/div/div/div[2]/div/span[2]/strong/a"



#Download workflow

# Set default value for try()
default <- NULL
df <- base::suppressWarnings(base::try(default <- rvest::read_html(url) %>% # SCRAPE
                                         rvest::html_elements(xpath = xpath) %>%
                                         rvest::html_attr('href') %>% 
                                         haven:: read_dta() %>% 
                                         janitor::clean_names(),
                                       silent = TRUE))


# Fail safely when online source is not available

  if(is.null(default)){
    df <- base::message("Fail to download data. Source is not available // La fuente de datos no esta disponible")
  
    save(x, file = paste0("opinAr/data_raw/download_fail", make.names(Sys.time()), ".txt")) # Create infomative error file
    
    } else {
    
    haven::write_dta(data = df, path = "opinAr/data_raw/icg.dta") 
  
    }


####




