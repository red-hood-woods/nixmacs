{
  description = "nixmac";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { self, nixpkgs, emacs-overlay }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in {
  
      homeManagerModules.default = import ./emacs.nix { inherit emacs-overlay; };

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ emacs-overlay.overlay ];
          };

          mod = (import ./emacs.nix { inherit emacs-overlay; }) { config = {}; pkgs = pkgs; lib = pkgs.lib; };
          
          emacsConfig = mod.programs.emacs.extraConfig;
          emacsPackages = mod.programs.emacs.extraPackages;
          lspPackages = mod.home.packages;

          baseEmacs = if pkgs.stdenv.isDarwin then pkgs.emacs else pkgs.emacs-pgtk;

          configPkg = pkgs.runCommand "nixmacs-config" {} ''
            mkdir -p $out/share/emacs/site-lisp
            cp ${pkgs.writeText "default.el" emacsConfig} $out/share/emacs/site-lisp/default.el
          '';

          allEmacsPkgs = epkgs: (emacsPackages epkgs) ++ [ configPkg ];
          emacsWithConfig = (pkgs.emacsPackagesFor baseEmacs).emacsWithPackages allEmacsPkgs;

        in {
          default = pkgs.symlinkJoin {
            name = "nixmacs";
            paths = [ emacsWithConfig ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/emacs \
                --prefix PATH : ${pkgs.lib.makeBinPath (lspPackages ++ [ pkgs.mpv pkgs.ffmpeg ])} \
                --add-flags "--load ${configPkg}/share/emacs/site-lisp/default.el"
            '';
          };
        }
      );
    };
}
