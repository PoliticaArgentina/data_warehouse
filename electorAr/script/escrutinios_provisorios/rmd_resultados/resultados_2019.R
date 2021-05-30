
##### RESULTADOS ELECCIONES  2019

##### Consultas desde liberías de R con restulados



##### LIBRERIAS ####

library(tidyverse)


#### PASO ####

library(paso2019)

paso2019::categorias %>%
  as_tibble() %>%
  filter(str_detect(nombre_categoria, "Diputados Nacionales|Senadores Nacionales|Presidente")) %>%
  pull(nombre_categoria)


datos_seccion <- paso2019::votos %>% as_tibble() %>%
  ungroup() %>%
  left_join(mesas, by = "id_mesa") %>%
  # left_join(establecimientos, by = "id_establecimiento") %>%
  left_join(distritos, by ="id_distrito") %>%
  left_join(secciones, by = "id_seccion") %>%
  select(13:15)  %>%
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


datos_paso <- paso2019::votos %>% as_tibble() %>%
  left_join(mesas, by = "id_mesa") %>%
  # left_join(establecimientos, by = "id_establecimiento") %>%
  left_join(distritos, by ="id_distrito") %>%
  left_join(secciones, by = "id_seccion") %>%
  left_join(listas, by = "id_lista") %>%
  left_join(agrupaciones, by = "id_agrupacion") %>%
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
listas_presi <- datos_paso %>% filter(str_detect(nombre_categoria , "Presi"),
                                      !str_detect(nombre_meta_agrupacion, "BLANCO")) %>%
  select(parDenominacion = nombre_meta_agrupacion, vot_parCodigo = lista, codprov) %>%
  distinct() %>%
  mutate(vot_parCodigo = as.character(vot_parCodigo)) %>%
  rename(vot_proCodigoProvincia = codprov) %>%
  write_csv("scripts/rmd_listas/presidente/listas_presi_paso2019.csv")



datos_finales_paso <-  datos_paso %>%
  left_join(datos_seccion, by = c("codprov", "coddepto")) %>%
  select(codprov, prov, coddepto, depto, circuito = id_circuito, mesa = id_mesa,
          votos, categoria = nombre_categoria, lista) %>%
  mutate(lista = case_when(
            lista == "00102" ~ "blancos",
            T  ~ lista))


paso2019 <- datos_finales_paso %>%
  mutate(cat= case_when(
    str_detect(categoria, "Dip") ~ "dip",
    str_detect(categoria, "Sen") ~ "sen",
    str_detect(categoria, "Pres") ~ "presi"
  ),
  electores = 0,
  nulos = 0) %>%
  group_by(cat, prov) %>%
  ungroup() %>%
  select(-categoria) %>%
  print()



#listas %>% as_tibble() %>% filter(str_detect(nombre_lista, "VOTO")) #1443 VOTO EN BLANCO id_agrupacion 102




#EXPORTO RESULTADOS PRESIDENTE
paso2019 %>% filter(cat == "presi") %>%
  select(-prov, -cat) %>%
  filter(!is.na(votos)) %>%
  pivot_wider(id_cols = c(codprov, coddepto, depto, circuito , mesa, electores, nulos),
              names_from = lista,
              values_from = votos) %>%
  select(codprov, coddepto, depto, circuito, mesa, electores, nulos, blancos, everything()) %>%
  write_csv("data/00.PRESIDENCIAL/arg_presi_paso2019.csv")

# FUNCION PARA HACER WIDE LOS DATASETS
make_wider <- function(data = data){

  data %>%
    bind_rows() %>%
    pivot_wider(id_cols = c(codprov, coddepto, depto, circuito , mesa, electores, nulos),
                names_from = lista,
                values_from = votos) %>%
    select(codprov, coddepto, depto, circuito, mesa, electores, nulos, blancos, everything()) %>%
    mutate_if(is.numeric, funs(replace_na(., replace = 0)))

}


#### LEGISLATIVAS

files_paso2019_dip <- paso2019  %>%
  filter(!is.na(votos)) %>%
  filter(cat == "dip") %>%
  select(-cat) %>%
  mutate(prov = str_trim(str_to_lower(prov)),
         prov = str_replace_all(prov, " ", "_")) %>%
  group_by(prov) %>%
  nest()


files_paso2019_sen <- paso2019  %>%
  filter(!is.na(votos)) %>%
  filter(cat == "sen") %>%
  select(-cat) %>%
  mutate(prov = str_trim(str_to_lower(prov)),
         prov = str_replace_all(prov, " ", "_")) %>%
  group_by(prov) %>%
  nest()




# PROCESO Y GURADO RESULTADOS DIPUTADOS PASO 2019

archivos_dip <- map(files_paso2019_dip$data, make_wider)

names(archivos_dip) <-  c("chaco", "sfe" ,"caba",
 "mendoza", "chubut" ,"rioja",
 "pba", "catamarca" ,"cordoba",
 "corrientes", "formosa" ,"jujuy",
 "neuquen", "sjuan" ,"sluis",
 "tucuman", "salta" ,"santiago",
 "pampa", "rnegro" ,"scruz",
 "erios", "misiones" ,"tdf")


archivos_dip %>%
  names(.) %>%
  map(~ write_csv(archivos_dip[[.]], paste0("data/Elecciones_2019/", ., "_dip_paso2019.csv")))


# PROCESO Y GUARDO RESULTADOS PASO SENADORES 2019

archivos_sen <- map(files_paso2019_sen$data, make_wider)

names(archivos_sen) <-  c("chaco","caba", "neuquen", "salta", "santiago",
                          "rnegro", "erios" , "tdf" )


archivos_sen %>%
  names(.) %>%
  map(~ write_csv(archivos_sen[[.]], paste0("data/Elecciones_2019/", ., "_sen_paso2019.csv")))




#LISTAS DIPUTADOS
listas_dip <- datos_paso %>%
  filter(str_detect(nombre_categoria , "Dip"),
         !str_detect(nombre_meta_agrupacion, "BLANCO")) %>%
  select(parDenominacion = nombre_meta_agrupacion, vot_parCodigo = lista, codprov) %>%
  distinct() %>%
  mutate(vot_parCodigo = as.character(vot_parCodigo)) %>%
  rename(vot_proCodigoProvincia = codprov) %>%
  write_csv("scripts/rmd_listas/diputados/listas_dip_paso2019.csv")


#LISTAS SENADORES
listas_sen <- datos_paso %>%
  filter(str_detect(nombre_categoria , "Sen"),
         !str_detect(nombre_meta_agrupacion, "BLANCO")) %>%
  select(parDenominacion = nombre_meta_agrupacion, vot_parCodigo = lista, codprov) %>%
  distinct() %>%
  mutate(vot_parCodigo = as.character(vot_parCodigo)) %>%
  rename(vot_proCodigoProvincia = codprov) %>%
  write_csv("scripts/rmd_listas/senadores/listas_sen_paso2019.csv")



