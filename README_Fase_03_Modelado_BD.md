# Diagramas del proyecto

Este directorio contiene los diagramas obligatorios del proyecto en dos formatos:

- `codigo_mermaid/`: código editable para Mermaid.
- `codigo_dot/`: código editable para Graphviz DOT.
- `imagenes_png/`: imágenes listas para entregar.

## Diagramas incluidos

1. Diagrama de contexto.
2. DFD Nivel 0.
3. DFD Nivel 1.
4. Modelo ER.
5. Diagrama UML de clases.

## Cómo regenerar imágenes con Graphviz

```bash
dot -Tpng diagrams/codigo_dot/04_modelo_er.dot -o diagrams/imagenes_png/04_modelo_er.png
```
