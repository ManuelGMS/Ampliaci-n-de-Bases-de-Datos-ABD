-- Conociendo la tabla PLAN_TABLE

SELECT * FROM PLAN_TABLE; -- Todos los usuarios tienen esta tabla.

DELETE PLAN_TABLE; -- BORRA TODAS LAS FILAS DE PLAN_TABLE

EXPLAIN PLAN /*INTRO PLAN_TABLE*/ FOR /*QUERY*/; -- Por defecto el plan generado se guarda en la tabla PLAN_TABLE.

-- Forma autom�tica de mostrar un plan de ejecuci�n.

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

-- Forma manual de dar formato a un plan de ejecuci�n.

ttitle ' INFORME DEL PLAN ' -- Titulo del plan de ejecuci�n.

col operation   heading 'OPERACION' format a12 word_wrapped -- Operacion de bajo nivel que se realiza.
col options     heading 'OPCIONES' format a12 word_wrapped -- Modo en el que se ejecuta la operaci�n anterior.
col object_name heading 'TABLA'    format a12 word_wrapped -- Objeto del SGBDR.
col cost        heading 'Coste'    format a5 -- Coste en unidades de oracle ( Tambien existen CPU_COS y IO_COST ).
col cardinality heading 'Filas'    format a5 -- Estimaci�n de filas devueltas por esa operaci�n.
col parent_id   heading 'PADRE'    format a5 -- Identificador de la operaci�n padre.
col id          heading 'Id_Fila'  format a5 -- Identificador de la operaci�n.

-- Consulta ger�rquica para formar mostrar el arbol binario de que representa el plan de ejecuci�n.

select operation,options,object_name,cost,cardinality,parent_id,id 
from PLAN_TABLE
connect by prior id=parent_id    -- Cada nodo tiene un identficador y est� enlazado a un nodo padre.
start with id = 1                -- Comienza a formar el arbol por la operacion que tenga como id = 1
order by id; -- Ordena los nodos en el arbol por su identificador
