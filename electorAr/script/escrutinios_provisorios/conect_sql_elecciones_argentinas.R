library(DBI)
library(RSQLite)
library(odbc)
#### USAR ESTE SCRIPT EN MISMO DIRECTORIO QUE LAS BASES SQL DESCARGADAS



path <- "../../Documents/resultados_elecciones_SQL/"

Arg03<- dbConnect(odbc::odbc(),
                  driver = "SQLite3 ODBC Driver",
                  database=paste0(path ,"2003.sqlite3"))

Arg05<- dbConnect(odbc::odbc(),
                  driver = "SQLite3 ODBC Driver",
                  database=paste0(path ,"2005.sqlite3"))

Arg07<- dbConnect(odbc::odbc(),
                  driver = "SQLite3 ODBC Driver",
                  database=paste0(path ,"2007.sqlite3"))

Arg09<- dbConnect(odbc::odbc(),
                  driver = "SQLite3 ODBC Driver",
                  database=paste0(path ,"2009.sqlite3"))


### 2011

Arg11P<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2011P.sqlite3"))
Arg11G<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2011G.sqlite3"))

### 2013
Arg13P<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2013P.sqlite3"))
Arg13G<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2013G.sqlite3"))

### 2015
Arg15P<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2015P.sqlite3"))
Arg15G<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2015G.sqlite3"))

Arg15B<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2015B.sqlite3"))
#### 2017

Arg17P<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2017P.sqlite3"))
Arg17G<- dbConnect(odbc::odbc(),
                   driver = "SQLite3 ODBC Driver",
                   database=paste0(path ,"2017G.sqlite3"))




