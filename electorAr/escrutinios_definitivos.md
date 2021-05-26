# ESCRUTINIOS DEFINITIVOS

### Detalle del proceso de obtención y revisión de la info.

1. Usando [Selenium](https://github.com/SeleniumHQ/Selenium), se armó un *crawler* que navegaba de manera automatizada por todas las entradas del [Atlas Electoral de Andy Tow](https://www.andytow.com/atlas/totalpais/index.html) recopilando los HTMLs *crudos* de las tablas de elecciones.
   * La herramienta accedía, uno por uno, a los detalles de cada distrito (/buenosaires, /capital, /catamarca, etc.) y registraba los links a los resultados de elecciones presentes para dicho distrito.
   * En una segunda instancia, se abrían una a una las tablas de cada elección y se descargaba el HTML completo de la página.
   * Los archivos quedaban descargados en carpetas por distrito, con un nombre del tipo ```distritos/{distrito}/{eleccion}.html```
2. Usando [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/) se extrajeron las tablas (elementos ```<table>```) de los HTML descargados anteriormente.
   * La librería permite *buscar* elementos utilizando [selectores de CSS](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#css-selectors). En este caso se utilizó uno que buscaba el primer ```<table>``` dentro de un determinado ```<div>```.
   * La mayoría de los archivos tenía la misma estructura, por lo que se pudo usar un mismo *selector* válido en casi todos los casos. Sin embargo, algunos de estos archivos HTML  tenían una estructura distinta y requirieron un tratamiento casi individual para extraer la tabla de resultados.
   * Los archivos de las tablas quedaban guardados con en el mismo directorio del archivo original, con un "_table" agregado al final del nombre del archivo; ```{eleccion}_table.html```

```python
soup_eleccion.select("div.wrapper2 > div > div > table")[0]
```

3. Ya con los HTMLs de tablas, se utilizó código de [ConvertCSV.com](https://www.convertcsv.com/) para generar archivos CSV, que pueden ser leídos por R y otras aplicaciones con más facilidad.
   * Se adaptó el código de la herramienta [HTML Table to CSV/Excel Converter](https://www.convertcsv.com/html-table-to-csv.htm) para que corriera en una mini aplicación de Node.js. Esta aplicación leía archivos ```{eleccion}_table.html``` y generaba archivos ```{eleccion}_table.csv```.

4. De aquí en adelante se trabajó principalmente con R. Se debían *parsear* los CSVs obtenidos hasta el momento, cosa no tan sencilla debido a la variedad de tipos de elecciones disponibles. Se generó un flujo que recorría todos los archivos de tablas ya generados, los analizaba, emprolijaba y renombraba.
5. Lo primero que se hacía era generar el nuevo nombre del archivo, consistente con la estructura de nombres ya presente en el repositorio.
   * Este nombre estaba formado de la siguiente manera: ```{distrito}_{categoria}_{round}{año}.csv```. Por ej., un archivo con este nombre: ```rionegro/elecciones/1951p_table.csv``` pasaba a llamarse ```rnegro_presi_gral1951.csv```
6. Luego se trataba de identificar la estructura de la tabla:
   * Por lo general, todas las tablas contaban con una columna para las **listas** y otra con el número de **votos**. [Ejemplo](htmls/distritos/chaco/elecciones/2003p_table.html)
   * Algunas tablas presentaban el detalle de **% de positivos** y **% de válidos** obtenidos por cada lista. [Ejemplo](htmls/distritos/chaco/elecciones/2013ps_table.html)
   * También había tablas con columnas con el número de **electores** conseguidos (por ej., las elecciones legislativas o las elecciones presidenciales por Colegio Electoral). [Ejemplo](htmls/distritos/chaco/elecciones/1994cc_table.html)
   * En las elecciones ejecutivas que presentaron *ballotage*, las tablas íncluían los resultados de ambas elecciones en distintas columnas. [Ejemplo](htmls/distritos/chaco/elecciones/2015p_table.html)
   * Una minoría de las tablas respondía al sistema de elecciones legislativas mixtas (Córdoba, Río Negro, San Juan y Santa Cruz). [Ejemplo](htmls/distritos/rionegro/elecciones/1991dp_table.html)
   * Otras tablas eran simplemente la lista de candidatos presentados a una elección, pero no contenían el número de votos obtenidos. (Estas tablas fueron ignoradas). [Ejemplo](htmls/distritos/mendoza/elecciones/2017dp.html)
7. El siguiente paso era *parsear* la tabla
   * Se extraía el valor de los **electores** hábiles (presente en una celda) y se lo colocaba en una columna con ese nombre.
   * Se quitaban las 2 primeras filas (vacías)
   * Se seleccionaban las 2 primeras columnas (**lista** y **votos**) y la de **electores**
   * Se renombraban las columnas.
8. Luego se emprolijaban las tablas:
   * Se transformaban todos los *strings* a *TitleCase* y se reemplazaban los NA por *0*s.
   * Se quitaban las filas de "alianzas" (aquellas que comenzaban por '-').
   * Se quitaban los datos de votos positivos, totales y válidos.
   * Se quitaban los datos de diferencia/compensación de actas.
   * Se transformaban los valores de **votos** y **electores** a números (*numeric*).
   * Se renombraban las filas de votos "anulados", "impugnados" y "recurridos" por "Votos Nulos".
  
* En los casos en que se quitaba información de las tablas (diferencia/compensación de actas, votos impugnados/recurridos, etc.), esto quedaba anotado [en un archivo](htmls/info_adicional.csv), de modo tal que fuera sencillo rastrear esa información en los archivos originales.


Este primer flujo de trabajo alcanzó a la mayoría de las tablas de elecciones. Con el correr del tiempo se fue agregando tratamiento especial para algunas tablas (como las de elecciones con *ballotage*, que generaban 2 archivos distintos, uno por cada elección).

Debido a su menor complejidad, las elecciones ejecutivas de estructura "normal" (columnas de **lista**, **votos** y **electores**) fueron las que menos errores produjeron y por lo tanto, las primeras en ser ubicadas en la carpeta de [escrutinios_definitivos](data/escrutinios_definitivos).