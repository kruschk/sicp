;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.18
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.18\n")

; Define `double` and `halve` procedures (which could be implemented using bit
; operations for lightning speed!).
(define (double n) (* 2 n))
(define (halve n) (/ n 2))

; `fast-times` uses an iterative process which requires an (approximately)
; logarithmic number of steps.
; acc + a*b = acc + (2*a)*b/2 if b is even
;     acc <- acc
;     a <- 2*a
;     b <- b/2
; acc + a*b = (acc + a) + a*(b - 1) if b is odd
;     acc <- acc + a
;     a <- a
;     b <- b - 1
(define (fast-times a b)
  (define (helper acc a b)
    (cond ((= b 0) acc)
          ((even? b) (helper acc
                             (double a)
                             (halve b)))
          (else (helper (+ acc a)
                        a
                        (- b 1)))))
  (helper 0 a b))

(display (fast-times 7 4)) (newline)
(display (fast-times 6 3)) (newline)
(display (fast-times 12 5)) (newline)
(display (fast-times 7 8)) (newline)

; Example:
; (fast-times 12 5)
; `->(helper 0 12 5)
; `->(helper (+ 0 12)
; `->        12
; `->        (- 5 1))
; `->(helper 12 12 4)
; `->(helper 12 (double 12) (halve 4))
; `->(helper 12 24 2)
; `->(helper 12 (double 24) (halve 2))
; `->(helper 12 48 1)
; `->(helper (+ 12 48)
; `->        48
; `->        (- 1 1))
; `->(helper 60 48 0)
; `->60
