;;; rpm-spec-mode.el --- RPM spec file editing commands for Emacs/XEmacs

;; Copyright (C) 1997-2002 Stig Bjørlykke, <stigb@tihlde.org>

;; Author:   Stig Bjørlykke, <stigb@tihlde.org>
;; Keywords: unix, languages, rpm
;; Version:  0.12x

;; This file is part of XEmacs.

;; XEmacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; XEmacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with XEmacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301 USA.

;;; Synched up with: not in GNU Emacs.

;;; Thanx to:

;;     Tore Olsen <toreo@tihlde.org> for some general fixes.
;;     Steve Sanbeg <sanbeg@dset.com> for navigation functions and
;;          some Emacs fixes.
;;     Tim Powers <timp@redhat.com> and Trond Eivind Glomsrød
;;          <teg@redhat.com> for Red Hat adaptions and some fixes.
;;     Chmouel Boudjnah <chmouel@mandrakesoft.com> for Mandrake fixes.
;;     Ville Skyttä  <scop@xemacs.org> for some fixes.

;;; ToDo:

;; - rewrite function names.
;; - autofill changelog entries.
;; - customize rpm-tags-list, rpm-obsolete-tags-list and rpm-group-tags-list.
;; - get values from `rpm --showrc'.
;; - ssh/rsh for compile.
;; - finish integrating the new navigation functions in with existing stuff.
;; - use a single prefix consistently (internal)

;;; Commentary:

;; This mode is used for editing spec files used for building RPM packages.
;;
;; Most recent version is available from:
;;  <URL:http://www.tihlde.org/~stigb/rpm-spec-mode.el>
;;
;; Put this in your .emacs file to enable autoloading of rpm-spec-mode,
;; and auto-recognition of ".spec" files:
;;
;;  (autoload 'rpm-spec-mode "rpm-spec-mode.el" "RPM spec mode." t)
;;  (setq auto-mode-alist (append '(("\\.spec" . rpm-spec-mode))
;;                                auto-mode-alist))
;;------------------------------------------------------------
;;

;;; Code:

(defconst rpm-spec-mode-version "0.12.3x" "Version of `rpm-spec-mode'.")

