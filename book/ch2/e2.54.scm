;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.54
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.54\n")

(define (equal? a b)
  (cond ((and (null? a) (null? b)) true) ; reached end of both lists
        ((and (pair? a) (pair? b))
         (and (eq? (car a) (car b))
              (equal? (cdr a) (cdr b))))
        (else (eq? a b))))

(define (equal? a b)
  (cond ((and (null? a) (null? b)) true) ; reached end of both lists
        ((and (symbol? a) (symbol? b)) (eq? a b))
        ((and (list? a) (list? b)) (and (equal? (car a) (car b))
                                        (equal? (cdr a) (cdr b))))
        (else false)))


(display (equal? '() '())) (newline) ; #t
(display (equal? '(the cow) '(says moo))) (newline) ; #f
(display (equal? '(this is a list) '(this is a list))) (newline) ; #t
(display (equal? '(this is a list) '(this (is a) list))) (newline) ; #f
(display (equal? '(this (is a) list) '(this (is a) list))) (newline) ; #t
