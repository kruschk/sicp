;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.35
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.35\n")
; The golden ratio is the number that satisfies phi^2 = phi + 1. Dividing both
; sides by phi yields phi = 1 + 1/phi. Since a fixed point of a function is a
; number x such that f(x) = x, we can define f(phi) = phi = 1 + 1/phi and apply
; the `fixed-point` procedure to the function f(phi) = 1 + 1/phi.

; The fixed-point procedure
(define (fixed-point f first-guess)
  (let ((tolerance 0.00001))
    (define (close-enough? v1 v2)
      (< (abs (- v1 v2)) tolerance))
    (define (try guess)
      (let ((next (f guess)))
        (if (close-enough? guess next)
            next
            (try next))))
    (try first-guess)))

; Computing phi by means of `fixed-point`.
(display (fixed-point (lambda (phi) (+ 1 (/ 1 phi)))
                      1.0)) (newline)
