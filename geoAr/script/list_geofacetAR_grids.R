#####  DISEÑO DE GRILLAS COMO SI FUERAN MAPAS
#####  DE ARGENTINA Y SUS PROVINCIAS

#####  1  Creamos un data.frame por cada grilla
#####  2  Agrumapos en un lista de data.frames
#####  3  Guardamos la lista como RData 


library(tidyverse) # Easily Install and Load the 'Tidyverse', CRAN v1.3.0
library(purrr) # Functional Programming Tools, CRAN v0.3.4
library(geofaceteAR) # Acomodar las Grillas como Mapas, [github::electorArg/geofaceteAR] v0.0.1



### NACIONAL ####


argentina <-  data.frame(
  col = c(1, 3, 5, 1, 2,
          1, 3, 4, 2, 2,
          4, 1, 3, 3, 4,
          1, 2, 2, 1, 1,
          2, 1, 1, 1),
  row = c(1, 2, 2, 2, 2,
          3, 3, 3, 3, 4,
          4, 4, 4, 5, 5,
          5, 5, 6, 6, 7,
          7, 8, 9, 10),
  code = c("10", "09", "14", "17", "23", # CODIGO PROVINCIA DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "03", "06", "05", "22", "04",
           "08", "12", "21", "02", "01",
           "18", "19", "11", "13", "15",
           "16", "07", "20", "24"),
  name = c( "JUJUY","FORMOSA", "MISIONES","SALTA", "TUCUMAN",
            "CATAMARCA","CHACO","CORRIENTES","SANTIAGO DEL ESTERO","CORDOBA",
            "ENTRE RIOS","LA RIOJA" ,"SANTA FE","BUENOS AIRES","CABA",
            "SAN JUAN","SAN LUIS","LA PAMPA","MENDOZA","NEUQUEN",
            "RIO NEGRO","CHUBUT","SANTA CRUZ", "TIERRA DEL FUEGO"),
  stringsAsFactors = FALSE
)



########### PROVINCIAS ##

codigos <- show_arg_codes(nivel = "departamentos",viewer = F) %>% 
  select(id, code = coddepto, nombre = nomdepto_censo)



# CABA ####
caba <- data.frame(
  code = c("013", "012", "011", "014", "015", "002", "006", "010",
           "005", "003", "007", "009", "001", "004", "008"), # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
  name = c("Comuna 13", "Comuna 12", "Comuna 11", "Comuna 14", "Comuna 15", "Comuna 02", "Comuna 06", "Comuna 10",
           "Comuna 05", "Comuna 03", "Comuna 07", "Comuna 09", "Comuna 01", "Comuna 04", "Comuna 08"),
  row = c(1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 3, 4, 5),
  col = c(3, 2, 1, 3, 2, 4, 2, 1, 3, 4, 2, 1, 5, 3, 2),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% print()


codigos %>% 
  filter(id == "CABA") %>% 
  left_join(caba) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE))





#  CATAMARCA ####

catamarca <- data.frame(
  name = c("Antofagasta de la Sierra", "Santa Maria", "Belen",
           "Tinogasta", "Andalgala", "Paclin", "Santa Rosa",
           "Ambato", "Poman", "El Alto", "Fray Mamerto Esquiu",
           "Capital", "Ancasti", "Valle Viejo", "Capayan", "La Paz"),
  code = c("014", "016", "013", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "015", "012", "007", "006",
           "010", "011", "005", "009",
           "001", "004", "008", "002", "003"),
  row = c(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6),
  col = c(1, 3, 2, 1, 3, 5, 6, 4, 3, 6, 5, 4, 6, 5, 4, 7),
  stringsAsFactors = FALSE
)  %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "CATAMARCA") %>% 
  left_join(catamarca) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE))





### CHACO ####

