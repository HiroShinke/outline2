;; outline2.el --- outline derived mode for Emacs
;; a mode more graphical by means of indentation
;; $Id: outline2.el,v 1.10 2008/06/02 15:46:39 shinke Exp $
;; Hirofumi SHINKE <hiro.shinke@gmail.com>

(defvar outline2-regexp-base (concat "\\(・\\|○\\|△\\|□\\|−\\|▽\\|？\\|！\\|×\\|>>\\|"
                                    "[[:digit:]]+\\.\\|[[:digit:]]+)\\|([[:digit:]]+\\)") )
(defvar outline2-regexp (concat "[ \t]*" outline2-regexp-base))
(defvar outline2-regexp-caution "\\(！\\|×\\)" )
(defvar outline2-regexp-inbox "\\(？\\)" )
(defvar outline2-regexp-attention "\\(▽\\)" )
(defvar outline2-regexp-wait "\\(□\\)" )

(defmacro outline2-defface-background (face base color text)
 `(defface ,face
    '((t (:background ,color :weight bold :inherit ,base)))
    ,text
    :group 'outlines))

;; (defface outline2-1
;;    '((t (:background "yellow1" :weight bold :inherit outline-1)))
;;    "Level 1."
;;    :group 'outlines)

(outline2-defface-background outline2-1 outline-1 "yellow1" "Level 1.")
(outline2-defface-background outline2-2 outline-2 "yellow1" "Level 2.")
(outline2-defface-background outline2-3 outline-3 "yellow1" "Level 3.")
(outline2-defface-background outline2-4 outline-4 "yellow1" "Level 4.")
(outline2-defface-background outline2-5 outline-5 "yellow1" "Level 5.")
(outline2-defface-background outline2-6 outline-6 "yellow1" "Level 6.")
(outline2-defface-background outline2-7 outline-7 "yellow1" "Level 7.")
(outline2-defface-background outline2-8 outline-8 "yellow1" "Level 8.")

(defvar outline2-bold-faces
 [outline2-1 outline2-2 outline2-3 outline2-4
  outline2-5 outline2-6 outline2-7 outline2-8])

(outline2-defface-background outline2-2-1 outline-1 "gold1" "Level 1.")
(outline2-defface-background outline2-2-2 outline-2 "gold1" "Level 2.")
(outline2-defface-background outline2-2-3 outline-3 "gold1" "Level 3.")
(outline2-defface-background outline2-2-4 outline-4 "gold1" "Level 4.")
(outline2-defface-background outline2-2-5 outline-5 "gold1" "Level 5.")
(outline2-defface-background outline2-2-6 outline-6 "gold1" "Level 6.")
(outline2-defface-background outline2-2-7 outline-7 "gold1" "Level 7.")
(outline2-defface-background outline2-2-8 outline-8 "gold1" "Level 8.")

(defvar outline2-bold-faces2
 [outline2-2-1 outline2-2-2 outline2-2-3 outline2-2-4
  outline2-2-5 outline2-2-6 outline2-2-7 outline2-2-8])

(outline2-defface-background outline2-3-1 outline-1 "aquamarine1" "Level 1.")
(outline2-defface-background outline2-3-2 outline-2 "aquamarine1" "Level 2.")
(outline2-defface-background outline2-3-3 outline-3 "aquamarine1" "Level 3.")
(outline2-defface-background outline2-3-4 outline-4 "aquamarine1" "Level 4.")
(outline2-defface-background outline2-3-5 outline-5 "aquamarine1" "Level 5.")
(outline2-defface-background outline2-3-6 outline-6 "aquamarine1" "Level 6.")
(outline2-defface-background outline2-3-7 outline-7 "aquamarine1" "Level 7.")
(outline2-defface-background outline2-3-8 outline-8 "aquamarine1" "Level 8.")

(defvar outline2-bold-faces3
 [outline2-3-1 outline2-3-2 outline2-3-3 outline2-3-4
  outline2-3-5 outline2-3-6 outline2-3-7 outline2-3-8])

(outline2-defface-background outline2-4-1 outline-1 "rosybrown1" "Level 1.")
(outline2-defface-background outline2-4-2 outline-2 "rosybrown1" "Level 2.")
(outline2-defface-background outline2-4-3 outline-3 "rosybrown1" "Level 3.")
(outline2-defface-background outline2-4-4 outline-4 "rosybrown1" "Level 4.")
(outline2-defface-background outline2-4-5 outline-5 "rosybrown1" "Level 5.")
(outline2-defface-background outline2-4-6 outline-6 "rosybrown1" "Level 6.")
(outline2-defface-background outline2-4-7 outline-7 "rosybrown1" "Level 7.")
(outline2-defface-background outline2-4-8 outline-8 "rosybrown1" "Level 8.")

(defvar outline2-bold-faces4
 [outline2-4-1 outline2-4-2 outline2-4-3 outline2-4-4
  outline2-4-5 outline2-4-6 outline2-4-7 outline2-4-8])

;; (defun outline2-outline-level () 
;;   (save-excursion
;;    (let ((str nil))
;;      (looking-at outline-regexp)
;;      (setq str
;;            (buffer-substring-no-properties
;;             (match-beginning 0) (match-end 0)))
;;      (while (string-match "\t"str)
;;        (setq str (replace-match "    " t t str)))
;;      (/ (length (encode-coding-string str 'sjis)) 2))))

(defun outline2-outline-level () 
 (save-excursion
   (let ((str nil))
     (looking-at outline-regexp)
     (/ (save-excursion
          (goto-char (match-end 0))
          (current-column)) 
        2))))

(defun outline2-font-lock-face ()
 (let ((lock-faces 
        (save-excursion
          (goto-char (match-beginning 1))
          (cond ((save-match-data 
                   (looking-at outline2-regexp-caution)) outline2-bold-faces)
                ((save-match-data 
                   (looking-at outline2-regexp-wait)) outline2-bold-faces3)
                ((save-match-data 
                   (looking-at outline2-regexp-inbox)) outline2-bold-faces4)
                ((save-match-data 
                   (looking-at outline2-regexp-attention)) outline2-bold-faces2)

                (t outline-font-lock-faces)))))
   (save-excursion
     (goto-char (match-beginning 0))
     (looking-at outline-regexp)
     (condition-case nil
         (aref lock-faces (1- (funcall outline-level)))
       (error font-lock-warning-face)))))

;; use match 1 for fontification
;; see elisp.info. font-lock-keywords

(defvar outline2-font-lock-keywords
 '(;;
   ;; Highlight headings according to the level.
   (eval . (list (concat "^[ \t]*\\(" outline2-regexp-base ".+\\)")
         1 '(outline2-font-lock-face) nil t)))
 "Additional expressions to highlight in Outline mode.")

(defun outline2-kill-subtree ()
 "interactive for debubugging"
 (interactive)
 (save-excursion
   (outline-back-to-heading)
   (kill-region (point)
             (progn (outline-end-of-subtree) (point)) )))

(defun outline2-indent-subtree (&optional n)
 "interactive for debubugging"
 (interactive "p")
 (save-excursion
   (outline-back-to-heading)
   (indent-rigidly (point)
                   (progn (outline-end-of-subtree) (point))
                   (if (zerop n) 2 (* n 2) ))))

(defun outline2-unindent-subtree (&optional n)
 "Move the currrent subtree up past ARG headlines of the same level."
 (interactive "p")
 (outline2-indent-subtree (if (zerop n) -2 (- n))))

(defun outline2-open-external-link ()
 "Open external link"
 (interactive)
 (let ((save (point)))
   (goto-char (line-beginning-position))
   (re-search-forward ">>\\(.+\\)" nil t)
   (goto-char save)
   (let ((name (match-string 1)))
     (let* ((b (get-buffer name))
;;             (dir (if (string-match "^(.+/)" name)
;;                     (match-string 0 name) nil))
;;             (base (substring name (match-end 0)))
            )
       (if b 
           (switch-to-buffer-other-window b)
         (let 
             ((name (read-file-name "open external link: "
;                                     (if dir dir default-directory)
                                    default-directory
                                    name
                                    nil
                                    name)))
           (if (string-match "\.txt$" name)
               (find-file-other-window name)
             (start-process name nil "fiber.exe" name))))))))

(defvar outline2-mode-map
 (let ((map (make-sparse-keymap)))
   (define-key map "\C-ci" 'outline2-indent-subtree)
;;    (define-key map "\C-c\C-TAB" 'outline2-indent-subtree)
   (define-key map "\C-c\C-h" 'outline2-unindent-subtree)
   (define-key map "\C-c\177" 'outline2-unindent-subtree)
   (define-key map "\C-ck" 'outline2-kill-subtree)
   (define-key map "\C-co" 'outline2-open-external-link)
   (define-key map "\C-cl" 'outline2-open-external-link)
   (define-key map "\C-cf" 'outline2-open-external-link)
   map ))

(define-derived-mode outline2-mode outline-mode "Outline2"
 "outline editing mode with my own customization"
 (set (make-local-variable 'outline-regexp) outline2-regexp)
 (set (make-local-variable 'outline-font-lock-keywords) outline2-font-lock-keywords )
 (set (make-local-variable 'outline-level) (function outline2-outline-level)) )

(provide 'outline2)


