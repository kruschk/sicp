;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1\n")
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (thrice f)
  (compose (compose f f) f))

(define (identity x) x)

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

(define (inc x)
  (+ x 1))

; a.
(display "a.\n")
(display (((thrice thrice) inc) 0)) (newline)
;((thrice thrice) f)
;`-> (thrice (thrice (thrice f)))
;`-> (thrice (thrice (lambda (x) (f (f (f x))))))
; ...
; Applying thrice twice is equivalent to composing 27 times; therefore, n = 27
(display ((repeated inc 27) 0)) (newline)

; b.
(display "b.\n")
; 1. Increment 27 times, starting from 6. The result is 33.
(display (((thrice thrice) 1+) 6)) (newline)
; 2. Composes the `identity` procedure with itself 27 times, which effectively
; does nothing, and the `identity` procedure is returned. Then, the `compose`
; procedure is passed as the `identity` procedure's argument, so the expression
; simply returns the `compose` procedure.
(display (((thrice thrice) identity) compose)) (newline)
; 3. Returns ((...((1^2)^2)...)^2) = 1.
(display (((thrice thrice) square) 1)) (newline)
; 4. Returns ((...((2^2)^2)...)^2) = really big number (40,403,563 digits long).
;(display (((thrice thrice) square) 2)) (newline)
