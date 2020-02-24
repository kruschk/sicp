;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.4\n")

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

; This is how it works, using the substitution model to illustrate
; (applicative-order evaluation):
; (car (cons x y))
; `-> ((cons x y) (lambda (p q) p))
; `-> ((lambda (m) (m x y)) (lambda (p q) p))
; `-> ((lambda (p q) p) x y)
; `-> x

; Here's an implementation of `cdr` to go along with it:
(define (cdr z)
  (z (lambda (p q) q)))

; Test the procedures:
(let ((p (cons 1 2)))
  (display (car p)) (newline)
  (display (cdr p)) (newline))
; They work!
