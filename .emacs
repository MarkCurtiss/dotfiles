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

;;tabs == spaces
(setq indent-tabs-mode nil)

;;turn on mark highlighting
(transient-mark-mode t)

; trim trailing whitespace
(global-set-key (kbd "C-c w") 'delete-trailing-whitespace)
