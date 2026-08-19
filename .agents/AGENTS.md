# Mytheme - Directrices para Agentes

## 1. Reglas Críticas de Desarrollo
- **Prohibido editar `theme.css` directamente:** Es un artefacto compilado. Cualquier cambio manual será sobreescrito.
- **Edición exclusiva en `src/`:** Todas las modificaciones de estilo, variables y estructura deben realizarse en los archivos SCSS dentro del directorio `src/` (ej. `src/theme.scss`, `src/features/`, etc.).

## 2. Entorno y Compilación (Nix Flake)
El proyecto utiliza Nix Flakes para gestionar las dependencias y scripts de compilación (`dart-sass`):

- **Compilar tema:**
  ```bash
  nix develop --command build-theme
  ```
  *(Dentro del devShell: `build-theme`)*

- **Modo Watch (desarrollo continuo):**
  ```bash
  nix develop --command watch-theme
  ```
  *(Dentro del devShell: `watch-theme`)*

- **Instalar en vault de prueba:**
  ```bash
  nix develop --command install-theme
  ```
  *(Dentro del devShell: `install-theme`)*

## 3. Workflows
Para prototipado en vivo mediante DevTools (CDP) e inyección en caliente sin mutar archivos antes de tiempo, consultar el flujo en:
- [`.agents/workflows/e2e-prototyping.md`](file:///home/manu/Documents/repositorios/Others/Mytheme/.agents/workflows/e2e-prototyping.md)

