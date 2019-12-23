;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.1.6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.1.6\n")
; Recursive fast-expt, which uses successive squaring.
; if n is even:
;     b <- b
;     n <- n/2
; else:
;     b <- b
;     n <- n - 1
(define (fast-expt b n)
  (define (even?)
    (= (remainder n 2) 0))
  (cond ((= n 0) 1)
        ((even?) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
(display (fast-expt 2  1)) (newline)
(display (fast-expt 2  2)) (newline)
(display (fast-expt 2  3)) (newline)
(display (fast-expt 2  4)) (newline)
(display (fast-expt 2  5)) (newline)
(display (fast-expt 2  6)) (newline)
(display (fast-expt 2  7)) (newline)
(display (fast-expt 2  8)) (newline)
(display (fast-expt 2  9)) (newline)
(display (fast-expt 2 10)) (newline)

; Iterative fast-expt, which uses successive squaring.
; If n is even: [a*b^n = a*(b^(n/2))^2 = a*(b^2)^(n/2)]
;     a <- a
;     b <- b^2
;     n <- n/2
; If n is odd: [a*b^n = a*b*b^(n - 1)]
;     a <- a*b
;     b <- b
;     n <- n - 1
; The product a*b^n is invariant under both transformations!
(define (fast-expt b n)
  (define (helper a b n)
    (cond ((= n 0) a)
          ((even? n) (helper a (square b) (/ n 2)))
          (else (helper (* a b) b (- n 1)))))
  (helper 1 b n))

(display (fast-expt 2  1)) (newline)
(display (fast-expt 2  2)) (newline)
(display (fast-expt 2  3)) (newline)
(display (fast-expt 2  4)) (newline)
(display (fast-expt 2  5)) (newline)
(display (fast-expt 2  6)) (newline)
(display (fast-expt 2  7)) (newline)
(display (fast-expt 2  8)) (newline)
(display (fast-expt 2  9)) (newline)
(display (fast-expt 2 10)) (newline)
(display (fast-expt 3 2)) (newline)
(display (fast-expt 3 3)) (newline)
(display (fast-expt 3 4)) (newline)

; Example:
; (fast-expt 2 8)
; `->(helper 1 2 8)
; `->(helper 1 4 4)
; `->(helper 1 16 2)
; `->(helper 1 256 1)
; `->(helper 256 256 0)
; `->256

; Example:
; (fast-expt 2 13)
; `->(helper 1 2 13)
; `->(helper 2 2 12)
; `->(helper 2 4 6)
; `->(helper 2 16 3)
; `->(helper 32 16 2)
; `->(helper 32 256 1)
; `->(helper 8192 256 0)
; `->8192
