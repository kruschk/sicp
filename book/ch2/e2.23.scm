;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.23
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.23")

; Using a janky helper function.
(define (for-each proc items)
  (define (apply-two f g)
    (f)
    (g))
  (if (null? items)
      #t
      (apply-two (lambda () (proc (car items)))
                 (lambda () (for-each proc (cdr items))))))

; Using a helper procedure.
(define (for-each proc items)
  (define (helper proc items help)
    (if (null? items)
        #t
        (helper proc
                (cdr items)
                (proc (car items)))))
  (helper proc items (lambda () ())))

; With a janky lambda:
(define (for-each proc items)
  (if (null? items)
      #t
      ((lambda (x) (for-each proc (cdr items))) (proc (car items)))))

; With a `begin` block (probably the right way). I'd be interested in
; learning how `begin` is implemented.
(define (for-each proc items)
  (if (null? items)
      #t
      (begin (proc (car items))
             (for-each proc (cdr items)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88)) (newline)
