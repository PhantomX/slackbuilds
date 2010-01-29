;;; loaded before user's ".emacs" file and default.el

;; load ".el" files in "/usr/share/emacs/site-lisp/site-start.d/" on startup
(mapc 'load
      (directory-files "/usr/share/emacs/site-lisp/site-start.d" t "\\.el\\'"))
