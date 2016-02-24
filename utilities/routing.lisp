(defvar *hunchentoot-directory*
  (pathname (directory-namestring *this-file*)))

(defun route-file (route directory file-name file-type &optional mime-type)
  (push (create-static-file-dispatcher-and-handler
         route
         (merge-pathnames (make-pathname :directory `(:relative ,(concatenate 'string "web-root" directory))
                                         :name file-name :type file-type
                                         :version nil :defaults *this-file*)
                          *hunchentoot-directory*)
         mime-type)
        *dispatch-table*)
  )

(defun route-directory (route directory &optional mime-type)
  (push (create-folder-dispatcher-and-handler
         route
         (merge-pathnames (make-pathname :directory `(:relative ,(concatenate 'string "web-root" directory))
                                         :name nil :type nil
                                         :version nil :defaults *this-file*)
                          *hunchentoot-directory*)
         mime-type)
        *dispatch-table*)
  )