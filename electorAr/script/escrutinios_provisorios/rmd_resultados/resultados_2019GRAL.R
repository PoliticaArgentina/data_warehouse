

##### LIBRERIAS ####

library(tidyverse)
### GENERAL ####


library(elecciones.ar.2019)


elecciones.ar.2019::categorias %>%
  as_tibble() %>%
  filter(str_detect(nombre_categoria, "Diputados Nacionales|Senadores Nacionales|Presidente")) %>%
  pull(nombre_categoria)



datos_seccion <- votos %>%
  as_tibble() %>%
  ungroup() %>%
  left_join(mesas, by = "id_mesa") %>%
  # left_join(establecimientos, by = "id_establecimiento") %>%
  left_join(distritos, by ="id_distrito") %>%
  left_join(secciones, by = "id_seccion") %>%
  select(14:16)  %>%
  distinct() %>%
  transmute(codprov = str_sub(codigo_seccion, start = 1, end = 2),
            coddepto = str_sub(codigo_seccion, start = 3, end = 5),
            prov = nombre_distrito,
            depto = nombre_seccion) %>%
  print()


datos_seccion %>%
  group_by(prov) %>%
  summarise(deptos = n()) %>%
  arrange(desc(deptos)) %>%
  print(n = 24)


datos_grales <- votos %>%
  as_tibble() %>%
  left_join(mesas, by = "id_mesa") %>%
  # left_join(establecimientos, by = "id_establecimiento") %>%
  left_join(distritos, by ="id_distrito") %>%
  left_join(secciones, by = "id_seccion") %>%
  left_join(listas, by = "id_lista") %>%
  left_join(agrupaciones, by = "id_agrupacion") %>% print(n = 50) %>%
  left_join(categorias, by = "id_categoria") %>%
  left_join(meta_agrupaciones, by = "id_meta_agrupacion") %>%
  filter(str_detect(nombre_categoria, "Diputados Nacionales|Senadores Nacionales|Presidente")) %>%
  #  group_by(nombre_meta_agrupacion, codigo_seccion, votos_totales, nombre_categoria) %>%
  #  summarise(votos = sum(votos)) %>%
  #  mutate(porcentaje = votos / votos_totales*100) %>%
  #  ungroup() %>%
  select(nombre_meta_agrupacion, votos, codigo_seccion, nombre_categoria, id_circuito, id_mesa, id_meta_agrupacion) %>%
  arrange(-votos) %>%
  mutate(codprov = str_sub(codigo_seccion, 1 , 2),
         coddepto = str_sub(codigo_seccion, 3 , 5),
         lista = as.character(id_meta_agrupacion),
         lista = str_pad(lista, 5, "left", 0),
         id_circuito = as.character(id_circuito),
         id_circuito = str_pad(id_circuito, 5, "left", 0),
         id_mesa = as.character(id_mesa),
         id_mesa = str_pad(id_mesa, 6, "left", 0)) %>%
  group_by(nombre_meta_agrupacion, codprov,  coddepto, id_circuito, id_mesa, nombre_categoria, lista) %>%
  summarise_if(is.numeric, funs(sum)) %>%
  ungroup() %>%
  print()



#LISTAS PRESIDENTE
listas_presi_gral <- datos_grales %>%
  filter(str_detect(nombre_categoria , "Presi"),
         !str_detect(nombre_meta_agrupacion, "BLANCO")) %>%
  select(parDenominacion = nombre_meta_agrupacion, vot_parCodigo = lista, codprov) %>%
  distinct() %>%
  mutate(vot_parCodigo = as.character(vot_parCodigo)) %>%
  rename(vot_proCodigoProvincia = codprov) %>%
  write_csv("scripts/rmd_listas/presidente/listas_presi_gral2019.csv")


datos_finales_gral <-  datos_grales %>%
  left_join(datos_seccion, by = c("codprov", "coddepto"))  %>%
  select(codprov, prov, coddepto, depto, circuito = id_circuito, mesa = id_mesa,
         votos, categoria = nombre_categoria, lista)%>%
  mutate(lista = case_when(
    lista == "00110" ~ "blancos",
    T  ~ lista))


generales2019 <- datos_finales_gral %>%
  mutate(cat= case_when(
    str_detect(categoria, "Dip") ~ "dip",
    str_detect(categoria, "Sen") ~ "sen",
    str_detect(categoria, "Pres") ~ "presi"
  ),
  electores = 0,
  nulos = 0)


