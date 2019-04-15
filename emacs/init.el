;i feel like this folder is gonna get cluttered
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;zomg emacs has a port of the best theme evah!
;the second argument tells emacs that this theme is safe
(load-theme 'inkpot t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(add-to-list 'default-frame-alist
             '(font . "Fantasque Sans Mono-10"))
; go go vi mode
(require 'evil)
(evil-mode t)

