# Gotchas y Lecciones Aprendidas (Learnings)

## 1. Modificación Quirúrgica vs Copia Ciega de Módulos
- **Error:** Al resolver el bloqueo de clicks por `-webkit-app-region: drag` en la barra superior, se importó el archivo entero de otro repositorio (`manutino`), lo cual sobrescribió el diseño visual ya aprobado de `Mytheme` (sustituyendo la tarjeta flotante redondeada con márgenes de 8px por un panel pegado al borde `top: 0`).
- **Regla Estricta:** Los bugs funcionales (clicks, drag, z-index) deben resolverse de forma **quirúrgica** sobre las reglas existentes. Jamás sobreescribir la geometría (`margin`, `border-radius`, `height`, `backdrop-filter`) de un diseño ya validado visualmente por el usuario.

## 2. Interferencia de `-webkit-app-region: drag` en Electron (Linux/Wayland/X11)
- **Problema:** En ventanas sin marco (*frameless*), los contenedores superiores (`.titlebar`, `.workspace-tab-header-container`) con `-webkit-app-region: drag` interceptan el clic físico a nivel de compositor del sistema operativo antes de que el DOM lo reciba.
- **Solución:** Aplicar de forma explícita `-webkit-app-region: no-drag !important;` y `pointer-events: auto !important;` en los elementos interactivos hijos (botones, iconos, pestañas).

## 3. Estabilidad Geométrica de Pestañas (Zero-Shift)
- **Problema:** Obsidian retira `.sidebar-toggle-button.mod-left` de la barra de pestañas al abrir el sidedock, lo que provoca un salto/parpadeo de `8px` a `40px` en las pestañas centradas.
- **Solución:** Posicionar el contenedor de pestañas con centrado absoluto (`position: absolute; left: 50%; transform: translateX(-50%)`) y anclar los botones laterales (`+`, lista, toggle derecho) con `margin-left: auto`, logrando 0.00px de desplazamiento entre estados abierto y cerrado.
