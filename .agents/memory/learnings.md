# Gotchas y Lecciones Aprendidas (Learnings)

## 1. Modificación Quirúrgica vs Copia Ciega de Módulos
- **Error:** Al resolver el bloqueo de clicks por `-webkit-app-region: drag`, se importó el archivo entero de otro repositorio (`manutino`), lo cual sobrescribió el diseño visual ya aprobado de `Mytheme` (sustituyendo la tarjeta flotante redondeada con márgenes de 8px por un panel pegado al borde `top: 0`).
- **Regla Estricta:** Los bugs funcionales (clicks, drag, z-index) deben resolverse de forma **quirúrgica** sobre las reglas existentes. Jamás sobreescribir la geometría (`margin`, `border-radius`, `height`, `backdrop-filter`) de un diseño ya validado visualmente por el usuario.

## 2. Interferencia de `-webkit-app-region: drag` en Electron (Linux/Wayland/X11)
- **Problema:** En ventanas sin marco (*frameless*), cuando el contenedor principal o la barra superior tiene `-webkit-app-region: drag`, el compositor del sistema operativo (GNOME/KDE) captura los clics como gestos de arrastre o maximización de ventana antes de que la aplicación web reciba el evento.
- **Solución:** Neutralizar el arrastre globalmente con `*, *::before, *::after { -webkit-app-region: no-drag !important; }` y reservar `drag` exclusivamente a los espaciadores vacíos (`.workspace-tab-header-spacer:not(.mod-sidedock *)`).

## 3. Estabilidad Geométrica de Pestañas (Zero-Shift)
- **Problema:** Obsidian retira `.sidebar-toggle-button.mod-left` de la barra de pestañas al abrir el sidedock, lo que provoca un salto/parpadeo de `8px` a `40px` en las pestañas centradas.
- **Solución:** Posicionar el contenedor de pestañas con centrado absoluto (`position: absolute; left: 50%; transform: translateX(-50%)`) y anclar los botones laterales (`+`, lista, toggle derecho) con `margin-left: auto`, logrando 0.00px de desplazamiento entre estados abierto y cerrado.
