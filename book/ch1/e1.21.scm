;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.21
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (smallest-divisor n)
  (define (divisible-by? a) (= 0 (remainder n a)))
  (define (helper a)
    (cond ((> (square a) n) n)
          ((divisible-by? a) a)
          (else (helper (+ a 1)))))
  (helper 2))
(display (smallest-divisor   199)) (newline)
(display (smallest-divisor  1999)) (newline)
(display (smallest-divisor 19999)) (newline)
