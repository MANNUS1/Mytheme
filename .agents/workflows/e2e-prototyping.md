---
name: e2e-prototyping
description: Flujo iterativo para prototipado en vivo (vía Devtools/CDP) sin mutar archivos hasta la fase final. Prioridad absoluta en rendimiento.
---

# Workflow: Prototipado en Vivo y Consolidación

> **PRIORIDAD CRÍTICA - RENDIMIENTO**: Cualquier código implementado debe estar altamente optimizado. Evita el "layout thrashing", usa selectores eficientes, prioriza propiedades aceleradas por GPU (como `opacity` y `transform`) sobre aquellas que causan repaints, y minimiza el impacto en CPU/RAM.

## Fase 1: Análisis Fantasma y Scope Lock
1. Acuerda las "N" features (MVP) y documéntalas en `/home/manu/Documents/MemorIA/02_Projects/Manutino/Plan.md`.
2. **Análisis Fantasma**: Usa el MCP de devtools para inspeccionar profundamente el DOM y simular interacciones ocultas (`hover`, `click`) para diagnosticar el bug computado en CSS antes de sugerir arreglos.
3. **STOP**: No avances hasta que el usuario apruebe el alcance en el `Plan.md`.

## Fase 2: Branch y Prototipado en Vivo
1. Crea tu rama: `git checkout -b feature/<nombre-corto>`.
2. Inicia la bóveda de pruebas en background con el puerto de depuración expuesto.
3. **Cero archivos físicos tocados**: Inyecta tu solución dinámica directamente en la memoria del navegador usando `evaluate_script` (devtools).
4. El usuario revisará los cambios visualmente de su lado y te guiará o enviará capturas de los selectores precisos desde su inspector.

## Fase 3: Feedback y Recolección
1. Itera inyectando ajustes al DOM según las instrucciones del usuario.
2. Con cada "Visto Bueno" parcial, **guarda el bloque de código exacto** que funcionó en el `Plan.md` y ponle "check" a la feature correspondiente.

## Fase 4: Consolidación Final
1. Únicamente cuando todas las N features tengan su "check" en el plan, procede a modificar los archivos reales (`.css`, `.ts`, etc.) del repositorio.
2. Trasplanta el código recolectado garantizando que las prioridades de **rendimiento** estricto se mantengan.

## Fase 5: Merge y Cierre
1. Pide el "Visto Bueno" final.
2. Ejecuta `git add`, `git commit` y `git merge` a la rama principal.
3. Cierra el ciclo actualizando el estatus en el `Plan.md`.
