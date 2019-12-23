;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.17
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.17\n")

; This is the times implementation given in the book.
(define (times a b)
  (if (= b 0)
      0
      (+ a
         (times a
                (- b 1)))))

(display (times 7 4)) (newline)
(display (times 6 3)) (newline)
(display (times 12 5)) (newline)
(display (times 7 8)) (newline)

; Define `double` and `halve` procedures (which could be implemented using bit
; operations for lightning speed!).
(define (double n) (* 2 n))
(define (halve n) (/ n 2))

; `fast-times` uses a recursive process which requires an (approximately)
; logarithmic number of steps.
; a*b = (2*a)*b/2
;     a <- 2*a
;     b <- b/2
; a*b = a + a*(b - 1)
;     a <- a
;     b <- b - 1
(define (fast-times a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-times (double a)
                               (halve b)))
        (else (+ a
                 (fast-times a
                             (- b 1))))))

(display (fast-times 7 4)) (newline)
(display (fast-times 6 3)) (newline)
(display (fast-times 12 5)) (newline)
(display (fast-times 7 8)) (newline)

; Example:
; (fast-times 12 5)
; `->(+ 12 (fast-times 12 4))
; `->(+ 12 (fast-times 24 2))
; `->(+ 12 (fast-times 48 1))
; `->(+ 12 (+ 48 (fast-times (48 0))))
; `->(+ 12 (+ 48 0))
; `->(+ 12 (48))
; `->60
