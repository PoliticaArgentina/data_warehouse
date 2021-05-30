## Repositorio de Datos de Política Argentina <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/polAr10-10-10.png?raw=true" width="200" align="right"/></a>

------------------------------------------------------------------------

### <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/geoAr.png?raw=true" width="100" align="left"/></a> [:package: {geoAr}](https://github.com/PoliticaArgentina/geoAr) - Datos *geo* Argentina:

El paquete incluye datos GIS con polígonos para ditintos niveles de unidades administrativas. Se incluyen versiones *raw* (más detalladas y pesadas) y versiones simplificadas. Se [documentó](https://github.com/PoliticaArgentina/data_warehouse/tree/master/geoAr/script) el proceso de simplificación.

-   Las geometrías de niveles de provincias, departamentos y radios censales fueron descargadas desde [el sitio del Instituto Nacional de Estadísiticas y Censos](https://sitioanterior.indec.gob.ar/codgeo.asp). Los mismos corresponden a la cartografía utilizada en el marco del *Censo Nacional de Población, Hogares y Viviendas 2010*.

-   Las grillas para visualizar los paneles de `ggplot2` como si fueran mapas de Argentina fueron diseñados como colaboración para el paquete `{geofacet}`. Como desarrollo propio esto se plasmó en `{geofaceteAR}`, cuya idea presentamos en la primera edición de LatinR ([Buenos Aires, 2018](https://github.com/LatinR/presentaciones-LatinR2018#geofaceting-argentina-slides--repositorio)).

    -   *LatinR: Geofaceting Argentina*

        [Abstract](https://github.com/TuQmano/geofacet_ARG/blob/master/.LatinR/Geofaceting_Argentina_RuizNicolini.pdf) \| :bar_chart: [Slides](https://www.researchgate.net/publication/327382101_Geofaceting_Argentina_LatinR_2018) \| :package: [{geofaceteAR}](https://github.com/electorArg/geofaceteAR) \| :keyboard: [blogpost](https://www.tuqmano.com/2020/05/22/empaquetar/).

------------------------------------------------------------------------

## <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/opinAr.PNG?raw=true" width="100" align="left"/></a> [:package: {opinAr}](https://github.com/PoliticaArgentina/opinAr) - Datos de opinión púbica de Argentina:

Los datos corresponden al relevamiento que la Universidad Torcuato Di Tella realiza para su *Índice de Confianza en el Gobierno* (ICG).

**Índice de Confianza en el Gobierno**

> *El ICG tiene como objetivo medir la evolución de la opinión pública respecto de la labor que desarrolla el gobierno nacional. Está diseñado de forma de captar lo que los ciudadanos piensan respecto de aspectos esenciales del gobierno nacional, a partir de la estimación de cinco dimensiones:*

> *La imagen o evaluación general del gobierno.*

> *La percepción sobre si se gobierna pensando en el bien general o en el de sectores particulares.*

> *La eficiencia en la administración del gasto público.*

> *La honestidad de los miembros del gobierno.*

> *La capacidad del gobierno para resolver los problemas del país.*

-   El índice se presenta en una escala que varía entre un mínimo de 0 y un máximo de 5.

**Para mayor información:**

-   acceder al sitio <https://www.utdt.edu/icg>

-   para consultas sobre el índice, dirigirse a los profesores Carlos Gervasoni ([cgervasoni\@utdt.edu](mailto:cgervasoni@utdt.edu)) o Javier Zelaznik ([jzelaznik\@utdt.edu](mailto:jzelaznik@utdt.edu))

------------------------------------------------------------------------

## <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/legislAr.png?raw=true" width="100" align="left"/></a> [:package: {legislAr}](https://github.com/PoliticaArgentina/legislAr) - Datos legislativos de Argentina:

Datos compartidos por Andy Tow en su proyecto [*La Década Votada*](https://andytow.com/scripts/disciplina/index-d.html) en cuya documentación se detallan las bases de datos disponibles.

------------------------------------------------------------------------

## <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/electorAr.png?raw=true" width="100" align="left"/></a> [:package: {electorAr}](https://github.com/PoliticaArgentina/opinAr) - Datos electorales de Argentina:

-   [**Escrutinios provisorios**](https://github.com/PoliticaArgentina/data_warehouse/blob/master/electorAr/data_raw/escrutinios_provisorios.md) de elecciones para cargos nacionales (presidente, diputados y senadores) desagregados a nivel de mesa electoral para elecciones entre 2003 y 2019. Los archivos originales sin procesar fueron obtenidos de la sección *Descargas* del [blog de Andy Tow](https://www.andytow.com/atlas/totalpais/downloads.html).

-   [**Resultados electorales**](https://github.com/PoliticaArgentina/data_warehouse/blob/master/electorAr/data_raw/escrutinios_definitivos.md) agregados de elecciones para cargos multinivel (nacionales y provinciales) entre 1946 y 2019. De descargaron todas las tablas disponibles en el [blog de Andy Tow](https://www.andytow.com/). Es un trabajo en progreso por el que se cuentan procesadas solamente elecciones para cargos ejecutivos (gobernadores y presidentes).

------------------------------------------------------------------------

# En proceso

------------------------------------------------------------------------

## <a><img src="https://github.com/politicaargentina/data_warehouse/blob/master/hex/discursAr.png?raw=true" width="100" align="left"/></a> :package: {discursAr} - Discursos presidenciales de Argentina:

-   **Discursos de Apertura de Sesiones Ordinarias**

-   **Discursos de Gestión** (Trabajo en proceso):

    -   Algunos discursos de Raul Alfonsín fueron recuperados del sitio [alfonsin.org](https://www.alfonsin.org/discursos/).

    -   Los de Nestor Kirchner de [cfkargentina.com](https://www.cfkargentina.com/category/nestor/discursos-nestor-2/discursos-2003-2007/).

    -   Los de Cristina Fernández de Kirchner del repositorio de [Martín Gaitán](https://github.com/mgaitan/discursos_cfk).

    -   Los de Mauricio Macri y Alberto Fernández descargados desde el sitio web de [casarosda.gob.ar](https://www.casarosada.gob.ar/informacion/discursos) basados en [código](https://github.com/DiegoKoz/discursos_presidenciales/blob/master/get_data.R) de Diego Kozlowski.

![](https://github.com/PoliticaArgentina/data_warehouse/raw/master/hex/collage.png)
