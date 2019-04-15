;we will be using "use-package" for dependencies
(eval-when-compile
  (require 'package)
  (add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/"))
  (require 'use-package)
  (package-initialize)
)

;i feel like this folder is gonna get cluttered
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;zomg emacs has a port of the best theme evah!
;the second argument tells emacs that this theme is safe
(load-theme 'inkpot t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(add-to-list 'default-frame-alist
             '(font . "Fantasque Sans Mono-12"))

;hack to get fish prompt working
(add-hook 'term-mode-hook 'toggle-truncate-lines)

; go go vi mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration nil)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package which-key
  :init
    (which-key-mode))

(use-package ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

;getting general from nix, not *elpa
(use-package general
  :after evil
  :init
    (general-evil-setup)
    ;spc by itself needs to be separate from the spc prefixes
    (general-nvmap
      "SPC" ctl-x-map)
    (general-nvmap
      :prefix "SPC"
        "h" help-map))
