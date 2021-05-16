# Repositorio de Datos de Política Argentina <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/polAr10-10-10.png?raw=true" width="200" align="right" /></a>


---

## {geoAr} <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/geoAr.png?raw=true" width="50" align="right" /></a>


* Las geometrías acá dosponibilizadas fueron descargados desde [el sitio del Instituto Nacional de Estadísiticas y Censos](https://sitioanterior.indec.gob.ar/codgeo.asp). Los mismos corresponden a la cartografía utilizada en el marco del _Censo Nacional de Población, Hogares y Viviendas 2010_. 

* Las grillas para visualizar los paneles de `ggplot2` como si fueran mapas de Argentina fueron diseñados como colaboración para el paquete `{geofacet}`. Como desarrollo propio esto se plasmó en  `{geofaceteAR}`, cuya idea presentamos en la primera edición de LatinR ([Buenos Aires, 2018](https://github.com/LatinR/presentaciones-LatinR2018#geofaceting-argentina-slides--repositorio)). 


> **LatinR: Geofaceting Argentina**

> [Abstract](https://github.com/TuQmano/geofacet_ARG/blob/master/.LatinR/Geofaceting_Argentina_RuizNicolini.pdf) | 📊 [Slides](https://www.researchgate.net/publication/327382101_Geofaceting_Argentina_LatinR_2018) | 📦 [{geofaceteAR}](https://github.com/electorArg/geofaceteAR) | ⌨️ [blogpost](https://www.tuqmano.com/2020/05/22/empaquetar/).


---

## {opinAr} <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/opinAr.png?raw=true" width="50" align="right" /></a>

Los datos corresponden al relevamiento que la Universidad Torcuato Di Tella realiza para su _Índice de Confianza en el Gobierno_ (ICG). 

**Índice de Confianza en el Gobierno**

> _El ICG tiene como objetivo medir la evolución de la opinión pública respecto de la labor que desarrolla el gobierno nacional. Está diseñado de forma de captar lo que los ciudadanos piensan respecto de aspectos esenciales del gobierno nacional, a partir de la estimación de cinco dimensiones:_

> _*La imagen o evaluación general del gobierno._

> _*La percepción sobre si se gobierna pensando en el bien general o en el de sectores particulares._

> _*La eficiencia en la administración del gasto público._

> _*La honestidad de los miembros del gobierno._

> _*La capacidad del gobierno para resolver los problemas del país._

* El índice se presenta en una escala que varía entre un mínimo de 0 y un máximo de 5.


**Para mayor información:**

* acceder al sitio <https://www.utdt.edu/icg>

* para consultas sobre el índice, dirigirse a los profesores Carlos Gervasoni (cgervasoni@utdt.edu) o Javier Zelaznik (jzelaznik@utdt.edu)

## {legislAr} <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/legisAr.png?raw=true" width="50" align="right" /></a>

Datos compartidos por Andy Tow en su proyecto [_La Década Votada_](https://andytow.com/scripts/disciplina/index-d.html) en cuya documentación se detallan las bases de datos disponibles.

---

# En proceso

## {discursAr} <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/discursAr.png?raw=true" width="50" align="right" /></a>

### Facilitar el acceso a datos de discursos presidenciales: 

* **Discursos de Apertura de Sesiones Ordinarias**

* **Discursos de Gestión** (Trabajo en proceso): 

  - Algunos discursos de Raul Alfonsín fueron recuperados del sitio [alfonsin.org](https://www.alfonsin.org/discursos/). 

  - Los de Nestor Kirchner de [cfkargentina.com](https://www.cfkargentina.com/category/nestor/discursos-nestor-2/discursos-2003-2007/). 

  - Los de Mauricio Macri y Alberto Fernández descargados desde el sitio web de [casarosda.gob.ar](https://www.casarosada.gob.ar/informacion/discursos) basados en  [código](https://github.com/DiegoKoz/discursos_presidenciales/blob/master/get_data.R) de Diego Kozlowski. 

---

## {electorAr} <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/electorAr.png?raw=true" width="50" align="right" /></a>

* Datos electorales de Argentina: 

  - **Escrutinios provisorios** de elecciones para cargos nacionales (presidente, diputados y senadores) desagregados a nivel de mesa electoral para elecciones entre 2003 y 2019. Los archivos originales sin procesar fueron obtenidos de la sección _Descargas_ del [blog de Andy Tow](https://www.andytow.com/atlas/totalpais/downloads.html).

