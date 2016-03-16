(defun route-file (route directory file-name file-type &optional mime-type)
  (let ((directory-pathname
         (if (equal directory "/")
             *web-root-directory*
             (merge-pathnames directory *web-root-directory*))))
    (push (create-static-file-dispatcher-and-handler
           route
           (merge-pathnames
            (make-pathname :name file-name :type file-type)
            directory-pathname)
           mime-type)
          *dispatch-table*)
  ))

(defun route-directory (route directory &optional mime-type)
  (let ((directory-pathname
         (if (equal directory "/")
             *web-root-directory*
             (merge-pathnames directory *web-root-directory*))))
    (push (create-folder-dispatcher-and-handler
           route
           directory-pathname
           mime-type)
          *dispatch-table*)
  ))