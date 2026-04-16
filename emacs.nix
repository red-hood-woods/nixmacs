{ emacs-overlay }:

{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    emacs-overlay.overlay
  ];

  home.packages = with pkgs; [
    clang-tools # C/C++ LSP (clangd)
    pyright     # Python LSP
    typescript-language-server # JS/TS LSP
    nixd        # Nix LSP
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk; 

    extraPackages = epkgs: with epkgs; [
      # Evil mode (Vim bindings)
      evil
      evil-collection
      
      # UI & Theming
      doom-themes
      doom-modeline
      all-the-icons # Note: run 'M-x all-the-icons-install-fonts' once in Emacs
      dashboard
      
      # Completion & Navigation (Modern Helm/Ivy alternative)
      vertico
      orderless
      marginalia
      consult
      corfu # In-buffer completion
      
      # Key discovery (like Spacemacs)
      which-key
      general
      
      # Project management & Git
      projectile
      magit
      
      # Syntax, LSP, and Language Support
      flycheck
      lsp-mode
      lsp-ui
      company
      treesit-grammars.with-all-grammars
      haskell-mode
      lsp-haskell
      nix-mode
      js2-mode
      typescript-mode
    ];

    extraConfig = ''
      ;; --- Spacemacs-like Declarative Config ---

      ;; --- Basic UI ---
      (setq inhibit-startup-message t)
      (scroll-bar-mode -1)        ; Disable visible scrollbar
      (tool-bar-mode -1)          ; Disable the toolbar
      (tooltip-mode -1)           ; Disable tooltips
      (set-fringe-mode 10)        ; Give some breathing room
      (menu-bar-mode -1)          ; Disable the menu bar

      ;; Transparency (90%)
      (set-frame-parameter nil 'alpha-background 90)
      (add-to-list 'default-frame-alist '(alpha-background . 90))

      ;; Line numbers
      (setq display-line-numbers-type 'relative)
      (global-display-line-numbers-mode t)

      ;; Theme
      (load-theme 'doom-one t)

      ;; Modeline
      (doom-modeline-mode 1)
      (setq doom-modeline-height 35)

      ;; Dashboard
      (require 'dashboard)
      (dashboard-setup-startup-hook)
      (setq dashboard-center-content t)
      (setq dashboard-items '((recents  . 5)
                              (projects . 5)))

      ;; --- Evil Mode (Vim bindings) ---
      (setq evil-want-integration t)
      (setq evil-want-keybinding nil)
      (setq evil-want-C-u-scroll t)
      (setq evil-want-C-i-jump t)
      (require 'evil)
      (evil-mode 1)

      (require 'evil-collection)
      (evil-collection-init)

      ;; --- Which-Key ---
      (require 'which-key)
      (which-key-mode)
      (setq which-key-idle-delay 0.3)

      ;; --- Vertico & Consult (Navigation & Search) ---
      (require 'vertico)
      (vertico-mode)
      
      (require 'marginalia)
      (marginalia-mode)

      (require 'orderless)
      (setq completion-styles '(orderless basic)
            completion-category-defaults nil
            completion-category-overrides '((file (styles partial-completion))))

      ;; --- Projectile ---
      (require 'projectile)
      (projectile-mode +1)

      ;; --- Keybindings (General.el) ---
      (require 'general)
      (general-evil-setup t)
      
      (general-create-definer my-leader-def
        :states '(normal visual insert emacs)
        :keymaps 'override
        :prefix "SPC"
        :global-prefix "C-SPC")

      ;; The Spacemacs "SPC" bindings
      (my-leader-def
        "SPC" '(execute-extended-command :which-key "M-x")
        
        ;; Files
        "f"   '(:ignore t :which-key "files")
        "ff"  '(find-file :which-key "find file")
        "fs"  '(save-buffer :which-key "save file")
        "fr"  '(consult-recent-file :which-key "recent files")
        
        ;; Buffers
        "b"   '(:ignore t :which-key "buffers")
        "bb"  '(consult-buffer :which-key "switch buffer")
        "bd"  '(kill-current-buffer :which-key "kill buffer")
        
        ;; Windows
        "w"   '(:ignore t :which-key "windows")
        "wl"  '(evil-window-right :which-key "right")
        "wh"  '(evil-window-left :which-key "left")
        "wj"  '(evil-window-down :which-key "down")
        "wk"  '(evil-window-up :which-key "up")
        "wv"  '(evil-window-vsplit :which-key "vsplit")
        "ws"  '(evil-window-split :which-key "split")
        "wd"  '(evil-window-delete :which-key "delete")
        
        ;; Projects
        "p"   '(:ignore t :which-key "projects")
        "pf"  '(projectile-find-file :which-key "find file in project")
        "pp"  '(projectile-switch-project :which-key "switch project")
        
        ;; Git
        "g"   '(:ignore t :which-key "git")
        "gs"  '(magit-status :which-key "magit status")
      )

      ;; --- Language Support (Haskell, Nix, C, Python, JS) ---
      (require 'haskell-mode)
      (add-hook 'haskell-mode-hook 'lsp)
      (add-hook 'haskell-literate-mode-hook 'lsp)

      (require 'nix-mode)
      (add-hook 'nix-mode-hook 'lsp)

      (add-hook 'c-mode-hook 'lsp)
      (add-hook 'c++-mode-hook 'lsp)
      
      (add-hook 'python-mode-hook 'lsp)

      (require 'js2-mode)
      (add-hook 'js2-mode-hook 'lsp)
      (require 'typescript-mode)
      (add-hook 'typescript-mode-hook 'lsp)
    '';
  };
}
