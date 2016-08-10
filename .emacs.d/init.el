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
(define-key global-map (kbd "C-c C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-c b")   'helm-buffers-list)
(define-key global-map (kbd "C-c C-g")   'helm-ag)
(helm-mode 1)

;; TABで補完
(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)

;;ミニバッファでC-hをバックスペースに割り当て
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)

;;rubyのマジックコメント対策
(setq ruby-insert-encoding-magic-comment nil)

;;行数
(global-linum-mode t)

;; スクロールバーを表示しない
(scroll-bar-mode 0)

;; 起動時フルスクリーンにする
(set-frame-parameter nil 'fullscreen 'fullboth)

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

;; flycheck
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (setq flycheck-checker 'ruby-rubocop)
	     (flycheck-mode 1)))

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

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'ruby-mode)
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; globalなC-zを無効化
(global-unset-key "\C-z")

;;; クリップボードをMac と統一する
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(setq inhibit-startup-message t)

(require 'server)
(unless (server-running-p)
  (server-start))

;; Fonts
(let* ((size 15)
       (asciifont "Ricty")
       (jpfont "Ricty")
       (h (* size 12))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))
