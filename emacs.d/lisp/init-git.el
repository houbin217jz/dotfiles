;;; init-git.el --- Init Git

;;; Commentary:

;;; Code:

(el-get-bundle magit)

(el-get-bundle magit-gitflow
  (with-eval-after-load-feature 'magit-gitflow
	(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)))

;; git-gutter
(el-get-bundle git-gutter
  (add-hook 'prog-mode-hook 'git-gutter-mode))

(provide 'init-git)

;;; init-git.el ends here
