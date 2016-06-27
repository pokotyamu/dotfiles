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
(define-key global-map (kbd "C-c C-f") 'helm-projectile)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(helm-mode 1)

;; TABで補完
(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)

;;ミニバッファでC-hをバックスペースに割り当て
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)

;;rubyのマジックコメント対策
(setq ruby-insert-encoding-magic-comment nil)

;;行数
(global-linum-mode t)

(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
			 trailing       ; 行末
			 tabs           ; タブ
			 spaces         ; スペース
			 empty          ; 先頭/末尾の空行
			 space-mark     ; 表示のマッピング
			 tab-mark
			 ))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
	;; WARNING: the mapping below has a problem.
	;; When a TAB occupies exactly one column, it will display the
	;; character ?\xBB at that column followed by a TAB which goes to
	;; the next TAB column.
	;; If this is a problem for you, please, comment the line below.
	(tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
		    :background my/bg-color
		    :foreground "DeepPink"
		    :underline t)
(set-face-attribute 'whitespace-tab nil
		    :background my/bg-color
		    :foreground "LightSkyBlue"
		    :underline t)
(set-face-attribute 'whitespace-space nil
		    :background my/bg-color
		    :foreground "GreenYellow"
		    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
		    :background my/bg-color)

;; Window 分割・移動を C-t で
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
	(split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (wheatgrass))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; メニューバーを表示しない
(menu-bar-mode -1)

;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode)) ;; shebangがrubyの場合、ruby-modeを開く
;; ruby-modeのインデントを改良する
(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
	indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
	(setq offset (- column (current-column)))
	(when (and (eq (char-after) ?\))
		   (not (zerop (car state))))
	  (goto-char (cadr state))
	  (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

(ac-config-default)

;magit
(define-key global-map (kbd "M-g s") 'magit-status)
(global-git-gutter-mode t)
(setq git-gutter:added-sign "+")
(setq git-gutter:deleted-sign-sign "-")
(setq git-gutter:modified-sign "*") ;; 空白 2つ
(set-face-foreground 'git-gutter:added  "red")
(set-face-foreground 'git-gutter:deleted  "yellow")
(set-face-background 'git-gutter:modified "magenta")

;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; globalなC-zを無効化
(global-unset-key "\C-z")
