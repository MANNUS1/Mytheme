---
name: e2e-prototyping
description: Flujo iterativo para prototipado en vivo (vía Devtools/CDP) y desarrollo continuo con Nix Flake. Prioridad absoluta en rendimiento.
---

# Workflow: Prototipado en Vivo y Consolidación

> **PRIORIDAD CRÍTICA - RENDIMIENTO**: Cualquier código implementado debe estar altamente optimizado. Evita el "layout thrashing", usa selectores eficientes, prioriza propiedades aceleradas por GPU (como `opacity` y `transform`) sobre aquellas que causan repaints, y minimiza el impacto en CPU/RAM.

## Fase 1: Análisis Fantasma y Scope Lock
1. Acuerda las "N" features (MVP) y documéntalas en el plan de trabajo.
2. **Análisis Fantasma**: Usa el MCP de devtools para inspeccionar profundamente el DOM y simular interacciones ocultas (`hover`, `click`) para diagnosticar el bug computado en CSS antes de sugerir arreglos.
3. **STOP**: No avances hasta que el usuario apruebe el alcance del plan.

## Fase 2: Entorno y Prototipado en Vivo
1. **Branch:** Crea tu rama: `git checkout -b feature/<nombre-corto>`.
2. **Compilación Continua (Watch Theme):** Inicia el watcher en una ventana dedicada de tmux (`tmux new-window -n theme-watcher 'nix develop --command watch-theme'`):
   ```bash
   nix develop --command watch-theme
   ```
   *(Garantiza que cualquier cambio guardado en `src/` compile de inmediato a `theme.css` y se sincronice vía symlink en `/home/manu/Documents/repositorios/Dots/obsidian/template/.obsidian/themes/Mytheme`).*
3. **Bóveda de pruebas:** Inicia Obsidian con el puerto de depuración DevTools (CDP) expuesto.
4. **Prototipado en memoria:** Inyecta soluciones dinámicas directamente en memoria usando `evaluate_script` (devtools).
5. **Cero Screenshots / Latencia Cero:** Prohibido tomar capturas de pantalla automáticas. La retroalimentación se basa en métricas de DOM computadas (`getBoundingClientRect`, `getComputedStyle`) y la validación visual inmediata del usuario en su pantalla física.

## Fase 3: Feedback y Recolección
1. Itera inyectando ajustes al DOM según las instrucciones del usuario.
2. Con cada "Visto Bueno" parcial, **guarda el bloque de código exacto** que funcionó y marca "check" a la feature correspondiente.

## Fase 4: Consolidación Final
1. Procede a modificar los archivos reales dentro de `src/` (ej. `src/theme.scss`, `src/features/`, etc.).
2. El watcher compilará automáticamente `theme.css`.
3. Verifica que las prioridades de **rendimiento** estricto se mantengan.

## Fase 5: Merge y Cierre
1. Pide el "Visto Bueno" final.
2. Ejecuta `git add`, `git commit` (siguiendo Conventional Commits) y `git merge` a la rama principal.
3. Sincroniza con el repositorio remoto (`git push`).

