; Exercise 1.2
; (5 + 4 + (2 - (3 - (6 + 4/5))))/(3*(6 - 2)*(2 - 7))
(define num (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))))
(print "Numerator: " num)
(define den (* 3 (- 6 2) (- 2 7)))
(print "Denominator: " den)
(print "Result: "
       (/ (+ 5
             4
             (- 2
                (- 3
                   (+ 6
                      (/ 4 5)))))
          (* 3
             (- 6 2)
             (- 2 7))))
