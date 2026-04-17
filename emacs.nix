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
    mpv         # Media player backend for EMMS
    ffmpeg      # Metadata tools
    cava        # Audio visualizer backend
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
      
      # Completion & Navigation (Ivy stack)
      ivy
      counsel
      swiper
      ivy-posframe
      
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

      # Matrix client
      ement

      # Multimedia
      emms

      # Tree Explorer
      treemacs
      treemacs-evil
      treemacs-projectile
      treemacs-magit
      lsp-treemacs

      # Visualizers & Fun
      elcava
      fireplace
    ];

    extraConfig = ''
      ;; --- Config ---

      ;; --- Basic UI ---
      (setq inhibit-startup-message t)
      (scroll-bar-mode -1)        ; Disable visible scrollbar
      (tool-bar-mode -1)          ; Disable the toolbar
      (tooltip-mode -1)           ; Disable tooltips
      (set-fringe-mode 10)        ; Give some breathing room
      (menu-bar-mode -1)          ; Disable the menu bar

      ;; Transparency
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
      (setq dashboard-banner-logo-title " Helllooooo Alice!")
      (setq dashboard-startup-banner "/home/alice/nixmacs/assets/logo.png")
      (setq dashboard-items '((recents  . 5)
                              (projects . 5)))

      ;; --- Evil Mode Unholy ---
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

      ;; --- Ivy & Counsel (Navigation & Search) ---
      (require 'ivy)
      (ivy-mode 1)
      (require 'counsel)
      (counsel-mode 1)
      (require 'swiper)

      ;; --- Ivy-Posframe (Centered Whoom) ---
      (require 'ivy-posframe)
      (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
      (ivy-posframe-mode 1)

      ;; --- Projectile ---
      (require 'projectile)
      (projectile-mode +1)

      ;; --- Treemacs ---
      (require 'treemacs)
      (require 'treemacs-evil)
      (require 'treemacs-projectile)
      (require 'treemacs-magit)
      (require 'lsp-treemacs)
      (setq treemacs-no-png-images t) ;; use all-the-icons
      (treemacs-follow-mode t)
      (treemacs-filewatch-mode t)
      (treemacs-fringe-indicator-mode 'always)
      (setq treemacs-width 35)
      (setq treemacs-is-never-other-window t)
      (setq treemacs-silent-refresh t)
      (setq treemacs-silent-filewatch t)
      (when treemacs-python-executable
        (treemacs-git-commit-diff-mode t))

      ;; --- Keybindings (General.el) ---
      (require 'general)
      (general-evil-setup t)
      
      (general-create-definer my-leader-def
        :states '(normal visual insert emacs)
        :keymaps 'override
        :prefix "SPC"
        :global-prefix "C-SPC")

      ;; "SPC" bindings
      (my-leader-def
        "SPC" '(counsel-M-x :which-key "M-x")
        
        ;; Files
        "f"   '(:ignore t :which-key "files")
        "ff"  '(counsel-find-file :which-key "find file")
        "fs"  '(save-buffer :which-key "save file")
        "fr"  '(counsel-recentf :which-key "recent files")
        
        ;; Buffers
        "b"   '(:ignore t :which-key "buffers")
        "bb"  '(ivy-switch-buffer :which-key "switch buffer")
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

        ;; Trees / Explorer
        "e"   '(:ignore t :which-key "explorer")
        "ee"  '(treemacs :which-key "toggle treemacs")
        "ef"  '(treemacs-find-file :which-key "find current file")
        "ep"  '(treemacs-projectile :which-key "projectile tree")
        "es"  '(lsp-treemacs-symbols :which-key "lsp symbols")
        "ei"  '(lsp-treemacs-implementations :which-key "lsp implementations")
        "er"  '(lsp-treemacs-references :which-key "lsp references")
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

      ;; --- Ement.el (Matrix Client) ---
      (require 'ement)

      ;; --- EMMS (Emacs Multimedia System) ---
      (require 'emms-setup)
      (emms-all)
      (setq emms-player-list '(emms-player-mpv))
      (setq emms-info-functions '(emms-info-native))

      ;; --- Media helpers (External Window) ---
      (defun nixmacs-watch-video (file)
        "Watch a video file in mpv (external window)."
        (interactive "fVideo file: ")
        (start-process "mpv" nil "mpv" file))

      ;; SPC m v to watch video
      (my-leader-def
        "m"  '(:ignore t :which-key "media")
        "mv" '(nixmacs-watch-video :which-key "watch video (mpv)"))
      ;; --- Visualizers & Fun ---
      (require 'elcava)
      (setq elcava-executable "cava")
      
      (require 'fireplace)

      ;; --- Keybindings for visualizers ---
      (my-leader-def
        "a"   '(:ignore t :which-key "apps/fun")
        "av"  '(elcava :which-key "audio visualizer (elcava)")
        "af"  '(fireplace :which-key "cozy fireplace"))
    '';
  };
}
