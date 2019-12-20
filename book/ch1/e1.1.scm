; Exercise 1.1
(display "Exercise 1.1\n")
(display 10) (newline) ; Prints 10
(display (+ 5 3 4)) (newline) ; Prints 12
(display (- 9 1)) (newline) ; Prints 8
(display (/ 6 2)) (newline) ; Prints 3
(display (+ (* 2 4) (- 4 6))) (newline) ; Prints 6
(define a 3) ; a = 3
(define b (+ a 1)) ; b = 4
; Prints 4
(display (if (and (> b a)
                  (< b (* a b)))
             b
             a)) (newline)
; Prints 16
(display (cond ((= a 4) 6)
               ((= b 4) (+ 6 7 a))
               (else 25))) (newline)
; Prints 6
(display (+ 2 (if (> b a)
                  b
                  a))) (newline)
; Prints 16
(display (* (cond ((> a b) a)
                  ((< a b) b)
                  (else -1))
            (+ a 1))) (newline)