#EXPORTO RESULTADOS PRESIDENTE
generales2019 %>%
  filter(cat == "presi") %>%
  filter(!is.na(votos)) %>%
  select(-prov, -cat) %>%
  pivot_wider(id_cols = c(codprov, coddepto, depto, circuito , mesa, electores, nulos),
              names_from = lista,
              values_from = votos) %>%
  select(codprov, coddepto, depto, circuito, mesa,  electores, nulos, blancos, everything()) -> temp_gral



temp_gral_filtrado  <- temp_gral[c(1:8,8 + which(colSums(temp_gral[-(1:8)]) !=0))]

temp_gral_filtrado %>%
write_csv("data/00.PRESIDENCIAL/arg_presi_gral2019.csv")



# FUNCION PARA HACER WIDE LOS DATASETS
make_wider <- function(data = data){

  data %>%
    bind_rows() %>%
    pivot_wider(id_cols = c(codprov, coddepto, depto, circuito , mesa, electores, nulos),
                names_from = lista,
                values_from = votos) %>%
    select(codprov, coddepto, depto, circuito, mesa, electores, nulos, blancos, everything()) %>%
    mutate_if(is.numeric, funs(replace_na(., replace = 0)))-> temp_gral



  temp_gral_filtrado  <- temp_gral[c(1:8,8 + which(colSums(temp_gral[-(1:8)]) !=0))]

  temp_gral_filtrado




  }


#LISTAS DIPUTADOS
listas_dip_gral <- datos_grales %>%
  filter(!is.na(votos)) %>%
  filter(str_detect(nombre_categoria , "Dip"),
         !str_detect(nombre_meta_agrupacion, "BLANCO")) %>%
  select(parDenominacion = nombre_meta_agrupacion, vot_parCodigo = lista, codprov) %>%
  distinct() %>%
  mutate(vot_parCodigo = as.character(vot_parCodigo)) %>%
  rename(vot_proCodigoProvincia = codprov) %>%
  write_csv("scripts/rmd_listas/diputados/listas_dip_gral2019.csv")


#LISTAS SENADORES
listas_sen <- datos_grales %>%
  filter(!is.na(votos)) %>%
  filter(str_detect(nombre_categoria , "Sen"),
         !str_detect(nombre_meta_agrupacion, "BLANCO")) %>%
  select(parDenominacion = nombre_meta_agrupacion, vot_parCodigo = lista, codprov) %>%
  distinct() %>%
  mutate(vot_parCodigo = as.character(vot_parCodigo)) %>%
  rename(vot_proCodigoProvincia = codprov) %>%
  write_csv("scripts/rmd_listas/senadores/listas_sen_gral2019.csv")



#### LEGISLATIVAS

files_gral2019_dip <- generales2019 %>%
  filter(!is.na(votos)) %>%
  filter(cat == "dip") %>%
  select(-cat) %>%
  mutate(prov = str_trim(str_to_lower(prov)),
         prov = str_replace_all(prov, " ", "_")) %>%
  group_by(prov) %>%
  nest()


files_gral2019_sen <- generales2019 %>%
  filter(!is.na(votos)) %>%
  filter(cat == "sen") %>%
  select(-cat) %>%
  mutate(prov = str_trim(str_to_lower(prov)),
         prov = str_replace_all(prov, " ", "_")) %>%
  group_by(prov) %>%
  nest()





# PROCESO Y GURADO RESULTADOS DIPUTADOS GENERALES 2019

archivos_dip_gral <- map(files_gral2019_dip$data, make_wider)

names(archivos_dip_gral) <-  c("chaco", "sfe" ,"caba",
                               "mendoza", "chubut" ,"corrientes",
                               "rioja", "pba" ,"catamarca",
                               "cordoba", "formosa" ,
                               "jujuy", "neuquen" ,"sjuan",
                               "sluis", "tucuman" ,"santiago",
                               "pampa", "rnegro","salta" ,"scruz",
                               "erios", "misiones","tdf" )


archivos_dip_gral %>%
  names(.) %>%
  map(~ write_csv(archivos_dip_gral[[.]], paste0("data/Elecciones_2019/", ., "_dip_gral2019.csv")))


# PROCESO Y GUARDO RESULTADOS GENERALES SENADORES 2019

archivos_sen_gral <- map(files_gral2019_sen$data, make_wider)

names(archivos_sen_gral) <-  c("chaco", "caba", "neuquen" ,
                               "santiago", "rnegro", "salta",
                               "erios",  "tdf" )


archivos_sen_gral %>%
  names(.) %>%
  map(~ write_csv(archivos_sen_gral[[.]], paste0("data/Elecciones_2019/", ., "_sen_gral2019.csv")))








