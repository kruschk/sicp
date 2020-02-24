;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.41
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.41\n")

(define (inc x) (+ x 1))

; Double takes a procedure and returns a procedure that applies the original
; procedure two times.
(define (double f)
  (lambda (x) (f (f x))))

(display ((double inc) 7)) (newline) ; Should display 9.

(display (((double (double double)) inc) 5)) (newline) ; Displays 21
; (((double (double double)) inc) 5)
; `-> (((double (lambda (x) (double (double x)))) inc) 5)
; The substitution gets crazy quickly...
; `-> (((lambda (y) ((lambda (x) (double (double x))) ((lambda (x) (double (double x))) y))) inc) 5)
; `-> (((lambda (x) (double (double x))) ((lambda (x) (double (double x))) inc)) 5)
; `-> (((lambda (x) (double (double x))) ((double (double inc))))) 5)
; `-> (((double (double (double (double inc))))) 5)
; `-> (((double (double (double (lambda (x) (inc (inc x))))))) 5)
; ...and so on...
