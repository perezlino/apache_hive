/*  PROPIEDAD PARALLELLISM
    ======================

    Vamos a explicar cómo conseguir paralelismo en Hive. Utilizar los recursos de forma paralela es siempre una buena 
    técnica de optimización para ahorrar nuestro tiempo. Hive también nos proporciona la característica de "parallelism" 
    para ejecutar múltiples consultas independientes paralelamente. Como en este ejemplo, se puede ver que estamos 
    joineando dos conjuntos de datos de dos tablas diferentes. Una cosa a notar, no estamos simplemente seleccionando 
    toda la tabla en la condición de join, más bien estamos seleccionando una porción de datos de ambas tablas, y luego 
    joineando. Aquí, lo primero es que estamos seleccionando una parte de los datos de esta tabla; "air_travel_booking", 
    y luego estamos seleccionando la segunda parte de los datos de esta tabla "aire_travel_origins". Toda esta consulta 
    se puede dividir en tres etapas. Primera etapa, en la que se seleccionan los datos de la tabla_1. Etapa dos, donde 
    los datos se seleccionan de la tabla_2. Y la etapa final, en la que ambos conjuntos de datos se unen en función de 
    una condición. Ahora, como puedes ver, la etapa uno y la etapa dos son independientes entre sí, porque están 
    seleccionando los datos de diferentes tablas. En condiciones normales, cuando no se aplica el paralelismo, la etapa 
    uno se completará primero, y luego la etapa dos, y finalmente la etapa tres. Pero esto es una pérdida de tiempo, ya 
    que podemos ejecutar paralelamente la etapa uno y la etapa dos. Así que para lograr el paralelismo, tenemos que 
    establecer una propiedad a true. Es: 
    
                                            set hive.exec.parallel = true;
    
    Por defecto, esta propiedad es falsa. Al establecer esta propiedad, Hive ejecutará automáticamente las etapas 
    independientes en paralelo. 

    Igual que todas las opciones, el paralelismo también tiene desventajas. Por ejemplo si tenemos una consulta compleja 
    con múltiples etapas ejecutándose en una base de datos, donde la propiedad de paralelismo puede aumentar nuestra 
    eficiencia, pero también puede crear bloqueos en la base de datos, lo que puede detener otros procesos que se estén 
    ejecutando en la misma base de datos durante un tiempo de su propia ejecución. Así que para evitar ese bloqueo, no 
    debemos usar siempre el paralelismo, y deberíamos usarlo con mucho cuidado.