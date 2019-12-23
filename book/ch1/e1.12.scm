;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercisve 1.12
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.12\n")

(define (P depth i)
  (cond ((or (< depth 0) (< i 0) (< depth i)) 0)
        ((or (= depth 0) (= i 0) (= depth i)) 1)
        (else (+ (P (- depth 1) (- i 1))
                 (P (- depth 1) i)))))

(display (P 0 0)) (newline)
(display (P 1 0)) (display " ")
(display (P 1 1)) (newline)
(display (P 2 0)) (display " ")
(display (P 2 1)) (display " ")
(display (P 2 2)) (newline)
(display (P 3 0)) (display " ")
(display (P 3 1)) (display " ")
(display (P 3 2)) (display " ")
(display (P 3 3)) (newline)
(display (P 4 0)) (display " ")
(display (P 4 1)) (display " ")
(display (P 4 2)) (display " ")
(display (P 4 3)) (display " ")
(display (P 4 4)) (newline)
