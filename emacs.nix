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
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable; 

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

      # Matrix client
      ement

      # Multimedia
      emms

      # Window manager & Xwidgets
      exwm
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

      ;; "SPC" bindings
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

      ;; --- Ement.el (Matrix Client) ---
      (require 'ement)

      ;; --- EMMS (Emacs Multimedia System) ---
      (require 'emms-setup)
      (emms-all)
      (setq emms-player-list '(emms-player-mpv))
      (setq emms-info-functions '(emms-info-native))

      ;; --- EXWM (Emacs X Window Manager) ---
      (require 'exwm)
      (require 'exwm-config)
      ;; Set workspace count
      (setq exwm-workspace-number 4)
      ;; Make class name the buffer name
      (add-hook 'exwm-update-class-hook
                (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
      ;; Global keybindings for EXWM
      (setq exwm-input-global-keys
            `(([?\s-r] . exwm-reset)
              ([?\s-w] . exwm-workspace-switch)
              ,@(mapcar (lambda (i)
                          `(,(kbd (format "s-%d" i)) .
                            (lambda () (interactive)
                              (exwm-workspace-switch-create ,i))))
                        (number-sequence 0 9))))
      ;; Line-mode keybindings (passthrough to Emacs)
      (setq exwm-input-simulation-keys
            '(([?\C-b] . [left])
              ([?\C-f] . [right])
              ([?\C-p] . [up])
              ([?\C-n] . [down])
              ([?\C-a] . [home])
              ([?\C-e] . [end])))

      ;; --- EXWM & Media helpers ---

      ;; Video helper: Launch mpv as an EXWM window
      (defun nixmacs-watch-video (file)
        "Watch a video file in mpv (embedded via EXWM)."
        (interactive "fVideo file: ")
        (start-process "mpv" nil "mpv" file))

      ;; Xwidget video helper (if supported by build)
      (defun nixmacs-xwidget-play-video (url)
        "Play a video URL in an xwidget-webkit buffer."
        (interactive "sVideo URL: ")
        (condition-case nil
            (let ((buf (xwidget-webkit-new-session url)))
              (message "Playing video in xwidget buffer: %s" url))
          (error (message "Xwidgets not supported in this build. Try EXWM watch-video instead."))))

      ;; SPC m bindings
      (my-leader-def
        "m"  '(:ignore t :which-key "media")
        "mv" '(nixmacs-watch-video :which-key "watch video (EXWM/mpv)")
        "mw" '(nixmacs-xwidget-play-video :which-key "watch URL (Xwidget)"))

      (exwm-enable)
    '';
  };
}
