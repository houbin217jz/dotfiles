;;; init-web-mode.el --- Init web-mode

;;; Commentary:

;; Required:
;; - node
;; - eslint
;; - tern

;;; Code:

(require-package 'web-mode)
(require-package 'json-mode)
(require-package 'vue-mode)
(require-package 'rjsx-mode)
(require-package 'tern)
(require-package 'tern-auto-complete)
(require-package 'js-doc)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ftl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))

(defvar js-indent-level)
(setq js-indent-level 2)
;; Fix js.el inndentation bug
(advice-add 'js--multi-line-declaration-indentation :around (lambda (orig-fun &rest args) nil))

(with-eval-after-load 'tern
  (require 'tern-auto-complete)
  (defvar tern-ac-js-major-modes '(rjsx-mode js2-mode js2-jsx-mode js-mode javascript-mode))
  (tern-ac-setup))

(defun web-mode-cur-language()
  "Show current language in web-mode."
  (interactive)
  (message (web-mode-language-at-pos)))

(if (executable-find "eslint")
	(progn
	  (defun eslint-fix ()
		"Where to display jscs-fix error output.  It can either be displayed in its own buffer, in the echo area, or not at all."
		(interactive)
		(message "eslint --fix the file %s" (buffer-file-name))
		(shell-command (concat "eslint --fix " (buffer-file-name)))
		(revert-buffer t t)))
  (message "Please install eslint: 'npm install -g eslint-cli'."))

(with-eval-after-load 'rjsx-mode
  (defvar js2-mode-show-parse-errors)
  (defvar js2-mode-show-strict-warnings)
  (setq js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil))

(add-hook 'rjsx-mode-hook
          '(lambda()
             (add-to-list 'editorconfig-indentation-alist '(rjsx-mode js2-basic-offset sgml-basic-offset))
             (editorconfig-apply)
             (tern-mode)))

(provide 'init-web-mode)

;;; init-web-mode.el ends here
