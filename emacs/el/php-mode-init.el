;; Use php-mode for .php,.php3,.php4 and .phtml files

(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)

(add-to-list 'auto-mode-alist
	     '("\\.php[34]\\'\\|\\.php\\'\\|\\.phtml\\'" . php-mode))

