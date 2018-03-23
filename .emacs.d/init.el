;; Macの場合

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;;(exec-path-from-shell-initialize)

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

;; 時刻表示
(display-time)

;; 現在行を目立たせる
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "#CC0066"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; (yes/no) を (y/n)に
(fset 'yes-or-no-p 'y-or-n-p)

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

;; Window 分割を画面サイズに従って計算する
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))
;; Window 分割・移動を C-t で
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
        (split-window-horizontally-n 2)
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
 '(custom-enabled-themes (quote (wheatgrass)))
 '(package-selected-packages
   (quote
    (clj-refactor mwim sequential-command flycheck dockerfile-mode company-jedi yasnippet yaml-mode web-mode use-package smex smartparens slim-mode sass-mode ruby-block rspec-mode robe rhtml-mode prodigy popwin pallet nyan-mode multiple-cursors markdown-mode magit less-css-mode json-mode idle-highlight-mode htmlize highlight-symbol helm-projectile helm-ag go-autocomplete git-gutter-fringe fuzzy flycheck-cask expand-region exec-path-from-shell drag-stuff company-irony color-theme ag))))
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
;(autoload 'flycheck-mode "flycheck")
;(add-hook 'ruby-mode-hook 'flycheck-mode)
;(setq flycheck-check-syntax-automatically '(idle-change mode-enabled new-line save))

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

;magit
(define-key global-map (kbd "M-g s") 'magit-status)
(global-git-gutter-mode t)
(setq git-gutter:added-sign "+")
(setq git-gutter:deleted-sign-sign "-")
(setq git-gutter:modified-sign "*") ;; 空白 2つ
(set-face-foreground 'git-gutter:added  "red")
(set-face-foreground 'git-gutter:deleted  "yellow")
(set-face-background 'git-gutter:modified "magenta")

;; rbenvパス設定
(setenv "PATH" (concat (expand-file-name "/usr/local/var/rbenv/shims/ruby") (getenv "PATH")))

(require 'rbenv)
(setq rbenv-installation-dir "/usr/local/var/rbenv")


;; do endなどの補完
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda ()
          (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)

;; 補完機能
;; robe-modeの有効化とcompanyとの連携
(add-hook 'ruby-mode-hook 'robe-mode)
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(eval-after-load 'company
  '(push 'company-robe company-backends))

(add-hook 'ruby-mode-hook (lambda()
      (company-mode)
      (setq company-auto-expand t)
      (setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
      (setq company-idle-delay 0) ; 遅延なしにすぐ表示
      (setq company-minimum-prefix-length 1) ; 何文字打つと補完動作を行うか設定
      (setq company-selection-wrap-around t) ; 候補の最後の次は先頭に戻る
      (setq completion-ignore-case t)
      (setq company-dabbrev-downcase nil)
      (global-set-key (kbd "C-M-i") 'company-complete)
      ;; C-n, C-pで補完候補を次/前の候補を選択
      (define-key company-active-map (kbd "C-n") 'company-select-next)
      (define-key company-active-map (kbd "C-p") 'company-select-previous)
      (define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
      (define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
      (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
      ))

;; rubocop mode も合わせて起動
(add-hook 'ruby-mode-hook #'rubocop-mode)

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
(let* ((size 13)
       (asciifont "Ricty")
       (jpfont "Ricty")
       (h (* size 11))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))

;; 改行で終わる
(setq require-final-newline nil)

;; リージョン選択範囲を広げる
(require 'expand-region)
(global-set-key (kbd "C-.") 'er/expand-region)

;; ;; 一括でクォートで囲む
;; (require 'region-bindings-mode)
;; (region-bindings-mode-enable)
;; (define-key region-bindings-mode-map (kbd "M-'") 'region-to-single-quote)
;; (define-key region-bindings-mode-map (kbd "M-\"") 'region-to-double-quote)
;; (define-key region-bindings-mode-map (kbd "M-9") 'region-to-bracket)
;; (define-key region-bindings-mode-map (kbd "M-[") 'region-to-square-bracket)

;; docker
(autoload 'dockerfile-mode "dockerfile-mode" nil t)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; 行頭行後の拡張
(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

;; 日本語ちらつき防止
(setq redisplay-dont-pause nil)
