;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1\n")
; I can't debug this because there doesn't appear to be an error in the
; definition of fold. Not sure what I'm missing, but none of the procedures
; generate an error..
(define fold
  (lambda (x y)
    (* (spindle x)
       (+ (mutilate y)
          (spindle x)))))
(define spindle
  (lambda (w) (* w w)))
(define mutilate
  (lambda (z)
    (+ (spindle z) z)))

; Let's try substitution to see if it reveals anything...
(display (fold 1 2)) (newline)
(display (* (spindle 1)
            (+ (mutilate 2)
               (spindle 1)))) (newline)
(display (* (* 1 1)
            (+ (+ (spindle 2) 2)
               (* 1 1)))) (newline)
(display (* (* 1 1)
            (+ (+ (* 2 2) 2)
               (* 1 1)))) (newline)
(display (* (* 1 1)
            (+ (+ 4 2)
               1))) (newline)
(display (* (* 1 1)
            (+ 6 1))) (newline)
(display (* 1 7)) (newline)
(display 7) (newline)
; Nope, seems to work fine.

; All the functions seem to work.
(display (fold 1 2)) (newline)
(display (spindle 3)) (newline)
(display (mutilate 4)) (newline)
