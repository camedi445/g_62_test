## Correccion y modificación del codigo 
El codigo tenía varias malas practicas y en terminos generales estaban desordenados y dificiles de entender. 
El objetivo principal fue refactorizar el codigo de forma que fuera mas facil de entender que hace cada cosa y que estuvieran bien definidas. Para hacer esto se hicieron 2 cosas:

## 1. Aplicar Riverpod
## 2. Aplicar el patrón MVC

# ¿Que cambios concretos se hicieron?
Se crearon clases especificas para los pokemon y sus detalles, toda la logica para comunicarse con la API se implemento en un solo lugar, separada del resto. Se crearon controladores con Riverpod para la lista y detalles de los pokemon, por último, se implementaron pantallas con vistas simples. 