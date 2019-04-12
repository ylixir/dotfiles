;i feel like this folder is gonna get cluttered
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;zomg emacs has a port of the best theme evah!
;the second argument tells emacs that this theme is safe
(load-theme 'inkpot t)
(setq-default display-line-numbers 'relative)
(global-display-line-numbers-mode t)

; go go vi mode
(require 'evil)
(evil-mode t)

