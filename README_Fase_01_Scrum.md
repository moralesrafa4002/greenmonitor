digraph UML {
    graph [rankdir=LR, labelloc="t", label="Diagrama UML de clases - GreenMonitor Local", fontsize=18];
    node [shape=record, fontname="Arial", fontsize=9];
    edge [fontname="Arial", fontsize=8];
    Zona [label="{ZonaInvernadero|+id_zona:int\l+nombre:str\l+tipo_zona:str\l+activa:bool\l}"];
    Sensor [label="{Sensor|+id_sensor:int\l+codigo_sensor:str\l+tipo_sensor:str\l+activo:bool\l}"];
    Fuente [label="{FuenteDatos|+id_fuente:int\l+nombre_fuente:str\l+tipo_fuente:str\l}"];
    Registro [label="{RegistroAmbiental|+id_registro:int\l+fecha_hora:datetime\l+temperatura_c:float\l+humedad_relativa_pct:float\l+humedad_suelo_pct:float\l+radiacion_solar_wm2:float\l+indice_uv:float\l+estado_ventilacion:str\l}"];
    Regla [label="{ReglaNegocio|+id_regla:int\l+variable_evaluada:str\l+operador:str\l+valor_umbral:float\l+evaluar(registro):bool\l}"];
    Alerta [label="{Alerta|+id_alerta:int\l+severidad:str\l+mensaje:str\l+estado_alerta:str\l}"];
    ServicioM [label="{ServicioMonitoreo|+guardar_registro(datos)\l+consultar_registros(filtros)\l+generar_estadisticas()\l}"];
    ServicioA [label="{ServicioAlertas|+evaluar_registro(registro)\l+crear_alerta(registro, regla)\l+listar_activas()\l}"];
    Repo [label="{RepositorioAmbiental|+insertar_registro(registro)\l+buscar_registros(filtros)\l+buscar_alertas_activas()\l}"];
    Zona -> Sensor [label="contiene"];
    Zona -> Registro [label="registra"];
    Sensor -> Registro [label="genera"];
    Fuente -> Registro [label="provee"];
    Registro -> Alerta [label="origina"];
    Regla -> Alerta [label="dispara"];
    ServicioM -> Repo;
    ServicioM -> ServicioA;
    ServicioA -> Regla;
    ServicioA -> Alerta;
}