chaco<- data.frame(
  name = c("Gral Guemes", "LIBERTADOR GENERAL SAN MARTIN", "ALMIRANTE BROWN",
           "Gral Belgrano", "Maipu", "Quitilipi", "Sgto Cabral",
           "25 de Mayo", "9 de Julio", "Independencia", "Bermejo",
           "Gral Donovan", "Cmdte Fernandez", "Chacabuco", "O'Higgins",
           "1° DE MAYO", "12 de Octubre", "Libertad", "Pres  de la Plaza",
           "S Lorenzo", "2 de abril", "Mayor L J  Fontana", "S Fernando",
           "Fray J S M de Oro", "Tapenaga"),
  code = c("025", "008", "024", "018", "016", "014", "005", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "015", "019", "017", "007", "004", "013", "020",
           "012", "002", "021", "003", "006", "022", "010",
           "011", "001", "023", "009"),
  row = c(2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6),
  col = c(3, 4, 1, 2, 3, 4, 5, 5, 2, 3, 7, 6, 4, 1, 3, 7, 1, 6, 5, 4, 2, 4, 6, 3, 5),
  stringsAsFactors = FALSE
)  %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()


codigos %>% 
  filter(id == "CATAMARCA") %>% 
  left_join(catamarca) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE))





# CHUBUT ####


chubut <- data.frame(
  name = c("Biedma", "Gastre", "Telsen",
           "Cushamen", "Futaleufu", "Gaiman",
           "Rawson", "Languiñeo", "Martires",
           "Paso de los Indios", "Tehuelches", "Florentino Ameghino",
           "Rio Senguer", "Escalante", "Sarmiento"),
  code = c("002", "004", "003",
           "005", "006", "012", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "001", "007", "010",
           "009", "008", "011",
           "013", "015", "014"),
  row = c(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4),
  col = c(5, 3, 4, 2, 1, 3, 4, 2, 3, 2, 1, 4, 1, 3, 2),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()


codigos %>% 
  filter(id == "CHUBUT") %>% 
  left_join(chubut) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE))



#### CORDOBA ####
  cordoba <- data.frame(
    name = c("Sobremonte", "Rio Seco", "Ischilin", "Cruz del Eje", "Totoral",
"Tulumba", "San Justo", "Minas", "Punilla", "Colon", "Rio Primero",
"Pocho", "San Alberto", "Capital", "Rio Segundo", "General San Martin",
"Santa Maria", "San Javier", "Calamuchita", "Union", "Marcos Juarez",
"Rio Cuarto", "Tercero Arriba", "Juarez Celman",
"General Roca", "Presidente Roque Saenz Peña"),
    code = c("022", "015", "007", "004", "024",
"025", "020", "010", "012", "003", "014",
"011", "018", "001", "016", "006", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
"021", "019", "002", "026", "009",
"013", "023", "008",
"005", "017"),
row = c(1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 7, 7, 8),
col = c(3, 4, 2, 1, 3, 4, 5, 1, 2, 3, 4, 1, 2, 3, 4, 4, 3, 1, 2, 5, 6, 2, 3, 3, 2, 3),
stringsAsFactors = FALSE ) %>% 
    mutate(name = str_to_upper(name)) %>% 
    arrange(name) %>% 
    print()
  

codigos %>% 
  filter(id == "CORDOBA") %>% 
  left_join(cordoba) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)
  


# CORRIENTES ####


corrientes <- data.frame(
  name = c("Capital", "San Cosme", "Itati", "Beron de Astrada",
           "Ituzaingo", "Santo Tome", "San Luis del Palmar", "Empedrado",
           "General Paz", "San Miguel", "Bella Vista", "Saladas",
           "Concepcion", "Mburucuya", "General Alvear", "Mercedes",
           "Lavalle", "San Roque", "San Martin", "Goya",
           "Paso de los Libres", "Curuzu Cuatia", "Monte Caseros", "Esquina", "Sauce"),
  code = c("001", "021", "024", "025", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "019", "007", "010", "012",
           "014", "023", "011", "015",
           "017", "018", "022", "004",
           "006", "013", "016", "002",
           "008", "003", "009", "005", "020"),
  row = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6, 6, 6),
  col = c(2, 3, 4, 5, 6, 6, 3, 2, 4, 5, 1, 2, 4, 3, 5, 3, 1, 2, 4, 1, 3, 2, 3, 1, 2),
  stringsAsFactors = FALSE
  )%>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "CORRIENTES") %>% 
  left_join(corrientes) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)


# ENTRE RIOS ####

