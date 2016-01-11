(defvar *this-file* #.(or *compile-file-pathname* *load-truename*))

(defvar *hunchentoot-directory*
  (pathname (directory-namestring *this-file*)))

;; Route / to index.html and serve it as text/html
(push (create-static-file-dispatcher-and-handler
       "/"
       (merge-pathnames (make-pathname :directory '(:relative "static")
                                       :name "index" :type "html"
                                       :version nil :defaults *this-file*)
                        *hunchentoot-directory*)
       "text/html")
      *dispatch-table*)

;; Route everything in /css/ to the static/css directory and serve it as text/html
(push (create-folder-dispatcher-and-handler
       "/css/"
       (merge-pathnames (make-pathname :directory '(:relative "static/css")
                                       :name nil :type nil
                                       :version nil :defaults *this-file*)
                        *hunchentoot-directory*)
       "text/css")
      *dispatch-table*)

;; Route everything in /js/ to the static/css directory and serve it as text/javascript
(push (create-folder-dispatcher-and-handler
       "/js/"
       (merge-pathnames (make-pathname :directory '(:relative "static/js")
                                       :name nil :type nil
                                       :version nil :defaults *this-file*)
                        *hunchentoot-directory*)
       "text/javascript")
      *dispatch-table*)

;; Route everything in /images/ to the static/images directory and serve it as whatever mime type is appropriate
(push (create-folder-dispatcher-and-handler
       "/images/"
       (merge-pathnames (make-pathname :directory '(:relative "static/images")
                                       :name nil :type nil
                                       :version nil :defaults *this-file*)
                        *hunchentoot-directory*)
       nil)
      *dispatch-table*)

;; Route /robots.txt to the actual file and serve it as text/plain
(push (create-static-file-dispatcher-and-handler
       "/robots.txt"
       (merge-pathnames (make-pathname :directory '(:relative "static")
                                       :name "robots" :type "txt"
                                       :version nil :defaults *this-file*)
                        *hunchentoot-directory*)
       "text/plain")
      *dispatch-table*)