(defgroup rpm-spec nil
  "RPM spec mode with Emacs/XEmacs enhancements."
  :prefix "rpm-spec-"
  :group 'languages)

(defcustom rpm-spec-build-command "rpmbuild"
  "Command for building an RPM package."
  :type 'string
  :group 'rpm-spec)

(defcustom rpm-spec-add-attr nil
  "Add \"%attr\" entry for file listings or not."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-short-circuit nil
  "Skip straight to specified stage.
(ie, skip all stages leading up to the specified stage).  Only valid
in \"%build\" and \"%install\" stage."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-timecheck "0"
  "Set the \"timecheck\" age (0 to disable).
The timecheck value expresses, in seconds, the maximum age of a file
being packaged.  Warnings will be printed for all files beyond the
timecheck age."
  :type 'integer
  :group 'rpm-spec)

(defcustom rpm-spec-buildroot ""
  "When building, override the BuildRoot tag with directory <dir>."
  :type 'string
  :group 'rpm-spec)

(defcustom rpm-spec-target ""
  "Interpret given string as `arch-vendor-os'.
Set the macros _target, _target_arch and _target_os accordingly"
  :type 'string
  :group 'rpm-spec)

(define-obsolete-variable-alias
  'rpm-completion-ignore-case 'rpm-spec-completion-ignore-case)

(defcustom rpm-spec-completion-ignore-case t
  "*Non-nil means that case differences are ignored during completion.
A value of nil means that case is significant.
This is used during Tempo template completion."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-clean nil
  "Remove the build tree after the packages are made."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-rmsource nil
  "Remove the source and spec file after the packages are made."
  :type 'boolean
  :group 'rpm-spec)

(define-obsolete-variable-alias
  'rpm-spec-test 'rpm-spec-nobuild)

(defcustom rpm-spec-nobuild nil
  "Do not execute any build stages.  Useful for testing out spec files."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-quiet nil
  "Print as little as possible.
Normally only error messages will be displayed."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-sign-gpg nil
  "Embed a GPG signature in the package.
This signature can be used to verify the integrity and the origin of
the package."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-nodeps nil
  "Do not verify build dependencies."
  :type 'boolean
  :group 'rpm-spec)

(define-obsolete-variable-alias
  'rpm-initialize-sections 'rpm-spec-initialize-sections)

(defcustom rpm-spec-initialize-sections t
  "Automatically add empty section headings to new spec files."
  :type 'boolean
  :group 'rpm-spec)

(define-obsolete-variable-alias
  'rpm-insert-version 'rpm-spec-insert-changelog-version)

(defcustom rpm-spec-insert-changelog-version t
  "Automatically add version in a new change log entry."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-user-full-name nil
  "*Full name of the user.
This is used in the change log and the Packager tag.  It defaults to the
value returned by function `user-full-name'."
  :type '(choice (const :tag "Use `user-full-name'" nil)
                 string)
  :group 'rpm-spec)

(defcustom rpm-spec-user-mail-address nil
  "*Email address of the user.
This is used in the change log and the Packager tag.  It defaults to the
value returned by function `user-mail-address'."
  :type '(choice (const :tag "Use `user-mail-address'" nil)
                 string)
  :group 'rpm-spec)

(defcustom rpm-spec-indent-heading-values nil
  "*Indent values for all tags in the \"heading\" of the spec file."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-use-compilation-mode t
  "*If non-nil, build in `compilation-mode' if it's available."
  :type 'boolean
  :group 'rpm-spec)

(defcustom rpm-spec-default-release "1"
  "*Default value for the Release tag in new spec files."
  :type 'string
  :group 'rpm-spec)

(defcustom rpm-spec-default-epoch nil
  "*If non-nil, default value for the Epoch tag in new spec files."
  :type '(choice (const :tag "No Epoch" nil) integer)
  :group 'rpm-spec)

(defcustom rpm-spec-default-buildroot
  "%{_tmppath}/%{name}-%{version}-%{release}-root"
  "*Default value for the BuildRoot tag in new spec files."
  :type 'integer
  :group 'rpm-spec)

(defcustom rpm-spec-default-build-section ""
  "*Default %build section in new spec files."
  :type 'string
  :group 'rpm-spec)

(defcustom rpm-spec-default-install-section "rm -rf $RPM_BUILD_ROOT\n"
  "*Default %install section in new spec files."
  :type 'string
  :group 'rpm-spec)

(defcustom rpm-spec-default-clean-section "rm -rf $RPM_BUILD_ROOT\n"
  "*Default %clean section in new spec files."
  :type 'string
  :group 'rpm-spec)

(defgroup rpm-spec-faces nil
  "Font lock faces for `rpm-spec-mode'."
  :prefix "rpm-spec-"
  :group 'rpm-spec
  :group 'faces)

;;------------------------------------------------------------
;; variables used by navigation functions.

(defconst rpm-sections
  '("preamble" "description" "prep" "setup" "build" "install" "check" "clean"
    "changelog" "files")
  "Partial list of section names.")
(defvar rpm-section-list
  '(("preamble") ("description") ("prep") ("setup") ("build") ("install")
    ("check") ("clean") ("changelog") ("files"))
  "Partial list of section names.")
(defconst rpm-scripts
  '("pre" "post" "preun" "postun"
    "trigger" "triggerin" "triggerprein" "triggerun" "triggerpostun"
    "pretrans" "posttrans")
  "List of rpm scripts.")
(defconst rpm-section-seperate "^%\\(\\w+\\)\\s-")
(defconst rpm-section-regexp
  (eval-when-compile
    (concat "^%"
            (regexp-opt
             ;; From RPM 4.6.0 sources, file build/parseSpec.c: partList[].
             '("build" "changelog" "check" "clean" "description" "files"
               "install" "package" "post" "postun" "pretrans" "posttrans"
               "pre" "prep" "preun" "trigger" "triggerin" "triggerpostun"
               "triggerprein" "triggerun" "verifyscript") t)
            "\\b"))
  "Regular expression to match beginning of a section.")

;;------------------------------------------------------------

(defface rpm-spec-tag-face
  '(( ((class color) (background light)) (:foreground "blue3") )
    ( ((class color) (background dark)) (:foreground "blue") ))
  "*Face for tags."
  :group 'rpm-spec-faces)

(defface rpm-spec-obsolete-tag-face
  '(( ((class color)) (:foreground "white" :background "red") ))
  "*Face for obsolete tags."
  :group 'rpm-spec-faces)

(defface rpm-spec-macro-face
  '(( ((class color) (background light)) (:foreground "purple") )
    ( ((class color) (background dark)) (:foreground "yellow") ))
  "*Face for RPM macros and variables."
  :group 'rpm-spec-faces)

(defface rpm-spec-var-face
  '(( ((class color) (background light)) (:foreground "maroon") )
    ( ((class color) (background dark)) (:foreground "maroon") ))
  "*Face for environment variables."
  :group 'rpm-spec-faces)

(defface rpm-spec-doc-face
  '(( ((class color) (background light)) (:foreground "magenta3") )
    ( ((class color) (background dark)) (:foreground "magenta") ))
  "*Face for %doc entries in %files."
  :group 'rpm-spec-faces)

(defface rpm-spec-dir-face
  '(( ((class color) (background light)) (:foreground "green4") )
    ( ((class color) (background dark)) (:foreground "green") ))
  "*Face for %dir entries in %files."
  :group 'rpm-spec-faces)

(defface rpm-spec-package-face
  '(( ((class color) (background light)) (:foreground "red3") )
    ( ((class color) (background dark)) (:foreground "red") ))
  "*Face for package tag."
  :group 'rpm-spec-faces)

(defface rpm-spec-ghost-face
  '(( ((class color) (background light)) (:foreground "gray50") )
    ( ((class color) (background dark)) (:foreground "red") ))
  "*Face for %ghost and %config entries in %files."
  :group 'rpm-spec-faces)

(defface rpm-spec-section-face
  '(( ((class color) (background light)) (:foreground "purple" :underline t) )
    ( ((class color) (background dark)) (:foreground "yellow" :underline t) ))
  "*Face for section markers."
  :group 'rpm-spec-faces)

;;; GNU emacs font-lock needs these...
(defvar rpm-spec-macro-face
  'rpm-spec-macro-face "*Face for RPM macros and variables.")
(defvar rpm-spec-var-face
  'rpm-spec-var-face "*Face for environment variables.")
(defvar rpm-spec-tag-face
  'rpm-spec-tag-face "*Face for tags.")
(defvar rpm-spec-obsolete-tag-face
  'rpm-spec-tag-face "*Face for obsolete tags.")
(defvar rpm-spec-package-face
  'rpm-spec-package-face "*Face for package tag.")
(defvar rpm-spec-dir-face
  'rpm-spec-dir-face "*Face for %dir entries in %files.")
(defvar rpm-spec-doc-face
  'rpm-spec-doc-face "*Face for %doc entries in %files.")
(defvar rpm-spec-ghost-face
  'rpm-spec-ghost-face "*Face for %ghost and %config entries in %files.")
(defvar rpm-spec-section-face
  'rpm-spec-section-face "*Face for section markers.")

(defvar rpm-default-umask "-"
  "*Default umask for files, specified with \"%attr\".")
(defvar rpm-default-owner "root"
  "*Default owner for files, specified with \"%attr\".")
(defvar rpm-default-group "root"
  "*Default group for files, specified with \"%attr\".")

;;------------------------------------------------------------

(defvar rpm-no-gpg nil "Tell rpm not to sign package.")
(defvar rpm-spec-nobuild-option "--nobuild" "Option for no build.")

(defvar rpm-tags-list
  ;; From RPM 4.4.9 sources, file build/parsePreamble.c: preambleList[], and
  ;; a few macros that aren't tags, but useful here.
  '(("AutoProv")
    ("AutoReq")
    ("AutoReqProv")
    ("BuildArch")
    ("BuildArchitectures")
    ("BuildConflicts")
    ("BuildEnhances")
    ("BuildPlatforms")
    ("BuildPreReq")
    ("BuildRequires")
    ("BuildRoot")
    ("BuildSuggests")
    ("Conflicts")
    ("CVSId")
    ("%description")
    ("Distribution")
    ("DistTag")
    ("DistURL")
    ("DocDir")
    ("Enhances")
    ("Epoch")
    ("ExcludeArch")
    ("ExcludeOS")
    ("ExclusiveArch")
    ("ExclusiveOS")
    ("%files")
    ("Group")
    ("Icon")
    ("%ifarch")
    ("Keyword")
    ("Keywords")
    ("License")
    ("Name")
    ("NoPatch")
    ("NoSource")
    ("Obsoletes")
    ("%package")
    ("Packager")
    ("Patch")
    ("Prefix")
    ("Prefixes")
    ("PreReq")
    ("Provides")
    ("Release")
    ("Requires")
    ("RepoTag")
    ("Source")
    ("Suggests")
    ("Summary")
    ("SVNId")
    ("URL")
    ("Variant")
    ("Variants")
    ("Vendor")
    ("Version")
    ("XMajor")
    ("XMinor")
    )
  "List of elements that are valid tags.")

(defvar rpm-tags-regexp
  (concat "\\(\\<" (regexp-opt (mapcar 'car rpm-tags-list))
	  "\\|\\(Patch\\|Source\\)[0-9]+\\>\\)")
  "Regular expression for matching valid tags.")

(defvar rpm-obsolete-tags-list
  ;; From RPM sources, file build/parsePreamble.c: preambleList[].
  '(("Copyright")    ;; 4.4.2
    ("RHNPlatform")  ;; 4.4.2, 4.4.9
    ("Serial")       ;; 4.4.2, 4.4.9
    )
  "List of elements that are obsolete tags in some versions of rpm.")

(defvar rpm-obsolete-tags-regexp
  (regexp-opt (mapcar 'car rpm-obsolete-tags-list) 'words)
  "Regular expression for matching obsolete tags.")

(defvar rpm-group-tags-list
  ;; From RPM 4.4.9 sources, file GROUPS.
  '(("Amusements/Games")
    ("Amusements/Graphics")
    ("Applications/Archiving")
    ("Applications/Communications")
    ("Applications/Databases")
    ("Applications/Editors")
    ("Applications/Emulators")
    ("Applications/Engineering")
    ("Applications/File")
    ("Applications/Internet")
    ("Applications/Multimedia")
    ("Applications/Productivity")
    ("Applications/Publishing")
    ("Applications/System")
    ("Applications/Text")
    ("Development/Debuggers")
    ("Development/Languages")
    ("Development/Libraries")
    ("Development/System")
    ("Development/Tools")
    ("Documentation")
    ("System Environment/Base")
    ("System Environment/Daemons")
    ("System Environment/Kernel")
    ("System Environment/Libraries")
    ("System Environment/Shells")
    ("User Interface/Desktops")
    ("User Interface/X")
    ("User Interface/X Hardware Support")
    )
  "List of elements that are valid group tags.")

(defvar rpm-spec-mode-syntax-table nil
  "Syntax table in use in `rpm-spec-mode' buffers.")
(unless rpm-spec-mode-syntax-table
  (setq rpm-spec-mode-syntax-table (make-syntax-table))
  (modify-syntax-entry ?\\ "\\" rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?\n ">   " rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?\f ">   " rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?\# "<   " rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?/ "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?* "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?+ "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?- "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?= "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?% "_" rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?< "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?> "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?& "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?| "." rpm-spec-mode-syntax-table)
  (modify-syntax-entry ?\' "." rpm-spec-mode-syntax-table))

(defvar rpm-spec-mode-map nil
  "Keymap used in `rpm-spec-mode'.")
(unless rpm-spec-mode-map
  (setq rpm-spec-mode-map (make-sparse-keymap))
  (and (functionp 'set-keymap-name)
       (set-keymap-name rpm-spec-mode-map 'rpm-spec-mode-map))
  (define-key rpm-spec-mode-map "\C-c\C-c"  'rpm-change-tag)
  (define-key rpm-spec-mode-map "\C-c\C-e"  'rpm-add-change-log-entry)
  (define-key rpm-spec-mode-map "\C-c\C-i"  'rpm-insert-tag)
  (define-key rpm-spec-mode-map "\C-c\C-n"  'rpm-forward-section)
  (define-key rpm-spec-mode-map "\C-c\C-o"  'rpm-goto-section)
  (define-key rpm-spec-mode-map "\C-c\C-p"  'rpm-backward-section)
  (define-key rpm-spec-mode-map "\C-c\C-r"  'rpm-increase-release-tag)
  (define-key rpm-spec-mode-map "\C-c\C-u"  'rpm-insert-true-prefix)
  (define-key rpm-spec-mode-map "\C-c\C-ba" 'rpm-build-all)
  (define-key rpm-spec-mode-map "\C-c\C-bb" 'rpm-build-binary)
  (define-key rpm-spec-mode-map "\C-c\C-bc" 'rpm-build-compile)
  (define-key rpm-spec-mode-map "\C-c\C-bi" 'rpm-build-install)
  (define-key rpm-spec-mode-map "\C-c\C-bl" 'rpm-list-check)
  (define-key rpm-spec-mode-map "\C-c\C-bp" 'rpm-build-prepare)
  (define-key rpm-spec-mode-map "\C-c\C-bs" 'rpm-build-source)
  (define-key rpm-spec-mode-map "\C-c\C-dd" 'rpm-insert-dir)
  (define-key rpm-spec-mode-map "\C-c\C-do" 'rpm-insert-docdir)
  (define-key rpm-spec-mode-map "\C-c\C-fc" 'rpm-insert-config)
  (define-key rpm-spec-mode-map "\C-c\C-fd" 'rpm-insert-doc)
  (define-key rpm-spec-mode-map "\C-c\C-ff" 'rpm-insert-file)
  (define-key rpm-spec-mode-map "\C-c\C-fg" 'rpm-insert-ghost)
  (define-key rpm-spec-mode-map "\C-c\C-xa" 'rpm-toggle-add-attr)
  (define-key rpm-spec-mode-map "\C-c\C-xb" 'rpm-change-buildroot-option)
  (define-key rpm-spec-mode-map "\C-c\C-xc" 'rpm-toggle-clean)
  (define-key rpm-spec-mode-map "\C-c\C-xd" 'rpm-toggle-nodeps)
  (define-key rpm-spec-mode-map "\C-c\C-xf" 'rpm-files-group)
  (define-key rpm-spec-mode-map "\C-c\C-xg" 'rpm-toggle-sign-gpg)
  (define-key rpm-spec-mode-map "\C-c\C-xi" 'rpm-change-timecheck-option)
  (define-key rpm-spec-mode-map "\C-c\C-xn" 'rpm-toggle-nobuild)
  (define-key rpm-spec-mode-map "\C-c\C-xo" 'rpm-files-owner)
  (define-key rpm-spec-mode-map "\C-c\C-xr" 'rpm-toggle-rmsource)
  (define-key rpm-spec-mode-map "\C-c\C-xq" 'rpm-toggle-quiet)
  (define-key rpm-spec-mode-map "\C-c\C-xs" 'rpm-toggle-short-circuit)
  (define-key rpm-spec-mode-map "\C-c\C-xt" 'rpm-change-target-option)
  (define-key rpm-spec-mode-map "\C-c\C-xu" 'rpm-files-umask)
  ;;(define-key rpm-spec-mode-map "\C-q" 'indent-spec-exp)
  ;;(define-key rpm-spec-mode-map "\t" 'sh-indent-line)
  )

(defconst rpm-spec-mode-menu
  (purecopy '("RPM spec"
              ["Insert Tag..."           rpm-insert-tag                t]
              ["Change Tag..."           rpm-change-tag                t]
              "---"
              ["Go to section..."        rpm-mouse-goto-section  :keys "C-c C-o"]
              ["Forward section"         rpm-forward-section           t]
              ["Backward section"        rpm-backward-section          t]
              "---"
              ["Add change log entry..." rpm-add-change-log-entry      t]
              ["Increase release tag"    rpm-increase-release-tag      t]
              "---"
              ("Add file entry"
               ["Regular file..."        rpm-insert-file               t]
               ["Config file..."         rpm-insert-config             t]
               ["Document file..."       rpm-insert-doc                t]
               ["Ghost file..."          rpm-insert-ghost              t]
               "---"
               ["Directory..."           rpm-insert-dir                t]
               ["Document directory..."  rpm-insert-docdir             t]
               "---"
               ["Insert %{prefix}"       rpm-insert-true-prefix        t]
               "---"
               ["Default add \"%attr\" entry" rpm-toggle-add-attr
                :style toggle :selected rpm-spec-add-attr]
               ["Change default umask for files..."  rpm-files-umask   t]
               ["Change default owner for files..."  rpm-files-owner   t]
               ["Change default group for files..."  rpm-files-group   t])
              ("Build Options"
               ["Short circuit" rpm-toggle-short-circuit
                :style toggle :selected rpm-spec-short-circuit]
               ["Remove source" rpm-toggle-rmsource
                :style toggle :selected rpm-spec-rmsource]
               ["Clean"         rpm-toggle-clean
                :style toggle :selected rpm-spec-clean]
               ["No build"      rpm-toggle-nobuild
                :style toggle :selected rpm-spec-nobuild]
               ["Quiet"         rpm-toggle-quiet
                :style toggle :selected rpm-spec-quiet]
               ["GPG sign"      rpm-toggle-sign-gpg
                :style toggle :selected rpm-spec-sign-gpg]
               ["Ignore dependencies" rpm-toggle-nodeps
                :style toggle :selected rpm-spec-nodeps]
               "---"
               ["Change timecheck value..."  rpm-change-timecheck-option   t]
               ["Change buildroot value..."  rpm-change-buildroot-option   t]
               ["Change target value..."     rpm-change-target-option      t])
              ("RPM Build"
               ["Execute \"%prep\" stage"    rpm-build-prepare             t]
               ["Do a \"list check\""        rpm-list-check                t]
               ["Do the \"%build\" stage"    rpm-build-compile             t]
               ["Do the \"%install\" stage"  rpm-build-install             t]
               "---"
               ["Build binary package"       rpm-build-binary              t]
               ["Build source package"       rpm-build-source              t]
               ["Build binary and source"    rpm-build-all                 t])
              "---"
              ["About rpm-spec-mode"         rpm-about-rpm-spec-mode       t]
              )))

(defvar rpm-spec-font-lock-keywords
  (list
   (cons rpm-section-regexp rpm-spec-section-face)
   '("%[a-zA-Z0-9_]+" 0 rpm-spec-macro-face)
   (cons (concat "^" rpm-obsolete-tags-regexp "\\(\([a-zA-Z0-9,_]+\)\\)[ \t]*:")
         '((1 'rpm-spec-obsolete-tag-face)
           (2 'rpm-spec-ghost-face)))
   (cons (concat "^" rpm-tags-regexp "\\(\([a-zA-Z0-9,_]+\)\\)[ \t]*:")
         '((1 'rpm-spec-tag-face)
           (3 'rpm-spec-ghost-face)))
   (cons (concat "^" rpm-obsolete-tags-regexp "[ \t]*:")
         '(1 'rpm-spec-obsolete-tag-face))
   (cons (concat "^" rpm-tags-regexp "[ \t]*:")
         '(1 'rpm-spec-tag-face))
   '("%\\(de\\(fine\\|scription\\)\\|files\\|global\\|package\\)[ \t]+\\([^-][^ \t\n]*\\)"
     (3 rpm-spec-package-face))
   '("%p\\(ost\\|re\\)\\(un\\|trans\\)?[ \t]+\\([^-][^ \t\n]*\\)"
     (3 rpm-spec-package-face))
   '("%configure " 0 rpm-spec-macro-face)
   '("%dir[ \t]+\\([^ \t\n]+\\)[ \t]*" 1 rpm-spec-dir-face)
   '("%doc\\(dir\\)?[ \t]+\\(.*\\)\n" 2 rpm-spec-doc-face)
   '("%\\(ghost\\|config\\([ \t]*(.*)\\)?\\)[ \t]+\\(.*\\)\n"
     3 rpm-spec-ghost-face)
   '("^%.+-[a-zA-Z][ \t]+\\([a-zA-Z0-9\.-]+\\)" 1 rpm-spec-doc-face)
   '("^\\(.+\\)(\\([a-zA-Z]\\{2,2\\}\\)):"
     (1 rpm-spec-tag-face)
     (2 rpm-spec-doc-face))
   '("^\\*\\(.*[0-9] \\)\\(.*\\)<\\(.*\\)>\\(.*\\)\n"
     (1 rpm-spec-dir-face)
     (2 rpm-spec-package-face)
     (3 rpm-spec-tag-face)
     (4 rpm-spec-ghost-face))
   '("%{[^{}]*}" 0 rpm-spec-macro-face)
   '("$[a-zA-Z0-9_]+" 0 rpm-spec-var-face)
   '("${[a-zA-Z0-9_]+}" 0 rpm-spec-var-face)
   )
  "Additional expressions to highlight in `rpm-spec-mode'.")

;;Initialize font lock for xemacs
(put 'rpm-spec-mode 'font-lock-defaults '(rpm-spec-font-lock-keywords))

(defvar rpm-spec-mode-abbrev-table nil
  "Abbrev table in use in `rpm-spec-mode' buffers.")
(define-abbrev-table 'rpm-spec-mode-abbrev-table ())

;;------------------------------------------------------------

(add-hook 'rpm-spec-mode-new-file-hook 'rpm-spec-initialize)

;;;###autoload
(defun rpm-spec-mode ()
  "Major mode for editing RPM spec files.
This is much like C mode except for the syntax of comments.  It uses
the same keymap as C mode and has the same variables for customizing
indentation.  It has its own abbrev table and its own syntax table.

Turning on RPM spec mode calls the value of the variable `rpm-spec-mode-hook'
with no args, if that value is non-nil."
  (interactive)
  (kill-all-local-variables)
  (condition-case nil
      (require 'shindent)
    (error
     (require 'sh-script)))
  (require 'cc-mode)
  (use-local-map rpm-spec-mode-map)
  (setq major-mode 'rpm-spec-mode)
  (rpm-update-mode-name)
  (setq local-abbrev-table rpm-spec-mode-abbrev-table)
  (set-syntax-table rpm-spec-mode-syntax-table)

  (require 'easymenu)
  (easy-menu-define rpm-spec-call-menu rpm-spec-mode-map
                    "Post menu for `rpm-spec-mode'." rpm-spec-mode-menu)
  (easy-menu-add rpm-spec-mode-menu)

  (if (and (= (buffer-size) 0) rpm-spec-initialize-sections)
      (run-hooks 'rpm-spec-mode-new-file-hook))

  (if (not (executable-find "rpmbuild"))
      (progn
	(setq rpm-spec-build-command "rpm")
	(setq rpm-spec-nobuild-option "--test")))
  
  (make-local-variable 'paragraph-start)
  (setq paragraph-start (concat "$\\|" page-delimiter))
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'paragraph-ignore-fill-prefix)
  (setq paragraph-ignore-fill-prefix t)
;  (make-local-variable 'indent-line-function)
;  (setq indent-line-function 'c-indent-line)
  (make-local-variable 'require-final-newline)
  (setq require-final-newline t)
  (make-local-variable 'comment-start)
  (setq comment-start "# ")
  (make-local-variable 'comment-end)
  (setq comment-end "")
  (make-local-variable 'comment-column)
  (setq comment-column 32)
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "#+ *")
;  (make-local-variable 'comment-indent-function)
;  (setq comment-indent-function 'c-comment-indent)
  ;;Initialize font lock for GNU emacs.
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(rpm-spec-font-lock-keywords nil t))
  (run-hooks 'rpm-spec-mode-hook))

(defun rpm-command-filter (process string)
  "Filter to process normal output."
  (save-excursion
    (set-buffer (process-buffer process))
    (save-excursion
      (goto-char (process-mark process))
      (insert-before-markers string)
      (set-marker (process-mark process) (point)))))

;;------------------------------------------------------------

(defun rpm-add-change-log-entry (&optional change-log-entry)
  "Find change log and add an entry for today."
  (interactive "sChange log entry: ")
  (save-excursion
    (rpm-goto-section "changelog")
    (let* ((address (rpm-spec-user-mail-address))
           (fullname (or rpm-spec-user-full-name (user-full-name)))
           (string (concat "* " (substring (current-time-string) 0 11)
                           (substring (current-time-string) -4) " "
                           fullname " <" address ">"
                           (and rpm-spec-insert-changelog-version
                                (concat " - " (rpm-find-spec-version t))))))
      (if (not (search-forward string nil t))
          (insert "\n" string "\n")
        (forward-line 2))
      (insert "- " change-log-entry "\n"))))

;;------------------------------------------------------------

(defun rpm-insert-f (&optional filetype filename)
  "Insert new \"%files\" entry."
  (save-excursion
    (and (rpm-goto-section "files") (rpm-end-of-section))
    (if (or (eq filename 1) (not filename))
        (insert (read-file-name
                 (concat filetype "filename: ") "" "" nil) "\n")
      (insert filename "\n"))
    (forward-line -1)
    (if rpm-spec-add-attr
        (let ((rpm-default-mode rpm-default-umask))
          (insert "%attr(" rpm-default-mode ", " rpm-default-owner ", "
                  rpm-default-group ") ")))
    (insert filetype)))

(defun rpm-insert-file (&optional filename)
  "Insert regular file."
  (interactive "p")
  (rpm-insert-f "" filename))

(defun rpm-insert-config (&optional filename)
  "Insert config file."
  (interactive "p")
  (rpm-insert-f "%config " filename))

(defun rpm-insert-doc (&optional filename)
  "Insert doc file."
  (interactive "p")
  (rpm-insert-f "%doc " filename))

(defun rpm-insert-ghost (&optional filename)
  "Insert ghost file."
  (interactive "p")
  (rpm-insert-f "%ghost " filename))

(defun rpm-insert-dir (&optional dirname)
  "Insert directory."
  (interactive "p")
  (rpm-insert-f "%dir " dirname))

(defun rpm-insert-docdir (&optional dirname)
  "Insert doc directory."
  (interactive "p")
  (rpm-insert-f "%docdir " dirname))

;;------------------------------------------------------------
(defun rpm-completing-read (prompt table &optional pred require init hist)
  "Read from the minibuffer, with completion.
Like `completing-read', but the variable `rpm-spec-completion-ignore-case'
controls whether case is significant."
  (let ((completion-ignore-case rpm-spec-completion-ignore-case))
    (completing-read prompt table pred require init hist)))

(defun rpm-insert (&optional what file-completion)
  "Insert given tag.  Use file-completion if argument is t."
  (beginning-of-line)
  (if (not what)
      (setq what (rpm-completing-read "Tag: " rpm-tags-list)))
  (if (string-match "^%" what)
      (setq read-text (concat "Packagename for " what ": ")
            insert-text (concat what " "))
    (setq read-text (concat what ": ")
          insert-text (concat what ": ")))
  (cond
   ((string-equal what "Group")
    (rpm-insert-group))
   ((string-equal what "Source")
    (rpm-insert-n "Source"))
   ((string-equal what "Patch")
    (rpm-insert-n "Patch"))
   (t
    (if file-completion
        (insert insert-text (read-file-name (concat read-text) "" "" nil) "\n")
      (insert insert-text (read-from-minibuffer (concat read-text)) "\n")))))

(defun rpm-topdir ()
  (or
   (getenv "RPM")
   (getenv "rpm")
   (if (file-directory-p "~/rpm") "~/rpm/")
   (if (file-directory-p "~/RPM") "~/RPM/")
   (if (file-directory-p "/usr/src/redhat/") "/usr/src/redhat/")
   "/usr/src/RPM"))

(defun rpm-insert-n (what &optional arg)
  "Insert given tag with possible number."
  (save-excursion
    (goto-char (point-max))
    (if (search-backward-regexp (concat "^" what "\\([0-9]*\\):") nil t)
        (let ((release (1+ (string-to-int (match-string 1)))))
          (forward-line 1)
          (let ((default-directory (concat (rpm-topdir) "/SOURCES/")))
            (insert what (int-to-string release) ": "
                    (read-file-name (concat what "file: ") "" "" nil) "\n")))
      (goto-char (point-min))
      (rpm-end-of-section)
      (insert what ": " (read-from-minibuffer (concat what "file: ")) "\n"))))

(defun rpm-change (&optional what arg)
  "Update given tag."
  (save-excursion
    (if (not what)
        (setq what (rpm-completing-read "Tag: " rpm-tags-list)))
    (cond
     ((string-equal what "Group")
      (rpm-change-group))
     ((string-equal what "Source")
      (rpm-change-n "Source"))
     ((string-equal what "Patch")
      (rpm-change-n "Patch"))
     (t
      (goto-char (point-min))
      (if (search-forward-regexp (concat "^" what ":\\s-*\\(.*\\)$") nil t)
          (replace-match
           (concat what ": " (read-from-minibuffer
                              (concat "New " what ": ") (match-string 1))))
        (message "%s tag not found..." what))))))

(defun rpm-change-n (what &optional arg)
  "Change given tag with possible number."
  (save-excursion
    (goto-char (point-min))
    (let ((number (read-from-minibuffer (concat what " number: "))))
      (if (search-forward-regexp
           (concat "^" what number ":\\s-*\\(.*\\)") nil t)
          (let ((default-directory (concat (rpm-topdir) "/SOURCES/")))
            (replace-match
             (concat what number ": "
                     (read-file-name (concat "New " what number " file: ")
                                     "" "" nil (match-string 1)))))
        (message "%s number \"%s\" not found..." what number)))))

(defun rpm-insert-group (group)
  "Insert Group tag."
  (interactive (list (rpm-completing-read "Group: " rpm-group-tags-list)))
  (beginning-of-line)
  (insert "Group: " group "\n"))

(defun rpm-change-group (&optional arg)
  "Update Group tag."
  (interactive "p")
  (save-excursion
    (goto-char (point-min))
    (if (search-forward-regexp "^Group: \\(.*\\)$" nil t)
        (replace-match
         (concat "Group: "
                 (insert (rpm-completing-read "Group: " rpm-group-tags-list
                                              nil nil (match-string 1)))))
      (message "Group tag not found..."))))

(defun rpm-insert-tag (&optional arg)
  "Insert or change a tag."
  (interactive "p")
  (if current-prefix-arg
      (rpm-change)
    (rpm-insert)))

(defun rpm-change-tag (&optional arg)
  "Change a tag."
  (interactive "p")
  (rpm-change))

(defun rpm-insert-packager (&optional arg)
  "Insert Packager tag."
  (interactive "p")
  (beginning-of-line)
  (insert "Packager: " (or rpm-spec-user-full-name (user-full-name))
          " <" (rpm-spec-user-mail-address) ">\n"))

(defun rpm-change-packager (&optional arg)
  "Update Packager tag."
  (interactive "p")
  (rpm-change "Packager"))

;;------------------------------------------------------------

(defun rpm-current-section nil
  (interactive)
  (save-excursion
    (rpm-forward-section)
    (rpm-backward-section)
    (if (bobp) "preamble"
      (buffer-substring (match-beginning 1) (match-end 1)))))

(defun rpm-backward-section nil
  "Move backward to the beginning of the previous section.
Go to beginning of previous section."
  (interactive)
  (or (re-search-backward rpm-section-regexp nil t)
      (goto-char (point-min))))

(defun rpm-beginning-of-section nil
  "Move backward to the beginning of the current section.
Go to beginning of current section."
  (interactive)
  (or (and (looking-at rpm-section-regexp) (point))
      (re-search-backward rpm-section-regexp nil t)
      (goto-char (point-min))))

(defun rpm-forward-section nil
  "Move forward to the beginning of the next section."
  (interactive)
  (forward-char)
  (if (re-search-forward rpm-section-regexp nil t)
      (progn (forward-line 0) (point))
    (goto-char (point-max))))

(defun rpm-end-of-section nil
  "Move forward to the end of this section."
  (interactive)
  (forward-char)
  (if (re-search-forward rpm-section-regexp nil t)
      (forward-line -1)
    (goto-char (point-max)))
;;  (while (or (looking-at paragraph-separate) (looking-at "^\\s-*#"))
  (while (looking-at "^\\s-*\\($\\|#\\)")
    (forward-line -1))
  (forward-line 1)
  (point))

(defun rpm-goto-section (section)
  "Move point to the beginning of the specified section;
leave point at previous location."
  (interactive (list (rpm-completing-read "Section: " rpm-section-list)))
  (push-mark)
  (goto-char (point-min))
  (or
   (equal section "preamble")
   (re-search-forward (concat "^%" section "\\b") nil t)
   (let ((s (cdr rpm-sections)))
     (while (not (equal section (car s)))
       (re-search-forward (concat "^%" (car s) "\\b") nil t)
       (setq s (cdr s)))
     (if (re-search-forward rpm-section-regexp nil t)
         (forward-line -1) (goto-char (point-max)))
     (insert "\n%" section "\n"))))

(defun rpm-mouse-goto-section (&optional section)
  (interactive
   (x-popup-menu
    nil
    (list "sections"
          (cons "Sections" (mapcar (lambda (e) (list e e)) rpm-sections))
          (cons "Scripts" (mapcar (lambda (e) (list e e)) rpm-scripts))
          )))
  ;; If user doesn't pick a section, exit quietly.
  (and section
       (if (member section rpm-sections)
           (rpm-goto-section section)
         (goto-char (point-min))
         (or (re-search-forward (concat "^%" section "\\b") nil t)
             (and (re-search-forward "^%files\\b" nil t) (forward-line -1))
             (goto-char (point-max))))))

(defun rpm-insert-true-prefix ()
  (interactive)
  (insert "%{prefix}"))

;;------------------------------------------------------------

(defun rpm-build (buildoptions)
  "Build this RPM package."
  (if (and (buffer-modified-p)
           (y-or-n-p (format "Buffer %s modified, save it? " (buffer-name))))
      (save-buffer))
  (setq rpm-buffer-name
        (concat "*" rpm-spec-build-command " " buildoptions " "
                (file-name-nondirectory buffer-file-name) "*"))
  (rpm-process-check rpm-buffer-name)
  (if (get-buffer rpm-buffer-name)
      (kill-buffer rpm-buffer-name))
  (create-file-buffer rpm-buffer-name)
  (display-buffer rpm-buffer-name)
  (setq buildoptions (list buildoptions buffer-file-name))
  (if (or rpm-spec-short-circuit rpm-spec-nobuild)
      (setq rpm-no-gpg t))
  (if rpm-spec-rmsource
      (setq buildoptions (cons "--rmsource" buildoptions)))
  (if rpm-spec-clean
      (setq buildoptions (cons "--clean" buildoptions)))
  (if rpm-spec-short-circuit
      (setq buildoptions (cons "--short-circuit" buildoptions)))
  (if (and (not (equal rpm-spec-timecheck "0"))
           (not (equal rpm-spec-timecheck "")))
      (setq buildoptions (cons "--timecheck" (cons rpm-spec-timecheck
                                                   buildoptions))))
  (if (not (equal rpm-spec-buildroot ""))
      (setq buildoptions (cons "--buildroot" (cons rpm-spec-buildroot
                                                   buildoptions))))
  (if (not (equal rpm-spec-target ""))
      (setq buildoptions (cons "--target" (cons rpm-spec-target
                                                buildoptions))))
  (if rpm-spec-nobuild
      (setq buildoptions (cons rpm-spec-nobuild-option buildoptions)))
  (if rpm-spec-quiet
      (setq buildoptions (cons "--quiet" buildoptions)))
  (if rpm-spec-nodeps
      (setq buildoptions (cons "--nodeps" buildoptions)))
  (if (and rpm-spec-sign-gpg (not rpm-no-gpg))
      (setq buildoptions (cons "--sign" buildoptions)))
  (save-excursion
    (set-buffer (get-buffer rpm-buffer-name))
    (and rpm-spec-use-compilation-mode
         (fboundp 'compilation-mode)
         (compilation-mode))
    (goto-char (point-max)))
  (let* ((process-environment (cons "EMACS=t" process-environment))
         (process
          (apply 'start-process rpm-spec-build-command rpm-buffer-name
                 rpm-spec-build-command buildoptions)))
    (if (and rpm-spec-sign-gpg (not rpm-no-gpg))
        (let ((rpm-passwd-cache (read-passwd "GPG passphrase: ")))
          (process-send-string process (concat rpm-passwd-cache "\n"))))
    (set-process-filter process 'rpm-command-filter)))

(defun rpm-build-prepare (&optional arg)
  "Run a `rpmbuild -bp'."
  (interactive "p")
  (if rpm-spec-short-circuit
      (message "Cannot run `%s -bp' with --short-circuit"
	       rpm-spec-build-command)
    (setq rpm-no-gpg t)
    (rpm-build "-bp")))

(defun rpm-list-check (&optional arg)
  "Run a `rpmbuild -bl'."
  (interactive "p")
  (if rpm-spec-short-circuit
      (message "Cannot run `%s -bl' with --short-circuit"
	       rpm-spec-build-command)
    (setq rpm-no-gpg t)
    (rpm-build "-bl")))

(defun rpm-build-compile (&optional arg)
  "Run a `rpmbuild -bc'."
  (interactive "p")
  (setq rpm-no-gpg t)
  (rpm-build "-bc"))

(defun rpm-build-install (&optional arg)
  "Run a `rpmbuild -bi'."
  (interactive "p")
  (setq rpm-no-gpg t)
  (rpm-build "-bi"))

(defun rpm-build-binary (&optional arg)
  "Run a `rpmbuild -bb'."
  (interactive "p")
  (if rpm-spec-short-circuit
      (message "Cannot run `%s -bb' with --short-circuit"
	       rpm-spec-build-command)
    (setq rpm-no-gpg nil)
    (rpm-build "-bb")))

(defun rpm-build-source (&optional arg)
  "Run a `rpmbuild -bs'."
  (interactive "p")
  (if rpm-spec-short-circuit
      (message "Cannot run `%s -bs' with --short-circuit"
	       rpm-spec-build-command)
    (setq rpm-no-gpg nil)
    (rpm-build "-bs")))

(defun rpm-build-all (&optional arg)
  "Run a `rpmbuild -ba'."
  (interactive "p")
  (if rpm-spec-short-circuit
      (message "Cannot run `%s -ba' with --short-circuit"
	       rpm-spec-build-command)
    (setq rpm-no-gpg nil)
    (rpm-build "-ba")))

(defun rpm-process-check (buffer)
  "Check if BUFFER has a running process.
If so, give the user the choice of aborting the process or the current
command."
  (let ((process (get-buffer-process (get-buffer buffer))))
    (if (and process (eq (process-status process) 'run))
        (if (yes-or-no-p (concat "Process `" (process-name process)
                                 "' running.  Kill it? "))
            (delete-process process)
          (error "Cannot run two simultaneous processes ...")))))

;;------------------------------------------------------------

(defun rpm-toggle-short-circuit (&optional arg)
  "Toggle `rpm-spec-short-circuit'."
  (interactive "p")
  (setq rpm-spec-short-circuit (not rpm-spec-short-circuit))
  (rpm-update-mode-name)
  (message (concat "Turned `--short-circuit' "
                   (if rpm-spec-short-circuit "on" "off") ".")))

(defun rpm-toggle-rmsource (&optional arg)
  "Toggle `rpm-spec-rmsource'."
  (interactive "p")
  (setq rpm-spec-rmsource (not rpm-spec-rmsource))
  (rpm-update-mode-name)
  (message (concat "Turned `--rmsource' "
                   (if rpm-spec-rmsource "on" "off") ".")))

(defun rpm-toggle-clean (&optional arg)
  "Toggle `rpm-spec-clean'."
  (interactive "p")
  (setq rpm-spec-clean (not rpm-spec-clean))
  (rpm-update-mode-name)
  (message (concat "Turned `--clean' "
                   (if rpm-spec-clean "on" "off") ".")))

(defun rpm-toggle-nobuild (&optional arg)
  "Toggle `rpm-spec-nobuild'."
  (interactive "p")
  (setq rpm-spec-nobuild (not rpm-spec-nobuild))
  (rpm-update-mode-name)
  (message (concat "Turned `" rpm-spec-nobuild-option "' "
                   (if rpm-spec-nobuild "on" "off") ".")))

(defun rpm-toggle-quiet (&optional arg)
  "Toggle `rpm-spec-quiet'."
  (interactive "p")
  (setq rpm-spec-quiet (not rpm-spec-quiet))
  (rpm-update-mode-name)
  (message (concat "Turned `--quiet' "
                   (if rpm-spec-quiet "on" "off") ".")))

(defun rpm-toggle-sign-gpg (&optional arg)
  "Toggle `rpm-spec-sign-gpg'."
  (interactive "p")
  (setq rpm-spec-sign-gpg (not rpm-spec-sign-gpg))
  (rpm-update-mode-name)
  (message (concat "Turned `--sign' "
                   (if rpm-spec-sign-gpg "on" "off") ".")))

(defun rpm-toggle-add-attr (&optional arg)
  "Toggle `rpm-spec-add-attr'."
  (interactive "p")
  (setq rpm-spec-add-attr (not rpm-spec-add-attr))
  (rpm-update-mode-name)
  (message (concat "Default add \"attr\" entry turned "
                   (if rpm-spec-add-attr "on" "off") ".")))

(defun rpm-toggle-nodeps (&optional arg)
  "Toggle `rpm-spec-nodeps'."
  (interactive "p")
  (setq rpm-spec-nodeps (not rpm-spec-nodeps))
  (rpm-update-mode-name)
  (message (concat "Turned `--nodeps' "
                   (if rpm-spec-nodeps "on" "off") ".")))

(defun rpm-update-mode-name ()
  "Update `mode-name' according to values set."
  (setq mode-name "RPM-SPEC")
  (setq modes (concat (if rpm-spec-add-attr      "A")
                      (if rpm-spec-clean         "C")
                      (if rpm-spec-nodeps        "D")
                      (if rpm-spec-sign-gpg      "G")
                      (if rpm-spec-nobuild       "N")
                      (if rpm-spec-rmsource      "R")
                      (if rpm-spec-short-circuit "S")
		      (if rpm-spec-quiet         "Q")
                      ))
  (if (not (equal modes ""))
      (setq mode-name (concat mode-name ":" modes))))

;;------------------------------------------------------------

(defun rpm-change-timecheck-option (&optional arg)
  "Change the value for timecheck."
  (interactive "p")
  (setq rpm-spec-timecheck
        (read-from-minibuffer "New timecheck: " rpm-spec-timecheck)))

(defun rpm-change-buildroot-option (&optional arg)
  "Change the value for buildroot."
  (interactive "p")
  (setq rpm-spec-buildroot
        (read-from-minibuffer "New buildroot: " rpm-spec-buildroot)))

(defun rpm-change-target-option (&optional arg)
  "Change the value for target."
  (interactive "p")
  (setq rpm-spec-target
        (read-from-minibuffer "New target: " rpm-spec-target)))

(defun rpm-files-umask (&optional arg)
  "Change the default umask for files."
  (interactive "p")
  (setq rpm-default-umask
        (read-from-minibuffer "Default file umask: " rpm-default-umask)))

(defun rpm-files-owner (&optional arg)
  "Change the default owner for files."
  (interactive "p")
  (setq rpm-default-owner
        (read-from-minibuffer "Default file owner: " rpm-default-owner)))

(defun rpm-files-group (&optional arg)
  "Change the source directory."
  (interactive "p")
  (setq rpm-default-group
        (read-from-minibuffer "Default file group: " rpm-default-group)))

(defun rpm-increase-release-tag (&optional arg)
  "Increase the release tag by 1."
  (interactive "p")
  (save-excursion
    (goto-char (point-min))
    (if (search-forward-regexp
         ;; Try to find the last digit-only group of a dot-separated release string
         (concat "^\\(Release[ \t]*:[ \t]*\\)"
                 "\\(.*[ \t\\.}]\\)\\([0-9]+\\)\\([ \t\\.%].*\\|$\\)") nil t)
        (let ((release (1+ (string-to-int (match-string 3)))))
          (setq release
                (concat (match-string 2) (int-to-string release) (match-string 4)))
          (replace-match (concat (match-string 1) release))
          (message "Release tag changed to %s." release))
      (if (search-forward-regexp "^Release[ \t]*:[ \t]*%{?\\([^}]*\\)}?$" nil t)
          (rpm-increase-release-with-macros)
        (message "No Release tag to increase found...")))))

;;------------------------------------------------------------

(defun rpm-spec-field-value (field max)
  "Get the value of FIELD, searching up to buffer position MAX.
See `search-forward-regexp'."
  (save-excursion
    (condition-case nil
      (let ((str
             (progn
               (goto-char (point-min))
               (search-forward-regexp
                (concat "^" field ":[ \t]*\\(.*?\\)[ \t]*$") max)
               (match-string 1))))
        ;; Try to expand macros
        (if (string-match "\\(%{?\\(\\?\\)?\\)\\([a-zA-Z0-9_]*\\)\\(}?\\)" str)
            (let ((start-string (substring str 0 (match-beginning 1)))
                  (end-string (substring str (match-end 4))))
              (if (progn
                    (goto-char (point-min))
                    (search-forward-regexp
                     (concat "%\\(define\\|global\\)[ \t]+"
                             (match-string 3 str)
                             "[ \t]+\\(.*\\)") nil t))
                  ;; Got it - replace.
                  (concat start-string (match-string 2) end-string)
                (if (match-string 2 str)
                    ;; Conditionally evaluated macro - remove it.
                    (concat start-string end-string)
                  ;; Leave as is.
                  str)))
          str))
      (error nil))))

(defun rpm-find-spec-version (&optional with-epoch)
  "Get the version string.
If WITH-EPOCH is non-nil, the string contains the Epoch/Serial value,
if one is present in the file."
  (save-excursion
    (goto-char (point-min))
    (let* ((max (search-forward-regexp rpm-section-regexp))
           (version (rpm-spec-field-value "Version" max))
           (release (rpm-spec-field-value "Release" max))
           (epoch   (rpm-spec-field-value "Epoch"   max)) )
      (when (and version (< 0 (length version)))
        (unless epoch (setq epoch (rpm-spec-field-value "Serial" max)))
        (concat (and with-epoch epoch (concat epoch ":"))
                version
                (and release (concat "-" release)))))))

(defun rpm-increase-release-with-macros ()
  (save-excursion
    (let ((str
           (progn
             (goto-char (point-min))
             (search-forward-regexp "^Release[ \t]*:[ \t]*\\(.+\\).*$" nil)
             (match-string 1))))
      (let ((inrel
             (if (string-match "%{?\\([^}]*\\)}?$" str)
                 (progn
                   (goto-char (point-min))
                   (setq macros (substring str (match-beginning 1)
                                           (match-end 1)))
                   (search-forward-regexp
                    (concat "%define[ \t]+" macros
                            "[ \t]+\\(\\([0-9]\\|\\.\\)+\\)\\(.*\\)"))
                   (concat macros " " (int-to-string (1+ (string-to-int
                                                          (match-string 1))))
                           (match-string 3)))
               str)))
        (setq dinrel inrel)
        (replace-match (concat "%define " dinrel))
        (message "Release tag changed to %s." dinrel)))))

;;------------------------------------------------------------

(defun rpm-spec-initialize ()
  "Create a default spec file if one does not exist or is empty."
  (let (file name version (release rpm-spec-default-release))
    (setq file (if (buffer-file-name)
                   (file-name-nondirectory (buffer-file-name))
                 (buffer-name)))
    (cond
     ((eq (string-match "\\(.*\\)-\\([^-]*\\)-\\([^-]*\\).spec" file) 0)
      (setq name (match-string 1 file))
      (setq version (match-string 2 file))
      (setq release (match-string 3 file)))
     ((eq (string-match "\\(.*\\)-\\([^-]*\\).spec" file) 0)
      (setq name (match-string 1 file))
      (setq version (match-string 2 file)))
     ((eq (string-match "\\(.*\\).spec" file) 0)
      (setq name (match-string 1 file))))

    (if rpm-spec-indent-heading-values
	(insert
	 "Summary:        "
	 "\nName:           " (or name "")
	 "\nVersion:        " (or version "")
	 "\nRelease:        " (or release "")
	 (if rpm-spec-default-epoch
	     (concat "\nEpoch:          "
		     (int-to-string rpm-spec-default-epoch))
	   "")
	 "\nLicense:        "
	 "\nGroup:          "
	 "\nURL:            "
	 "\nSource0:        %{name}-%{version}.tar.gz"
	 "\nBuildRoot:      " rpm-spec-default-buildroot)
      (insert
       "Summary: "
       "\nName: " (or name "")
       "\nVersion: " (or version "")
       "\nRelease: " (or release "")
       (if rpm-spec-default-epoch
	   (concat "\nEpoch: " (int-to-string rpm-spec-default-epoch))
	 "")
       "\nLicense: "
       "\nGroup: "
       "\nURL: "
       "\nSource0: %{name}-%{version}.tar.gz"
       "\nBuildRoot: " rpm-spec-default-buildroot))

    (insert
     "\n\n%description\n"
     "\n%prep"
     "\n%setup -q"
     "\n\n%build\n"
     (or rpm-spec-default-build-section "")
     "\n%install\n"
     (or rpm-spec-default-install-section "")
     "\n%clean\n"
     (or rpm-spec-default-clean-section "")
     "\n\n%files"
     "\n%defattr(-,root,root,-)"
     "\n%doc\n"
     "\n\n%changelog\n")

    (end-of-line 1)
    (rpm-add-change-log-entry "Initial build.")))

;;------------------------------------------------------------

(defun rpm-spec-user-mail-address ()
  "User mail address helper."
  (cond
   (rpm-spec-user-mail-address
    rpm-spec-user-mail-address)
   ((fboundp 'user-mail-address)
    (user-mail-address))
   (t
    user-mail-address)))

;;------------------------------------------------------------

(defun rpm-about-rpm-spec-mode (&optional arg)
  "About `rpm-spec-mode'."
  (interactive "p")
  (message
   (concat "rpm-spec-mode version "
           rpm-spec-mode-version
           " by Stig Bjørlykke, <stigb@tihlde.org>")))

;;;###autoload(add-to-list 'auto-mode-alist '("\\.spec\\(\\.in\\)?$" . rpm-spec-mode))

(provide 'rpm-spec-mode)

;;; rpm-spec-mode.el ends here
