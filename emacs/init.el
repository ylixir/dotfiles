;first we taketh away
(blink-cursor-mode 0)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq visible-bell t)
(scroll-bar-mode 0)
(tool-bar-mode 0)

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
(setq speedbar-show-unknown-files t)

;zomg emacs has a port of the best theme evah!
;the second argument tells emacs that this theme is safe
(load-theme 'inkpot t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(add-to-list 'default-frame-alist
             '(font . "Fantasque Sans Mono-12"))

;hack to get fish prompt working
(add-hook 'term-mode-hook 'toggle-truncate-lines)

(use-package direnv)
(direnv-mode)

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
  :custom (evil-collection-setup-minibuffer t)
  :init
  (evil-collection-init))

(use-package which-key
  :init
    (which-key-mode))

(use-package ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (t      . ivy--regex-fuzzy)))

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

;languages i might use
(use-package php-mode)

;all the ide stuff (language server protocol)
(use-package lsp-mode
  :commands lsp
  :init
    (setq evil-want-keybinding t)
    (add-hook 'prog-mode-hook #'lsp)
 )

(use-package lsp-clients)
(use-package lsp-ui :commands lsp-ui-mode
  :init
    (add-hook 'lsp-mode-hook 'lsp-ui-mode))
(use-package company-lsp :commands company-lsp)
;; PHP intelephense
(defgroup lsp-php-iph nil
  "PHP."
  :group 'lsp-mode
  :tag "PHP")

(defcustom lsp-clients-php-iph-server-command
  `("intelephense" "--stdio")
  "Install directory for php-language-server."
  :group 'lsp-php-ip
  :type '(repeat string))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection (lambda () lsp-clients-php-iph-server-command))
                  :major-modes '(php-mode)
                  :priority 0
                  :server-id 'iph))
