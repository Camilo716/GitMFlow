# GitMFlow

Script para automatizar el proceso de migración de ramas en un repositorio Git. Facilita la creación de una nueva rama de desarrollo basada en una rama principal

> **✅Nota:** Este script no altera ninguna rama de trabajo actual, por ende, en caso de generarse cualquier tipo de error o conflicto durante la ejecución, simplemente se revertirán los cambios y nada del trabajo previo se verá afectado.

## El flujo que pretende automatizar es el siguiente

1. Identificar todos los commits que han sido guardados desde que se creó la rama con nuestros cambios, es decir, desde el commit que apunta hacia origin/RAMA_PRINCIPAL (Sin incluirlo) hasta el que apunta hacia RAMA_ACTUAL(Incluyendolo). (Sin incluir commits de merge).

2. Eliminar localmente RAMA_DESARROLLO, traerla actualizada desde origin/RAMA_DESARROLLO (Esto con el fin de no incluir cambios que aún no están aprobados en RAMA_PRINCIPAL) y posicionarse en ella.

3. Crear RAMA_CAMBIOS como una copia de RAMA_DESARROLLO una vez limpia y actualizada.

4. Traer a RAMA_CAMBIOS uno a uno todos los commits identificados en el paso 1.

5. Establecer origin/RAMA_DESARROLLO y enviar los nuevos cambios allí.

## Uso

1. clonar el repositorio

``` bash
git clone https://github.com/Camilo716/GitMFlow.git
```

2. Agregar valores necesarios a las variables de configuración ubicadas en el archivo config_file.sh. Ej:

``` bash
RAMA_ACTUAL="2023/master_cambiosIncreibles123123"
RAMA_CAMBIOS="2023/develop_cambiosIncreibles123123"
RAMA_PRINCIPAL="master"
RAMA_DESARROLLO="develop"
PROJECT_PATH="../Proyecto.Api"
```

3. Otorgar permisos de ejecución al archivo changes_to_develop.sh

``` bash
chmod +x changes_to_develop.sh
```

4. Ejecutar el script

``` bash
./changes_to_develop.sh
```
