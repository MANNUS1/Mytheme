---
name: e2e-prototyping
description: Flujo de 3 fases para prototipado en vivo (CDP/DevTools), memoria axiomática y consolidación delegada a subagentes con Nix Flake.
---

# Workflow: Prototipado en Vivo, Memoria Axiomática y Delegación a Subagentes

> **REGLA DE ORO**: El 80% del éxito radica en el análisis previo. El agente orquestador lidera el análisis y prototipado visual con el usuario, mientras que la documentación de lecciones y la escritura/compilación final se delegan a subagentes especializados.

---

## Fase 1: Análisis Total (Agente Orquestador)

1. **Consulta de Memoria:**
   - Revisar [`.agents/memory/architecture.md`](file:///home/manu/Documents/repositorios/Others/Mytheme/.agents/memory/architecture.md) para ubicar el módulo exacto en `src/`.
   - Revisar [`.agents/memory/learnings.md`](file:///home/manu/Documents/repositorios/Others/Mytheme/.agents/memory/learnings.md) para respetar los axiomas técnicos conocidos (Electron, z-index, drag, flexbox).
2. **Contraste con el Repositorio:**
   - Buscar selectores existentes, variables de color/espaciado y reglas `@use` para no duplicar estilos.
3. **Inspección en Vivo (MCP DevTools / CDP):**
   - Inspeccionar el DOM real computado (`getBoundingClientRect`, `getComputedStyle`, clases de estado como `.is-sidedock-collapsed`).
   - Simular eventos (`hover`, `click`) para identificar restricciones de layout antes de proponer cambios.
4. **Scope Lock:**
   - Crear o actualizar el `PLAN.md` con las tareas atómicas en checkboxes (`[ ]`). No avanzar hasta tener el plan cerrado con el usuario.

---

## Fase 2: Prototipado en Caliente & Aprendizaje Axiomático Asíncrono

1. **Inyección en Memoria (Cero mutación de archivos):**
   - Inyectar soluciones dinámicas directamente en el DOM mediante DevTools (`evaluate_script`).
   - **Regla del Tag Único:** Usar siempre `<style id="agent-preview">...</style>` y reemplazar su contenido en cada prueba para no acumular basura de iteraciones anteriores.
2. **Validación Visual Directa:**
   - El usuario valida directamente en su pantalla física la interacción y estética en tiempo real.
3. **Registro y Check:**
   - Con cada aprobación parcial del usuario, marcar `[x]` en `PLAN.md` y recolectar el bloque CSS exacto que funcionó.
4. **Gestión de Errores y Subagente Sintetizador (Axioma > Inductivo):**
   - Si un prototipo no sale a la primera por un comportamiento oculto del framework/DOM:
     - El agente orquestador delega inmediatamente a un **Subagente Sintetizador** en background (`invoke_subagent`).
     - El subagente deduce el principio general, ubica la sección correcta y actualiza [`.agents/memory/learnings.md`](file:///home/manu/Documents/repositorios/Others/Mytheme/.agents/memory/learnings.md).
   - **Formato Axiomático Estricto:**
     ```markdown
     ### [Axioma / Principio General]: Regla universal que rige el comportamiento.
     - **Ejemplo concreto:** Selector o caso específico encontrado en Obsidian/Electron.
     ```

---

## Fase 3: Consolidación Delegada (Subagente Implementador)

Una vez completados y validados todos los checks de `PLAN.md` con el usuario:

1. **Delegación a Subagente Implementador:**
   - El agente orquestador dispara un **Subagente Implementador / Builder** (`invoke_subagent` con write tools) pasándole la carga útil:
     - Lista de archivos SCSS destino en `src/`.
     - Bloques de código CSS/SCSS validados en la Fase 2.
     - Mensaje para el commit.
2. **Ejecución y Compilación por el Subagente:**
   - Escribe quirúrgicamente los cambios en `src/*.scss`.
   - Ejecuta la compilación con Nix: `nix develop --command build-theme`.
   - Valida que `theme.css` se genere sin errores ni advertencias de compilación.
3. **Git Hygiene & Cierre:**
   - Revisa `git status` y `git diff` para asegurar cero efectos secundarios.
   - Realiza el commit semántico (ej. `feat(sidedock): add floating acrylic sidedock`).
   - Ejecuta `git push` y reporta el éxito de la operación al agente orquestador.