entre_rios <- data.frame(
  name = c("Federacion", "Feliciano", "Concordia", "Federal", "La Paz",
           "Colon", "Parana", "San Salvador", "Villaguay", "Diamante",
           "Nogoya", "Tala", "Uruguay", "Gualeguay", "Gualeguaychu", "Victoria", "Islas del Ibicuy"),
  code = c("017", "016", "013", "014", "003", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "015", "001", "018", "012", "004",
           "006", "008", "009", "007", "010", "005", "011"),
  row = c(1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6),
  col = c(4, 3, 4, 3, 2, 4, 1, 3, 2, 1, 2, 3, 4, 3, 4, 2, 4),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "ENTRE RIOS") %>% 
  left_join(entre_rios) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)




# FORMOSA ####

formosa <- data.frame(
  name = c("Ramon Lista", "Bermejo", "Matacos", "Patiño",
           "Pilagas", "Pilcomayo", "Formosa", "Pirane", "Laishi"),
  code = c("009", "007", "008", "006", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "005", "003", "001", "004", "002"),
  row = c(1, 2, 2, 2, 2, 2, 3, 3, 4),
  col = c(1, 2, 1, 3, 4, 5, 5, 4, 5),
  stringsAsFactors = FALSE
)%>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()


codigos %>% 
  filter(id == "FORMOSA") %>% 
  left_join(formosa) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)



# JUJUY ####

jujuy <- data.frame(
  name = c("Yavi", "Santa Catalina", "Humahuaca", "Rinconada", "Cochinoca",
           "Valle Grande", "Ledesma", "Susques", "Tumbaya", "Tilcara",
           "Santa Barbara", "Dr. Manuel Belgrano", "Palpala", "San Pedro", "San Antonio", "El Carmen"),
  code = c("015", "014", "011", "013", "012", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "008", "007", "016", "009", "010",
           "006", "001", "002", "005", "003", "004"),
  row = c(2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6, 6, 6),
  col = c(3, 2, 3, 1, 2, 4, 5, 1, 3, 4, 5, 3, 4, 5, 3, 4),
  stringsAsFactors = FALSE
)%>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "JUJUY") %>% 
  left_join(jujuy) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)




# LA PAMPA ####
la_pampa <- data.frame(
  name = c("Chapaleufu", "Realico", "Maraco", "Rancul", "Trenel", "Conhelo",
           "Quemu Quemu", "Capital", "Catrilo", "Chalileo", "Chical Co", "Loventue",
           "Toay", "Atreuco", "Guatrache", "Limay Mahuida", "Puelen", "Utracan",
           "Curaco", "Hucal", "Lihuel Calel", "Caleu Caleu"),
  code = c("006", "019", "015", "018", "021", "008",  # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "017", "002", "004", "005", "007", "012",
           "020", "001", "010", "014", "016", "022",
           "009", "011", "013", "003"),
  row = c(1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 7),
  col = c(6, 5, 6, 4, 5, 5, 6, 5, 6, 2, 1, 3, 4, 5, 6, 3, 2, 4, 4, 6, 5, 6),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()




codigos %>% 
  filter(id == "LA PAMPA") %>% 
  left_join(la_pampa) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)



# LA RIOJA ####

la_rioja <- data.frame(
  name = c("Arauco", "Castro Barros", "Famatina", "General Lamadrid", "San Blas de los Sauces",
           "Vinchina", "Capital", "Chilecito", "Coronel Felipe Varela", "Sanagasta",
           "Chamical", "General Angel V. Peñaloza", "Independencia", "General Belgrano", "General Juan F.Quiroga",
           "General Ocampo", "Rosario Vera Peñaloza", "General San Martin"),
  code = c("004", "003", "007", "009", "005",
           "010", "001", "006", "008", "002", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "012", "013", "011", "014", "015",
           "016", "017", "018"),
  row = c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6),
  col = c(6, 5, 3, 1, 4, 2, 6, 4, 3, 5, 6, 5, 4, 6, 5, 6, 5, 6),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "LA RIOJA") %>% 
  left_join(la_rioja) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)




