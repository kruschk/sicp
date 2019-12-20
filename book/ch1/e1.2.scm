; Exercise 1.2
(display "Exercise 1.2\n")
; (5 + 4 + (2 - (3 - (6 + 4/5))))/(3*(6 - 2)*(2 - 7))
(define num (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))))
(display "Numerator: ") (display num) (newline)
(define den (* 3 (- 6 2) (- 2 7)))
(display "Denominator: ") (display den) (newline)
(display "Result: ")
(display (/ (+ 5
               4
               (- 2
                  (- 3
                     (+ 6
                        (/ 4 5)))))
            (* 3
               (- 6 2)
               (- 2 7)))) (newline)
