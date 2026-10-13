# MEMORIA EJERCICIO `productes_cli`

En el siguiente enlace se poádr comprobar el estado en el que se encontraba el proyecto en cada fase de la práctica:

https://github.com/CCC-Programoeba/productes_cli/commits/main/

------------------------------

# Respuestas a las preguntas de cada parte de la práctica

## Pràctica 01

### ¿Qué sabe todavía App sobre el archivo?

App ha creado en `llistaEntrants` todo del archivo, para no consuktarlo a cada vez.

### Si cambiamos el origen de los datos, ¿qué clase habría que modificar?

`class App`, la funcion `carregar`.

------------------------------

## Pràctica 02

### Diagrama amb l'obtenció de la informació, el model (entitas) i la presentació

Si los args son validos, nos lleva a app, donde con `carregar`, mediante `ProductesRepository`, leemos el json y lo convierto en una list de maps, de objetos `Entrant`.

Una vez cargado, ejectua el `show` o el `list`, segun le hayamos dicho.

Archivo JSON
    -> ProductesRepository
        -> List<Entrant>
            -> App
                -> Pantalla

### Veieu alugun problema amb que App consturisca el repositori, i que aquest conega els detalls d'implementació del fitxer? Què passaria si les dades provingueren d'altre lloc o d'altre fitxer?

Si se cambia la forma de obtener los datos, habría que modificar estas clases y además también ProductesRepository

------------------------------

## Pràctica 03

### Recorregut complet d'una consulta HTTP fins a la pantalla

La HTTP empieza en App, que pide los productos a `ProductesRepository`.

`ProductesRepository` llama a `ApiService.llegirProductes()`.

`ApiService` hace una petición GET con `http.Client`, que recibe la respuesta en bytes y la convierte a texto mediante UTF-8.

Después `jsonDecode` transforma el JSON en una lista de mapas.

El repositorio recibe esos mapas y utiliza `mapEntrant` para convertir cada uno en un objeto `Entrant`.

Finalmente, App guarda la lista de `Entrant` y la muestra por pantalla.

### Pruebas de errores

Capturas de pantalla guardadas de momento de los distintos errrores con los fallos deliberados en la URL.
(Añadir, están en Desktop)

### ¿Qué clase todavía decide el origen y por qué querríamos tomar esta decisión desde el programa principal?

`class ProductesRepository` es ahora la encargada de decidir (si comentamos/descomentamos una linea u otra).

Seria preferible hacerlo desde un menu principal y que el user elija el origen.

------------------------------

## Pràctica 04

### En què es diferencien servei, repositori i entitat?

#### Servicio
El servicio obtiene los datos desde una fuente , como un fichero (JSON), una API o memoria.
#### Repositorio
El repositorio utiliza el servicio y transforma los datos recibidos en entidades.
#### Entidad
La entidad representa los datos del dominio, en este caso un producto Entrant 
 
### Per què no retornem JSON a App?

Porque recibe directamente:

```dart
List<Entrant>
```

A App en ésta parte (y es mejor así) le llega la información como la necesita, sin que sepa (porque no lo nceesita) de donde viene (JSON, XML, CSV...; ya sea archivo local o ajena).

### Com afegiríeu una quarta font?

De la misma manera que hemos añadido `ApiService` o `TestService`: creando un nuevo servicio que implemente:

```dart
implements ProductesService
```

### Què caldria adaptar si el format de la quarta font fora diferent?

Habría que adaptar el servicio que se ocupa de ello al mimso formato que los JSON en éste ejercico:

```dart
List<Map<String, dynamic>>
```

Ya sea XML, CSV o cualquiera, debe convertirse a una List para `ProductesRepository`.

### Quina decisió hem traslladat del repositori a main i per què?

Al `main` hemos trasladado (en ésta parrte 4) la decisión de qué fuente usar.

Antes en el 3 ésa decisión la tomabamos en el `ProductesRepository`.

Ahora el servicio nos da, independientementte de su origen, lo que necesitams para nuestro repositorio.