#MENDOZA ####
mendoza <- data.frame(
  name = c("Las Heras", "Lavalle", "Guaymallen", "Lujan de Cuyo", "Capital",
           "San Martin", "Junin", "Godoy Cruz", "Maipu", "Tupungato",
           "Rivadavia", "Tunuyan", "Santa Rosa", "La Paz", "San Rafael",
           "San Carlos", "General Alvear", "Malargüe"),
  code = c("004", "005", "003", "007", "001", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "009", "010", "002", "006", "008",
           "011", "012", "014", "015", "016",
           "013", "018", "017"),
  row = c(1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 6),
  col = c(2, 4, 3, 1, 2, 4, 4, 2, 3, 2, 3, 1, 4, 5, 3, 2, 4, 2),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "MENDOZA") %>% 
  left_join(mendoza) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)




# MISIONES ####

misiones <- data.frame(
  name = c("Iguazu", "General Manuel Belgrano", "El Dorado",
           "Libertador General San Martin",
           "San Pedro", "Montecarlo", "San Ignacio", "Guarani",
           "Cainguas", "Obera",
           "Candelaria", "25 de Mayo", "Capital", "Leandro N. Alem",
           "San Javier", "Concepcion", "Apostoles"),
  code = c("016", "017", "014",
           "009",
           "015", "012", "007", "013",
           "010", "008", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "003", "011", "001", "004",
           "006", "005", "002"),
  row = c(1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6),
  col = c(5, 6, 5, 4, 6, 5, 3, 5, 4, 3, 2, 4, 1, 2, 3, 2, 1),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "MISIONES") %>% 
  left_join(misiones) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)



# NEUQUEN ####

neuquen <- data.frame(
  name = c("Chos Malal", "Minas", "Pehuenches", "Añelo", "Loncopue",
           "Ñorquin", "Confluencia",
           "Picunches", "Zapala", "Alumine", "Catan Lil", "Picun Leufu", "Collon Cura",
           "Huiliches", "Lacar", "Los Lagos"),
  code = c("005", "006", "004", "003", "008",
           "007", "001", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "009", "002", "010", "011", "012", "013",
           "014", "015", "016"),
  row = c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 7),
  col = c(3, 2, 4, 4, 3, 2, 4, 2, 3, 1, 2, 3, 2, 1, 1, 1),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()


codigos %>% 
  filter(id == "NEUQUEN") %>% 
  left_join(neuquen) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)




# PBA ####
# SECCION ELECTORALES (SON MUCHOS MUNICIPIOS PARA geo_grid)

pba <- data.frame(
  name = c("Segunda", "Primera", "Tercera", "Capital", "Septima", "Cuarta", "Quinta", "Sexta"),
  code = c("2", "1", "3", "8", "7", "4", "5", "6"),
  row = c(1, 1, 1, 2, 2, 2, 2, 3),
  col = c(2, 3, 4, 4, 2, 1, 3, 1),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



#### SECCION ELECTORAL VS  DEPARTAMENTOS. VA A HABER QUE HARDCODEAR ESTO JUNTO A ARGENTINA
codigos %>% 
  filter(id == "BUENOS AIRES") %>% 
  left_join(pba) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)

###################




# RIO NEGRO ####

rio_negro <- data.frame(
  name = c("General Roca", "Avellaneda", "El Cuy", "Pichi Mahuida", "Pilcaniyeu", "Conesa",
           "9 de Julio", "Valcheta", "25 de Mayo", "Ñorquinco", "Bariloche",
           "San Antonio", "Adolfo Alsina"),
  code = c("012", "011", "013", "010", "008", "002",
           "005", "004", "006", "007", "009",
           "003", "001"), # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
  row = c(1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4),
  col = c(3, 4, 3, 5, 2, 6, 4, 5, 3, 2, 1, 6, 7),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()




codigos %>% 
  filter(id == "RIO NEGRO") %>% 
  left_join(rio_negro) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)



#  SALTA ####


salta <- data.frame(
  name = c("Santa Victoria", "Iruya", "General Jose de San Martin", "Oran", "La Poma",
           "General Güemes", "Rivadavia", "La Caldera", "Rosario de Lerma", "Los Andes",
           "Capital", "Anta", "Cerrillos", "Cachi", "Metan", "Chicoana", "Molinos",
           "San Carlos", "Rosario de la Frontera", "La Viña", "Guachipas", "La Candelaria",
           "Cafayate"), # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
  code = c("010", "009", "008", "007", "022",
           "003", "006", "002", "021", "023",
           "001", "005", "011", "020", "004", "012", "019",
           "018", "015", "013", "014", "016",
           "017"),
  row = c(1, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7),
  col = c(5, 6, 7, 6, 2, 5, 7, 4, 3, 2, 5, 6, 4, 3, 5, 4, 2, 3, 6, 4, 5, 5, 4),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()




codigos %>% 
  filter(id == "SALTA") %>% 
  left_join(salta) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)



