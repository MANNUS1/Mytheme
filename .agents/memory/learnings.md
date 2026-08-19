# Lecciones Aprendidas y Axiomas Técnicos

Registro de principios universales y sus ejemplos concretos para evitar regresiones y re-depuraciones.

---

### [Axioma de Desacople de Arrastre en Electron]: En aplicaciones frameless, cualquier elemento interactivo dentro de una zona arrastrable debe declarar explícitamente la exención de drag y la captura de puntero.
- **Ejemplo concreto:** Los botones y pestañas en cabeceras de paneles (`.mod-sidedock .workspace-tab-header-container *`, `.clickable-icon`) requieren `-webkit-app-region: no-drag !important; pointer-events: auto !important;` para que los clics no sean secuestrados por el gestor de ventanas del sistema operativo.

---

### [Axioma de Contexto de Apilamiento (Stacking Context)]: La aplicación de filtros de composición (como `backdrop-filter`) crea un nuevo contexto de apilamiento aislado que atrapa a sus descendientes y solapa elementos flotantes hermanos.
- **Ejemplo concreto:** Al usar paneles acrílicos flotantes con `backdrop-filter: blur()`, los menús contextuales globales (`.menu`) y popovers (`.popover.hover-popover`) deben elevarse explícitamente a `z-index: 9999 !important;` para no quedar renderizados detrás del panel.

---

### [Axioma de Neutralización de Capas Colapsadas]: Los elementos animados fuera de pantalla o con opacidad cero siguen interceptando eventos del ratón a menos que se revoque su visibilidad y detección de puntero en el árbol de renderizado.
- **Ejemplo concreto:** En transiciones de paneles laterales colapsados (`.mod-sidedock.is-sidedock-collapsed`), además de `transform: translateX(...)` y `opacity: 0`, es obligatorio aplicar `visibility: hidden !important; pointer-events: none !important;` para evitar muros invisibles que bloqueen el editor de notas.

---

### [Axioma de Expansión de Contenedor Flexible]: Al desacoplar un elemento adyacente del flujo normal (ej. pasar un sidebar a `position: absolute`), el contenedor flex principal debe asumir el 100% de la base disponible para evitar colapso de viewport.
- **Ejemplo concreto:** El espacio de trabajo central (`.workspace-split.mod-root`) requiere `flex: 1 1 100% !important; width: 100% !important; max-width: 100% !important;` para que no queden huecos vacíos cuando el sidebar flota.

---

### [Axioma de Inmutabilidad de Artefactos Compilados]: Los archivos resultantes de un pipeline de build (ej. Sass, Nix) nunca deben ser editados directamente en origen.
- **Ejemplo concreto:** `theme.css` es un artefacto de compilación; cualquier modificación manual será pisada por `dart-sass`. Toda fuente de verdad reside en `src/*.scss`.
