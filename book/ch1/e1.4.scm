;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.4\n")
; The (if (> b 0) + -) combination tests if b is positive. If it is, it returns the `+` operator, but if it's nonpositive, it returns the `-` operator. Thus, depending on the value of b, the combination becomes either (+ a b) if b is positive, or (- a b) if b is negative.
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