# SANTA CRUZ ####

santa_cruz <- data.frame(
  name = c("Deseado", "Lago Buenos Aires", "Magallanes",
           "Rio Chico", "Corpen Aike", "Lago Argentino", "Güer Aike"),
  code = c("001", "002", "003", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "004", "005", "006", "007"),
  row = c(1, 1, 2, 2, 3, 3, 4),
  col = c(2, 1, 2, 1, 2, 1, 2),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "SANTA CRUZ") %>% 
  left_join(santa_cruz) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)


# SANTA FE####

santa_fe <- data.frame(
  name = c("General Obligado", "9 de Julio", "Vera",
           "San Javier", "San Cristobal", "San Justo", "Garay",
           "Castellanos", "Las Colonias", "La Capital", "San Jeronimo",
           "San Martin", "San Lorenzo", "Belgrano", "Iriondo",
           "Rosario", "Caseros", "Constitucion", "General Lopez"),
  code = c("007", "012", "022",
           "017", "016", "019", "005",
           "003", "011", "009", "018",# CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "021", "020", "001", "008",
           "013", "002", "004", "006"),
  row = c(2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 7, 7, 8),
  col = c(3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 2, 1, 4, 1, 2, 3, 1, 2, 1),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()




codigos %>% 
  filter(id == "SANTA FE") %>% 
  left_join(santa_fe) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)


# SANTIAGO DEL ESTERO ####


santiago_del_estero <- data.frame(
  name = c("Copo", "Pelegrini", "Alberdi", "Jimenez", "Banda", "Figueroa", "Moreno",
           "Rio Hondo", "Capital", "Juan F. Ibarra", "Robles", "Sarmiento", "Guasayan",
           "Avellaneda", "General Taboada", "San Martin", "Silipica", "Choya", "Atamisqui",
           "Belgrano", "Loreto", "Salavina", "Aguirre", "Ojo de Agua", "Quebrachos",
           "Mitre", "Rivadavia"), # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
  code = c("008", "018", "004", "012", "006", "010", "016",
           "022", "001", "014", "021", "026", "011",
           "002", "027", "024", "023", "009", "005",
           "007", "013", "025", "003", "017", "019",
           "015", "020"),
  row = c(1, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8),
  col = c(4, 3, 4, 3, 3, 4, 5, 2, 2, 5, 3, 4, 1, 4, 5, 3, 2, 1, 3, 5, 2, 4, 5, 2, 3, 4, 5),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "SANTIAGO DEL ESTERO") %>% 
  left_join(santiago_del_estero) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)


grid_preview(santiago_del_estero, label = "name")

# SAN JUAN ####

san_juan <- data.frame(
  name = c("Iglesia", "Jachal", "Valle Fertil", "Ullum", "Albardon", "Angaco", "Zonda",
           "San Martin", "Caucete", "Rivadavia", "Chimbas", "Santa Lucia", "Pocito",
           "Capital", "9 de Julio", "Calingasta", "Rawson", "25 de Mayo", "Sarmiento"),
  code = c("018", "017", "016", "011", "010", "009", "005", # Codigos utilizados por INDRA en bases de datos electorales
           "008", "015", "004", "003", "002", "012",
           "001", "007", "019", "006", "014", "013"),
  row = c(2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6, 7, 7, 8),
  col = c(2, 3, 4, 3, 4, 5, 3, 4, 5, 3, 4, 5, 3, 4, 5, 2, 4, 5, 4),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()


codigos %>% 
  filter(id == "SAN JUAN") %>% 
  left_join(san_juan) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)




# SAN LUIS ####

