{
  description = "Mytheme Obsidian theme development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      targetVault = "/home/manu/Documents/repositorios/Dots/obsidian/template";
      themeDir = "${targetVault}/.obsidian/themes/Mytheme";

      buildTheme = pkgs.writeShellScriptBin "build-theme" ''
        set -e
        echo "🎨 Compilando SCSS para Mytheme..."
        sass src/theme.scss theme.css
        echo "✅ Compilación exitosa: theme.css generado."
      '';

      watchTheme = pkgs.writeShellScriptBin "watch-theme" ''
        echo "👀 Escuchando cambios en SCSS en tiempo real..."
        sass --watch src/theme.scss:theme.css
      '';

      installTheme = pkgs.writeShellScriptBin "install-theme" ''
        set -e
        REPO_DIR="$(pwd)"
        TARGET_DIR="${themeDir}"
        echo "🔗 Instalando symlink de Mytheme en el vault de pruebas..."
        mkdir -p "${targetVault}/.obsidian/themes"
        rm -rf "$TARGET_DIR"
        ln -sfn "$REPO_DIR" "$TARGET_DIR"
        echo "✅ Symlink creado: $TARGET_DIR -> $REPO_DIR"

        APPEARANCE_FILE="${targetVault}/.obsidian/appearance.json"
        if [ -f "$APPEARANCE_FILE" ]; then
          ${pkgs.jq}/bin/jq '.cssTheme = "Mytheme"' "$APPEARANCE_FILE" > "$APPEARANCE_FILE.tmp" && mv "$APPEARANCE_FILE.tmp" "$APPEARANCE_FILE"
          echo "✅ Tema activo configurado a 'Mytheme' en appearance.json"
        fi
      '';
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "obsidian-mytheme";
        version = "1.0.0";
        src = self;
        nativeBuildInputs = [ pkgs.dart-sass ];
        buildPhase = ''
          sass src/theme.scss theme.css
        '';
        installPhase = ''
          mkdir -p $out
          cp manifest.json theme.css $out/
        '';
      };

      apps.${system} = {
        build = {
          type = "app";
          program = "${buildTheme}/bin/build-theme";
        };
        watch = {
          type = "app";
          program = "${watchTheme}/bin/watch-theme";
        };
        install = {
          type = "app";
          program = "${installTheme}/bin/install-theme";
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.dart-sass
          pkgs.jq
          buildTheme
          watchTheme
          installTheme
        ];
      };
    };
}
