{
  description = "A declarative, Spacemacs-like Emacs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { self, nixpkgs, emacs-overlay }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in {
      # The Home Manager module (for users who want to import it naturally)
      homeManagerModules.default = import ./emacs.nix { inherit emacs-overlay; };

      # Standalone Emacs packages (for nix run, nix-shell, or macOS/non-NixOS devices!)
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ emacs-overlay.overlay ];
          };

          # Evaluate the HM module passively to extract configurations
          mod = (import ./emacs.nix { inherit emacs-overlay; }) { config = {}; pkgs = pkgs; lib = pkgs.lib; };
          
          # Extract user configuration
          emacsConfig = mod.programs.emacs.extraConfig;
          emacsPackages = mod.programs.emacs.extraPackages;
          lspPackages = mod.home.packages;

          # For macOS, use standard emacs. For Linux, use pgtk (or base emacs).
          baseEmacs = if pkgs.stdenv.isDarwin then pkgs.emacs else pkgs.emacs-pgtk;

          # Auto-load our extraConfig by dropping it into site-start.el in the site-lisp directory
          configPkg = pkgs.runCommand "nixmacs-config" {} ''
            mkdir -p $out/share/emacs/site-lisp
            cp ${pkgs.writeText "default.el" emacsConfig} $out/share/emacs/site-lisp/default.el
          '';

          # Build Emacs with our extraPackages + configPkg
          allEmacsPkgs = epkgs: (emacsPackages epkgs) ++ [ configPkg ];
          emacsWithConfig = (pkgs.emacsPackagesFor baseEmacs).emacsWithPackages allEmacsPkgs;

        in {
          default = pkgs.symlinkJoin {
            name = "nixmacs";
            paths = [ emacsWithConfig ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              # Wrap the emacs binary so it has access to the LSP executables AND explicitly loads the config
              wrapProgram $out/bin/emacs \
                --prefix PATH : ${pkgs.lib.makeBinPath lspPackages} \
                --add-flags "--load ${configPkg}/share/emacs/site-lisp/default.el"
            '';
          };
        }
      );
    };
}
