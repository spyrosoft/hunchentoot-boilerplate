(ql:quickload :hunchentoot)

(defpackage :PROJECT-NAME
  (:use :common-lisp
        :cl-who
        :hunchentoot
        ))

(in-package :PROJECT-NAME)

(defvar PROJECT-NAME-server
  (make-instance 'hunchentoot:easy-acceptor
                 :document-root "."
                 :error-template-directory "static/error-templates/"
                 :access-log-destination "logs/access.log"
                 :message-log-destination "logs/message.log"
                 :port 8080))

(load "static.lisp")

(hunchentoot:start PROJECT-NAME-server)