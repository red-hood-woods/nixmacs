;;; flutterice-theme.el --- Theme inspired by Fluttershy palette -*- lexical-binding: t -*-

;; Copyright (C) 2025 

;; Author: Generated (Improved)
;; Version: 1.4
;; Package-Requires: ((emacs "24.1"))
;; Keywords: faces

;;; Commentary:

;; A Fluttershy-inspired color palette derived directly from source artwork:
;; - Rich Fluttershy Yellows for constants, types, and strings
;; - Soft & Bright Pinks for keywords, functions, and active selections
;; - Warm Peach & Deep Cocoa background/surface layers
;; - Clear visual separation across font-lock, UI, doom-modeline, and diff faces

;;; Code:

(deftheme flutterice "Theme using Fluttershy artwork color palette.")

(let* (;; Core Background & Surface Layers (Deep Cocoa Outline -> Warm Peach Wallpaper Bg)
       (bg "#1c1210")
       (surface "#261915")
       (surface-container-lowest "#140c0a")
       (surface-container-low "#20140f")
       (surface-container "#2b1d18")
       (surface-container-high "#38271f")
       (surface-container-highest "#47332a")
       (surface-variant "#59392f")

       ;; Base Text & Outlines
       (on-background "#fbe9de")
       (on-surface "#f6dfd0")
       (on-surface-variant "#dcb6a2")
       (outline-color "#b08b76")
       (outline-variant "#6b4c3d")
       (shadow "#0d0605")

       ;; Primary Accents - Fluttershy Mane Pink (wallpaper coral/rose pinks)
       (primary "#f2617a")                  ; Coral Mane Pink
       (primary-container "#8a2c40")        ; Deep Rose Container
       (on-primary "#3d0714")
       (on-primary-container "#ffdde3")
       (primary-fixed "#ff8fa3")            ; Vibrant Highlight Pink
       (primary-fixed-dim "#e0576f")

       ;; Secondary Accents - Fluttershy Coat Yellow (wallpaper butter yellow)
       (secondary "#f0d060")                ; Wallpaper Coat Yellow
       (secondary-container "#5c4a12")      ; Deep Yellow Container
       (on-secondary "#312702")
       (on-secondary-container "#fbecb8")
       (secondary-fixed "#f7dc86")          ; Bright Accent Yellow
       (secondary-fixed-dim "#c9ab4d")

       ;; Tertiary Accents - Wallpaper Peach Background Pop
       (tertiary "#eba98c")                 ; Wallpaper Peach
       (tertiary-container "#63382a")       ; Muted Terracotta Container
       (on-tertiary "#341a10")
       (on-tertiary-container "#ffdfcd")
       (tertiary-fixed "#ffc7a9")
       (tertiary-fixed-dim "#c08a6c")

       ;; Special States & Errors
       (err "#ff7a70")
       (err-container "#7f1410")
       (on-err "#3f0300")
       (on-err-container "#ffdad4")
       (success "#9fdca0")                  ; Soft Sage Green for contrast
       (success-container "#1e4a22")
       (on-success-container "#c6facb")

       ;; Inverse / Helpers
       (inverse-surface "#fbe9de")
       (inverse-on-surface "#261915")
       (inverse-primary "#a3273f")

       ;; ANSI Terminal Mappings
       (term0 "#38271f")
       (term1 "#ff7a70")
       (term2 "#f0d060")
       (term3 "#f7dc86")
       (term4 "#f2617a")
       (term5 "#ff8fa3")
       (term6 "#eba98c")
       (term7 "#fbe9de")
       (term8 "#6b4c3d")
       (term9 "#ff4f52")
       (term10 "#ffdc6b")
       (term11 "#ffedab")
       (term12 "#ff5c7d")
       (term13 "#ff7f97")
       (term14 "#ffc19f")
       (term15 "#ffffff"))

  (custom-theme-set-faces
   'flutterice
   ;; Basic faces
   `(default ((t (:background ,bg :foreground ,on-background))))
   `(cursor ((t (:background ,primary-fixed))))
   `(highlight ((t (:background ,surface-container-high))))
   `(region ((t (:background ,primary-container :foreground ,on-primary-container :extend t))))
   `(secondary-selection ((t (:background ,secondary-container :foreground ,on-secondary-container :extend t))))
   `(isearch ((t (:background ,secondary-fixed :foreground ,on-secondary :weight bold))))
   `(lazy-highlight ((t (:background ,secondary-container :foreground ,on-secondary-container))))
   `(vertical-border ((t (:foreground ,surface-variant))))
   `(border ((t (:background ,surface-variant :foreground ,surface-variant))))
   `(fringe ((t (:background ,surface :foreground ,outline-variant))))
   `(shadow ((t (:foreground ,outline-color))))
   `(link ((t (:foreground ,primary-fixed :underline t))))
   `(link-visited ((t (:foreground ,tertiary :underline t))))
   `(success ((t (:foreground ,success))))
   `(warning ((t (:foreground ,secondary-fixed))))
   `(error ((t (:foreground ,err))))
   `(match ((t (:background ,secondary-container :foreground ,on-secondary-container))))
   
   ;; Font-lock
   `(font-lock-builtin-face ((t (:foreground ,primary-fixed :weight bold))))
   `(font-lock-comment-face ((t (:foreground ,outline-color :slant italic))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,outline-variant :slant italic))))
   `(font-lock-constant-face ((t (:foreground ,tertiary-fixed :weight bold))))
   `(font-lock-doc-face ((t (:foreground ,on-surface-variant :slant italic))))
   `(font-lock-function-name-face ((t (:foreground ,primary :weight bold))))
   `(font-lock-keyword-face ((t (:foreground ,secondary-fixed :weight bold))))
   `(font-lock-string-face ((t (:foreground ,secondary))))
   `(font-lock-type-face ((t (:foreground ,tertiary :weight bold))))
   `(font-lock-variable-name-face ((t (:foreground ,on-surface))))
   `(font-lock-warning-face ((t (:foreground ,err :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,primary-fixed-dim))))
   `(font-lock-negation-char-face ((t (:foreground ,err))))

   ;; Show paren
   `(show-paren-match ((t (:background ,primary-container :foreground ,on-primary-container :weight bold))))
   `(show-paren-mismatch ((t (:background ,err-container :foreground ,on-err-container :weight bold))))
   
   ;; Standard Mode line
   `(mode-line ((t (:background ,surface-container-high :foreground ,on-surface :box nil))))
   `(mode-line-inactive ((t (:background ,surface :foreground ,on-surface-variant :box nil))))
   `(mode-line-buffer-id ((t (:foreground ,primary-fixed :weight bold))))
   `(mode-line-emphasis ((t (:foreground ,secondary-fixed :weight bold))))
   `(mode-line-highlight ((t (:foreground ,primary :box nil))))
   
   ;; Doom Modeline
   `(doom-modeline-bar ((t (:background ,primary-fixed))))
   `(doom-modeline-inactive-bar ((t (:background ,surface-variant))))
   `(doom-modeline-panel ((t (:background ,surface-container-high :foreground ,on-surface))))
   `(doom-modeline-buffer-file ((t (:foreground ,primary-fixed :weight bold))))
   `(doom-modeline-buffer-path ((t (:foreground ,on-surface-variant))))
   `(doom-modeline-buffer-project-root ((t (:foreground ,tertiary-fixed))))
   `(doom-modeline-buffer-modified ((t (:foreground ,secondary-fixed :weight bold))))
   `(doom-modeline-buffer-major-mode ((t (:foreground ,secondary-fixed :weight bold))))
   `(doom-modeline-project-dir ((t (:foreground ,tertiary-fixed :weight bold))))
   `(doom-modeline-info ((t (:foreground ,secondary-fixed))))
   `(doom-modeline-warning ((t (:foreground ,secondary-fixed-dim))))
   `(doom-modeline-urgent ((t (:foreground ,err :weight bold))))
   `(doom-modeline-unread-number ((t (:foreground ,primary-fixed))))
   `(doom-modeline-host ((t (:foreground ,tertiary-fixed))))
   `(doom-modeline-lsp-success ((t (:foreground ,success))))
   `(doom-modeline-lsp-warning ((t (:foreground ,secondary-fixed))))
   `(doom-modeline-lsp-error ((t (:foreground ,err))))
   `(doom-modeline-battery-normal ((t (:foreground ,success))))
   `(doom-modeline-battery-warning ((t (:foreground ,secondary-fixed))))
   `(doom-modeline-battery-critical ((t (:foreground ,err))))
   `(doom-modeline-evil-normal-state ((t (:foreground ,secondary-fixed :weight bold))))
   `(doom-modeline-evil-insert-state ((t (:foreground ,primary-fixed :weight bold))))
   `(doom-modeline-evil-visual-state ((t (:foreground ,tertiary-fixed :weight bold))))
   `(doom-modeline-evil-replace-state ((t (:foreground ,err :weight bold))))
   `(doom-modeline-evil-emacs-state ((t (:foreground ,outline-color :weight bold))))

   ;; Source blocks
   `(org-block ((t (:background ,surface-container-low :extend t :inherit fixed-pitch))))
   `(org-block-begin-line ((t (:background ,surface-container-low :foreground ,outline-color :extend t :slant italic :inherit fixed-pitch))))
   `(org-block-end-line ((t (:background ,surface-container-low :foreground ,outline-color :extend t :slant italic :inherit fixed-pitch))))
   `(org-code ((t (:background ,surface-container-low :foreground ,secondary-fixed :inherit fixed-pitch))))
   `(org-verbatim ((t (:background ,surface-container-low :foreground ,primary-fixed :inherit fixed-pitch))))
   `(org-meta-line ((t (:foreground ,outline-color :slant italic))))
   
   ;; Org mode
   `(org-level-1 ((t (:foreground ,primary-fixed :weight bold :height 1.2))))
   `(org-level-2 ((t (:foreground ,secondary-fixed :weight bold :height 1.1))))
   `(org-level-3 ((t (:foreground ,tertiary-fixed :weight bold))))
   `(org-level-4 ((t (:foreground ,primary :weight bold))))
   `(org-level-5 ((t (:foreground ,secondary :weight bold))))
   `(org-level-6 ((t (:foreground ,tertiary :weight bold))))
   `(org-level-7 ((t (:foreground ,primary-fixed-dim :weight bold))))
   `(org-level-8 ((t (:foreground ,secondary-fixed-dim :weight bold))))
   `(org-document-title ((t (:foreground ,primary-fixed :weight bold :height 1.3))))
   `(org-document-info ((t (:foreground ,tertiary))))
   `(org-todo ((t (:foreground ,err :weight bold))))
   `(org-done ((t (:foreground ,success :weight bold))))
   `(org-headline-done ((t (:foreground ,outline-color))))
   `(org-hide ((t (:foreground ,bg))))
   `(org-ellipsis ((t (:foreground ,secondary :underline nil))))
   `(org-table ((t (:foreground ,secondary :inherit fixed-pitch))))
   `(org-formula ((t (:foreground ,tertiary-fixed :inherit fixed-pitch))))
   `(org-checkbox ((t (:foreground ,primary-fixed :weight bold :inherit fixed-pitch))))
   `(org-date ((t (:foreground ,tertiary :underline t))))
   `(org-special-keyword ((t (:foreground ,outline-color :slant italic))))
   `(org-tag ((t (:foreground ,outline-color :weight normal))))
   
   ;; Magit
   `(magit-section-highlight ((t (:background ,surface-container-low))))
   `(magit-diff-hunk-heading ((t (:background ,surface-container :foreground ,on-surface-variant))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,surface-container-high :foreground ,on-surface))))
   `(magit-diff-context ((t (:foreground ,on-surface-variant))))
   `(magit-diff-context-highlight ((t (:background ,surface-container-low :foreground ,on-surface))))
   `(magit-diff-added ((t (:background ,success-container :foreground ,on-success-container))))
   `(magit-diff-added-highlight ((t (:background ,success-container :foreground ,on-success-container :weight bold))))
   `(magit-diff-removed ((t (:background ,err-container :foreground ,on-err-container))))
   `(magit-diff-removed-highlight ((t (:background ,err-container :foreground ,on-err-container :weight bold))))
   `(magit-hash ((t (:foreground ,outline-color))))
   `(magit-branch-local ((t (:foreground ,secondary-fixed :weight bold))))
   `(magit-branch-remote ((t (:foreground ,primary-fixed :weight bold))))
   
   ;; Company
   `(company-tooltip ((t (:background ,surface-container :foreground ,on-surface))))
   `(company-tooltip-selection ((t (:background ,primary-container :foreground ,on-primary-container))))
   `(company-tooltip-common ((t (:foreground ,primary-fixed))))
   `(company-tooltip-common-selection ((t (:foreground ,on-primary-container :weight bold))))
   `(company-tooltip-annotation ((t (:foreground ,secondary-fixed))))
   `(company-scrollbar-fg ((t (:background ,primary))))
   `(company-scrollbar-bg ((t (:background ,surface-variant))))
   `(company-preview ((t (:foreground ,on-surface-variant :slant italic))))
   `(company-preview-common ((t (:foreground ,primary :slant italic))))
   
   ;; Ido
   `(ido-first-match ((t (:foreground ,primary-fixed :weight bold))))
   `(ido-only-match ((t (:foreground ,secondary-fixed :weight bold))))
   `(ido-subdir ((t (:foreground ,tertiary))))
   `(ido-indicator ((t (:foreground ,err))))
   `(ido-virtual ((t (:foreground ,outline-color))))
   
   ;; Helm
   `(helm-selection ((t (:background ,primary-container :foreground ,on-primary-container))))
   `(helm-match ((t (:foreground ,secondary-fixed :weight bold))))
   `(helm-source-header ((t (:background ,surface-container-high :foreground ,primary-fixed :weight bold :height 1.1))))
   `(helm-candidate-number ((t (:foreground ,secondary :weight bold))))
   `(helm-ff-directory ((t (:foreground ,primary-fixed :weight bold))))
   `(helm-ff-file ((t (:foreground ,on-surface))))
   `(helm-ff-executable ((t (:foreground ,secondary-fixed))))

   ;; corfu
   `(corfu-default ((t (:background ,surface-container :foreground ,on-surface))))
   `(corfu-current ((t (:background ,primary-container :foreground ,on-primary-container))))
   
   ;; Which-key
   `(which-key-key-face ((t (:foreground ,primary-fixed :weight bold))))
   `(which-key-separator-face ((t (:foreground ,outline-variant))))
   `(which-key-command-description-face ((t (:foreground ,on-surface))))
   `(which-key-group-description-face ((t (:foreground ,secondary-fixed))))
   `(which-key-special-key-face ((t (:foreground ,tertiary-fixed :weight bold))))
   
   ;; Line numbers
   `(line-number ((t (:foreground ,outline-variant :inherit fixed-pitch))))
   `(line-number-current-line ((t (:foreground ,secondary-fixed :weight bold :inherit fixed-pitch))))
   
   ;; Rainbow delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,primary-fixed))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,secondary-fixed))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,tertiary-fixed))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,primary))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,secondary))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,tertiary))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,primary-fixed-dim))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,secondary-fixed-dim))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,tertiary-fixed-dim))))
   `(rainbow-delimiters-mismatched-face ((t (:foreground ,err :weight bold))))
   `(rainbow-delimiters-unmatched-face ((t (:foreground ,err :weight bold))))
   
   ;; Dired
   `(dired-directory ((t (:foreground ,primary-fixed :weight bold))))
   `(dired-ignored ((t (:foreground ,outline-variant))))
   `(dired-flagged ((t (:foreground ,err))))
   `(dired-marked ((t (:foreground ,secondary-fixed :weight bold))))
   `(dired-symlink ((t (:foreground ,tertiary :slant italic))))
   `(dired-header ((t (:foreground ,primary-fixed :weight bold :height 1.1))))
   
   ;; Terminal colors
   `(term-color-black ((t (:foreground ,term0 :background ,term0))))
   `(term-color-red ((t (:foreground ,term1 :background ,term1))))
   `(term-color-green ((t (:foreground ,term2 :background ,term2))))
   `(term-color-yellow ((t (:foreground ,term3 :background ,term3))))
   `(term-color-blue ((t (:foreground ,term4 :background ,term4))))
   `(term-color-magenta ((t (:foreground ,term5 :background ,term5))))
   `(term-color-cyan ((t (:foreground ,term6 :background ,term6))))
   `(term-color-white ((t (:foreground ,term7 :background ,term7))))
   
   ;; EShell
   `(eshell-prompt ((t (:foreground ,primary-fixed :weight bold))))
   `(eshell-ls-directory ((t (:foreground ,primary-fixed :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,tertiary :slant italic))))
   `(eshell-ls-executable ((t (:foreground ,secondary-fixed))))
   `(eshell-ls-archive ((t (:foreground ,primary))))
   `(eshell-ls-backup ((t (:foreground ,outline-variant))))
   `(eshell-ls-clutter ((t (:foreground ,err))))
   `(eshell-ls-missing ((t (:foreground ,err))))
   `(eshell-ls-product ((t (:foreground ,on-surface-variant))))
   `(eshell-ls-readonly ((t (:foreground ,on-surface-variant))))
   `(eshell-ls-special ((t (:foreground ,tertiary-fixed))))
   `(eshell-ls-unreadable ((t (:foreground ,outline-variant))))
   
   ;; Markdown mode
   `(markdown-header-face ((t (:foreground ,primary-fixed :weight bold))))
   `(markdown-header-face-1 ((t (:foreground ,primary-fixed :weight bold :height 1.2))))
   `(markdown-header-face-2 ((t (:foreground ,secondary-fixed :weight bold :height 1.1))))
   `(markdown-header-face-3 ((t (:foreground ,tertiary-fixed :weight bold))))
   `(markdown-header-face-4 ((t (:foreground ,primary :weight bold))))
   `(markdown-inline-code-face ((t (:foreground ,secondary-fixed :background ,surface-container-low :inherit fixed-pitch))))
   `(markdown-code-face ((t (:background ,surface-container-low :extend t :inherit fixed-pitch))))
   `(markdown-pre-face ((t (:background ,surface-container-low :inherit fixed-pitch))))
   `(markdown-table-face ((t (:foreground ,secondary :inherit fixed-pitch))))
   
   ;; Web mode
   `(web-mode-html-tag-face ((t (:foreground ,primary-fixed))))
   `(web-mode-html-tag-bracket-face ((t (:foreground ,outline-color))))
   `(web-mode-html-attr-name-face ((t (:foreground ,secondary-fixed))))
   `(web-mode-html-attr-value-face ((t (:foreground ,secondary))))
   `(web-mode-css-selector-face ((t (:foreground ,primary-fixed))))
   `(web-mode-css-property-name-face ((t (:foreground ,tertiary-fixed))))
   `(web-mode-css-string-face ((t (:foreground ,secondary))))
   
   ;; Flycheck
   `(flycheck-error ((t (:underline (:style wave :color ,err)))))
   `(flycheck-warning ((t (:underline (:style wave :color ,secondary-fixed)))))
   `(flycheck-info ((t (:underline (:style wave :color ,tertiary-fixed)))))
   `(flycheck-fringe-error ((t (:foreground ,err))))
   `(flycheck-fringe-warning ((t (:foreground ,secondary-fixed))))
   `(flycheck-fringe-info ((t (:foreground ,tertiary-fixed))))
   
   ;; Mini-buffer customization
   `(minibuffer-prompt ((t (:foreground ,primary-fixed :weight bold))))
   
   ;; LSP highlight
   `(lsp-face-highlight-textual ((t (:background ,primary-container :foreground ,on-primary-container :weight bold))))
   `(lsp-face-highlight-read ((t (:background ,secondary-container :foreground ,on-secondary-container :weight bold))))
   `(lsp-face-highlight-write ((t (:background ,tertiary-container :foreground ,on-tertiary-container :weight bold))))
   
   ;; Info and help modes
   `(info-title-1 ((t (:foreground ,primary-fixed :weight bold :height 1.3))))
   `(info-title-2 ((t (:foreground ,secondary-fixed :weight bold :height 1.2))))
   `(info-title-3 ((t (:foreground ,tertiary-fixed :weight bold :height 1.1))))
   `(info-title-4 ((t (:foreground ,primary :weight bold))))
   `(Info-quoted ((t (:foreground ,secondary))))
   `(info-menu-header ((t (:foreground ,primary-fixed :weight bold))))
   `(info-menu-star ((t (:foreground ,primary-fixed))))
   `(info-node ((t (:foreground ,secondary-fixed :weight bold))))

   ;; Tabs
   `(tab-bar ((t (:background ,surface-container-high :foreground ,on-surface :box nil))))
   `(tab-bar-tab ((t (:background ,surface-container-high :foreground ,primary-fixed :weight bold :box nil))))
   `(tab-bar-tab-inactive ((t (:background ,surface :foreground ,on-surface-variant :box nil))))

   `(tab-line ((t (:background ,surface-container-high :foreground ,on-surface :box nil))))
   `(tab-line-tab ((t (:background ,surface :foreground ,on-surface-variant :box nil))))
   `(tab-line-tab-current ((t (:background ,surface-container-high :foreground ,primary-fixed :weight bold :box nil))))
   `(tab-line-tab-inactive ((t (:background ,surface :foreground ,on-surface-variant :box nil))))
   `(tab-line-highlight ((t (:background ,surface-container-highest :foreground ,on-surface))))

   `(centaur-tabs-default ((t (:background ,surface-container-high :foreground ,on-surface))))
   `(centaur-tabs-selected ((t (:background ,surface-container-high :foreground ,primary-fixed :weight bold))))
   `(centaur-tabs-unselected ((t (:background ,surface :foreground ,on-surface-variant))))
   `(centaur-tabs-selected-modified ((t (:background ,surface-container-high :foreground ,secondary-fixed :weight bold))))
   `(centaur-tabs-unselected-modified ((t (:background ,surface :foreground ,secondary-fixed))))
   `(centaur-tabs-active-bar-face ((t (:background ,primary-fixed))))
   
   ;; Fixed-pitch faces
   `(fixed-pitch ((t (:family "monospace"))))
   `(fixed-pitch-serif ((t (:family "monospace serif"))))
   
   ;; Variable-pitch face
   `(variable-pitch ((t (:family "sans serif"))))
   ))

;; Add org-mode hooks
(with-eval-after-load 'org
  (setq org-hide-leading-stars t)
  (setq org-startup-indented t))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'flutterice)
;;; flutterice-theme.el ends here