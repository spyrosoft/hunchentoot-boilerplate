(defvar *this-file* (load-time-value
                     (or #.*compile-file-pathname* *load-pathname*)))

(defvar *hunchentoot-directory*
  (pathname (directory-namestring #.(or *compile-file-pathname* *load-truename*))))

;; Route / to index.html and serve it as text/html
(push (create-static-file-dispatcher-and-handler
       "/"
       (make-pathname :directory (merge-pathnames "static" *hunchentoot-directory*)
                      :name "index" :type "html"
                      :version nil :defaults *this-file*)
       "text/html")
      *dispatch-table*)

;; Route everything in /css/ to the static/css directory and serve it as text/html
(push (create-folder-dispatcher-and-handler
       "/css/"
       (make-pathname :directory (merge-pathnames "static/css" *hunchentoot-directory*)
                      :name nil :type nil
                      :version nil :defaults *this-file*)
       "text/css")
      *dispatch-table*)

;; Route everything in /js/ to the static/css directory and serve it as text/javascript
(push (create-folder-dispatcher-and-handler
       "/js/"
       (make-pathname :directory (merge-pathnames "static/js" *hunchentoot-directory*)
                      :name nil :type nil
                      :version nil :defaults *this-file*)
       "text/javascript")
      *dispatch-table*)

;; Route everything in /images/ to the static/images directory and serve it as whatever mime type is appropriate
(push (create-folder-dispatcher-and-handler
       "/images/"
       (make-pathname :directory (merge-pathnames "static/images" *hunchentoot-directory*)
                      :name nil :type nil
                      :version nil :defaults *this-file*)
       nil)
      *dispatch-table*)

;; Route /robots.txt to the actual file and serve it as text/plain
(push (create-static-file-dispatcher-and-handler
       "/robots.txt"
       (make-pathname :directory (merge-pathnames "static" *hunchentoot-directory*)
                      :name "robots" :type "txt"
                      :version nil :defaults *this-file*)
       "text/plain")
      *dispatch-table*)