san_luis <- data.frame(
  name = c("Ayacucho", "Junin", "Belgrano", "Chacabuco",
           "Libertador General San Martin", "Coronel Pringles", "General Pedernera",
           "La Capital", "Gobernador Dupuy"),
  code = c("007", "006", "008", "004",  # Codigos utilizados por INDRA en bases de datos electorales
           "005", "002", "003",
           "001", "009"),
  row = c(1, 1, 2, 2, 2, 3, 3, 3, 4),
  col = c(2, 3, 1, 3, 2, 2, 3, 1, 3),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "SAN LUIS") %>% 
  left_join(san_luis) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)


# TIERRA DEL FUEGO ####
# CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
tierra_del_fuego <- data.frame(
  name = c("Rio Grande", "Tolhuin", "Ushuaia"),
  code = c("002", "003", "001"),# Codigos utilizados por INDRA en bases de datos electorales
  row = c(2, 3, 4),
  col = c(1, 1, 2),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()



codigos %>% 
  filter(id == "TIERRA DEL FUEGO") %>% 
  left_join(tierra_del_fuego) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)

# TUCUMAN ####

tucuman <- data.frame(
  name = c("Trancas", "Burruyacu", "Tafi del Valle", "Cruz Alta",
           "Yerba Buena", "Capital", "Tafi Viejo", "Leales", "Monteros",
           "Famailla", "Lules", "Chicligasta", "Rio Chico",
           "Simoca", "Graneros", "Juan B. Alberdi", "La Cocha"),
  code = c("014", "013", "017", "012", # CODIGO DEPTO DIRECCION NACIONAL ELECTORAL (DINE - INDRA)
           "015", "001", "016", "011", "004",
           "003", "002", "005", "006",
           "010", "009", "007", "008"),
  row = c(1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 5, 5, 6),
  col = c(3, 4, 1, 5, 3, 4, 2, 5, 2, 3, 4, 2, 3, 4, 4, 3, 3),
  stringsAsFactors = FALSE
) %>% 
  mutate(name = str_to_upper(name)) %>% 
  arrange(name) %>% 
  print()




codigos %>% 
  filter(id == "TUCUMAN") %>% 
  left_join(tucuman) %>% 
  mutate(check = ifelse(nombre == name, TRUE, FALSE)) %>% 
  filter(check == F)



### CREO UN UNICO data.frame COMO LIST CON CADA UNO DE LOS DISTRITOS
data <- list(argentina, caba, catamarca, chaco, chubut, cordoba, corrientes,
             entre_rios, formosa, jujuy, la_pampa, la_rioja, mendoza, misiones,
             neuquen, pba, rio_negro, salta, santa_cruz, santa_fe, santiago_del_estero,
             san_juan, san_luis, tierra_del_fuego, tucuman)


#Nombres de provincias
names(data) <- c("ARGENTINA","CABA", "CATAMARCA", "CHACO", "CHUBUT", "CORDOBA", "CORRIENTES",
                 "ENTRE RIOS", "FORMOSA", "JUJUY", "LA PAMPA", "LA RIOJA", "MENDOZA", "MISIONES",
                 "NEUQUEN", "PBA", "RIO NEGRO", "SALTA", "SANTA CRUZ", "SANTA FE", "SANTIAGO DEL ESTERO",
                 "SAN JUAN", "SAN LUIS", "TIERRA DEL FUEGO", "TUCUMAN")


#### DATA FRAME codprov  ~ name_prov
provCode <- tibble(name_prov = 
                         c("CABA", "CATAMARCA", "CHACO", "CHUBUT", "CORDOBA", "CORRIENTES","ENTRE RIOS","FORMOSA", 
                           "JUJUY", "LA PAMPA", "LA RIOJA", "MENDOZA", "MISIONES", "NEUQUEN","BUENOS AIRES","RIO NEGRO",
                           "SALTA", "SANTA CRUZ", "SANTA FE", "SANTIAGO DEL ESTERO", "SAN JUAN", "SAN LUIS", "TIERRA DEL FUEGO", "TUCUMAN"), 
                       codprov = 
                         c('01','03','06','07','04','05','08','09',
                           '10','11','12','13','14','15','02','16',
                           '17','20','21','22','18','19','24','23')) 

write_csv(provCode, "geo/provCode.csv")
  
  
#Guardo lista de grillas en destino /geo
write_rds(x = data, path = "geo/grillas_geofacet.rds")
  

