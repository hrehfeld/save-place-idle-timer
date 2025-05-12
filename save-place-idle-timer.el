;;; save-place-idle-timer.el --- Auto-save place with idle timer

;; Author: Your Name <your.email@example.com>
;; Version: 1.0
;; Package-Requires: ((emacs "24.3"))
;; Keywords: convenience, files
;; URL: http://example.com/save-place-idle-timer

;;; Commentary:

;; This package provides a globalized minor mode that automatically
;; saves the place (position in files) to a file after a specified
;; period of inactivity.

;;; Usage:

;; (require 'save-place-idle-timer)
;; (save-place-idle-timer-mode 1)

;;; Code:
(require 'saveplace)

(defgroup save-place-idle-timer nil
  "Auto-save place using an idle timer."
  :group 'convenience)

(defcustom save-place-idle-timer-idle-time 1
  "Duration (in seconds) of inactivity before auto-saving place."
  :type 'integer
  :group 'save-place-idle-timer)

(defvar save-place-idle-timer--timer nil
  "Internal timer for auto-save place functionality.")

(defun save-place-idle-timer--start-timer ()
  "Start or restart the idle timer for auto-saving place."
  (unless save-place-idle-timer--timer
    (setq save-place-idle-timer--timer
          (run-with-idle-timer save-place-idle-timer-idle-time t #'save-place-alist-to-file))
    ))

(defun save-place-idle-timer--stop-timer ()
  "Stop the idle timer for auto-saving place."
  (when save-place-idle-timer--timer
    (cancel-timer save-place-idle-timer--timer)
    (setq save-place-idle-timer--timer nil)))

;;;###autoload
(define-minor-mode save-place-idle-timer-mode
  "Toggle automatic saving of place using an idle timer.
When this mode is enabled, Emacs will auto-save the place to a file after
a period of inactivity specified by `save-place-idle-timer-idle-time`."
  :global t
  :require 'save-place-idle-timer
  :group 'save-place-idle-timer
  (if save-place-idle-timer-mode
      (save-place-idle-timer--start-timer)
    (save-place-idle-timer--stop-timer)))

(provide 'save-place-idle-timer)

;;; save-place-idle-timer.el ends here
