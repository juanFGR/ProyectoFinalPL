###ETSII ULL Grado de Informática-Asignatura: Procesadores de Lenguajes
###Práctica 8: Análisis de Ámbito en PL0

## Descripción
  * Modificar la práctica anterior y realizar las siguientes tareas:
  * El nodo PROCEDURE debe disponer de una tabla de símbolos en la que se almacenan todos las constantes, variables y procedimientos declarados en el mismo.
  * Existirá ademas una tabla de símbolos asociada con el nodo raíz que representa al programa principal.
  * Las declaraciones de constantes y variables no crean nodo, sino que se incorporan como información a la tabla de símbolos del procedimiento actual
  * Para una entrada de la tabla de símbolos sym["a"] se guarda que clase de objeto es: constante, variable, procedimiento, etc.
  * Si es un procedimiento se guarda el número de argumentos
  * Si es una constante se guarda su valor
  * Cada uso de un identificador (constante, variable, procedimiento) tiene un atributo declared_in que referencia en que nodo se declaró
  * Si un identificador es usado y no fué declarado es un error
  * Si se trata de una llamada a procedimiento (se ha usado CALL y el identificador corresponde a un PROCEDURE) se comprobará que el número de argumentos coincide con el número de parámetros declarados en su definición
  * Si es un identificador de una constante, es un error que sea usado en la parte izquierda de una asignación (que no sea la de su declaración)
  * Base de Datos:
    * Guarde en una tabla el nombre de usuario que guardó un programa. Provea una ruta para ver los programas de un usuario.
    * Un programa belongs_to un usuario. Un usuario has n programas. Vea la sección DataMapper Associations.
  * Use la sección issues del repositorio en GitHub para coordinarse así como para llevar un histórico de las incidencias y la forma en la que se resolvieron. Repase el tutorial Mastering Issues

##Desarrollo

Los lenguajes y herramientas más utilizados para el desarrollo del presente proyecto fueron: 

  * Heroku
  * Sinatra
  * Ruby
  * Jison
  * JavaScript
  * Oauth
  * DataMaper

## Enlaces

[Despliegue en Heroku](http://ambitopl0.herokuapp.com/)

[Test](http://ambitopl0.herokuapp.com/tests)

## Autores

  - Adrián González Martín [Ir a perfil](https://github.com/alu4073)
  - Sara Martín Molina [Ir a perfil](https://github.com/alu4102)

## Licencia

Este proyecto se distribuye bajo la licencia MIT. Para saber más, leer el fichero ['licenciaMIT']
