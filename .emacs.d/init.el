;; Macの場合
(require 'cask)

(cask-initialize)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

;; Helm
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(helm-mode 1)

;;ミニバッファでC-hをバックスペースに割り当て
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
