(ql:quickload :hunchentoot)
(ql:quickload :cl-who)

(defpackage :PROJECT-NAME
  (:use :common-lisp
        :cl-who
        :hunchentoot
        ))

(in-package :PROJECT-NAME)

;; Needed if you set :error-template-directory in the easy-acceptor
(setf hunchentoot::*show-lisp-errors-p* t)

(defvar PROJECT-NAME-server
  (make-instance 'hunchentoot:easy-acceptor
                 :document-root "."
                 :error-template-directory "static/error-templates/"
                 :access-log-destination "logs/access.log"
                 :message-log-destination "logs/error.log"
                 :port 8080))

(load "static.lisp")

(hunchentoot:start PROJECT-NAME-server)