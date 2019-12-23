; Exercise 2
; Bug: the factorial function's consequent expression was missing.
(define fact
  (lambda (n)
    (if (= n 0)
        1
        (* n (fact (- n 1))))))
(display (fact 5)) (newline)
(display (fact 243)) (newline)
