; Exercise 1.1
(print 10) ; Prints 10
(print (+ 5 3 4)) ; Prints 12
(print (- 9 1)) ; Prints 8
(print (/ 6 2)) ; Prints 3
(print (+ (* 2 4) (- 4 6))) ; Prints 6
(define a 3) ; a = 3
(define b (+ a 1)) ; b = 4
; Prints 4
(print (if (and (> b a)
                (< b (* a b)))
           b
           a))
; Prints 16
(print (cond ((= a 4) 6)
             ((= b 4) (+ 6 7 a))
             (else 25)))
; Prints 6
(print (+ 2 (if (> b a)
                b
                a)))
; Prints 16
(print (* (cond ((> a b) a)
                ((< a b) b)
                (else -1))
          (+ a 1)))
