;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(require 'package)

;; add MELPA
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
)

;; paren highlighting
(show-paren-mode 1)
(setq show-paren-delay 0)

;;emulate vim's % key
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis AND last command is a movement command, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (message "%s" last-command)
  (if (not (memq last-command '(
                                set-mark
                                cua-set-mark
                                goto-match-paren
                                down-list
                                up-list
                                end-of-defun
                                beginning-of-defun
                                backward-sexp
                                forward-sexp
                                backward-up-list
                                forward-paragraph
                                backward-paragraph
                                end-of-buffer
                                beginning-of-buffer
                                backward-word
                                forward-word
                                mwheel-scroll
                                backward-word
                                forward-word
                                mouse-start-secondary
                                mouse-yank-secondary
                                mouse-secondary-save-then-kill
                                move-end-of-line
                                move-beginning-of-line
                                backward-char
                                forward-char
                                scroll-up
                                scroll-down
                                scroll-left
                                scroll-right
                                mouse-set-point
                                next-buffer
                                previous-buffer
                                )
                 ))
      (self-insert-command (or arg 1))
    (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
          ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
          (t (self-insert-command (or arg 1))))))
(global-set-key (kbd "%") 'goto-match-paren)

(defun buffer-exists (bufname) (not (eq nil (get-buffer bufname))))

(defun run-test (arg)
  (interactive "p")
  (let ((output-buff "*test-output*")
        (args (concat
               (file-name-directory (buffer-file-name))
               "spec/"
               (file-name-nondirectory (file-name-sans-extension (buffer-file-name)))
               "_spec."
               (file-name-extension (buffer-file-name)))))

    (if (buffer-exists output-buff)
        (kill-buffer output-buff))

    (start-process "test" (generate-new-buffer output-buff) "~/sspec/bin/sspec" args)
    (switch-to-buffer-other-window output-buff))
  )
(global-set-key (kbd "C-c T") 'run-test)

(defun go-to-test (arg)
  (interactive "p")

  (let ((spec-file (concat
                    (file-name-directory (buffer-file-name))
                    "spec/"
                    (file-name-nondirectory (file-name-sans-extension (buffer-file-name)))
                    "_spec."
                    (file-name-extension (buffer-file-name)))))

    (switch-to-buffer (find-file spec-file))))
(global-set-key (kbd "C-c f t") 'go-to-test)

(defun go-to-implementation (arg)
    (interactive "p")

  (let ((implementation-file (concat
                              "../"
                              (replace-regexp-in-string "_spec" "" (file-name-nondirectory (buffer-file-name))))))

    (switch-to-buffer (find-file implementation-file))))
(global-set-key (kbd "C-c f i") 'go-to-implementation)

;;tabs == spaces
(setq indent-tabs-mode nil)

;;turn on mark highlighting
(transient-mark-mode t)

; trim trailing whitespace
(global-set-key (kbd "C-c w") 'delete-trailing-whitespace)

;;let's see those column numbers!
(column-number-mode t)

(define-globalized-minor-mode my-global-linum-mode linum-mode
  (lambda ()
    (unless (or (minibufferp)
                (derived-mode-p 'doc-view-mode 'shell-mode))
      (linum-mode 1))))
(my-global-linum-mode 1)
