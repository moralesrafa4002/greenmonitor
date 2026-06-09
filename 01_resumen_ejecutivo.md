digraph ER {
    graph [rankdir=LR, labelloc="t", label="Modelo ER - GreenMonitor Local", fontsize=18, splines=ortho];
    node [shape=record, fontname="Arial", fontsize=9];
    edge [fontname="Arial", fontsize=8];
    zona [label="{zona_invernadero|PK id_zona\lnombre\ltipo_zona\ldescripcion\lubicacion_referencia\lactiva\l}"];
    sensor [label="{sensor|PK id_sensor\lFK id_zona\lcodigo_sensor\ltipo_sensor\lunidad_medida\lactivo\l}"];
    fuente [label="{fuente_datos|PK id_fuente\lnombre_fuente\ltipo_fuente\lurl_referencia\ldescripcion\l}"];
    registro [label="{registro_ambiental|PK id_registro\lFK id_zona\lFK id_sensor\lFK id_fuente\lfecha_hora\ltemperatura_c\lhumedad_relativa_pct\lhumedad_suelo_pct\lradiacion_solar_wm2\lindice_uv\lestado_ventilacion\lobservaciones\l}"];
    regla [label="{regla_negocio|PK id_regla\lnombre_regla\lvariable_evaluada\loperador\lvalor_umbral\lseveridad\lactiva\l}"];
    alerta [label="{alerta|PK id_alerta\lFK id_registro\lFK id_regla\lfecha_hora_alerta\lseveridad\lmensaje\lestado_alerta\l}"];
    usuario [label="{usuario_sistema|PK id_usuario\lnombre\lrol\lusuario_login\lactivo\l}"];
    bitacora [label="{bitacora_acceso|PK id_bitacora\lFK id_usuario\lfecha_hora\laccion\ldetalle\l}"];
    esth [label="{estadistica_horaria|PK id_estadistica_horaria\lFK id_zona\lfecha\lhora\ltemperatura_promedio\lhumedad_promedio\ltotal_registros\l}"];
    estd [label="{estadistica_diaria|PK id_estadistica_diaria\lFK id_zona\lfecha\ltemperatura_promedio\lhumedad_promedio\ltotal_registros\l}"];
    zona -> sensor [label="1 a N"];
    zona -> registro [label="1 a N"];
    sensor -> registro [label="1 a N"];
    fuente -> registro [label="1 a N"];
    registro -> alerta [label="1 a N"];
    regla -> alerta [label="1 a N"];
    usuario -> bitacora [label="1 a N"];
    zona -> esth [label="1 a N"];
    zona -> estd [label="1 a N"];
}
