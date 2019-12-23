; Exercise 3
(define fact
  (lambda (n)
    (if (= n 0)
        1
        (* n (fact (- n 1))))))
(display (fact 5)) (newline)

; Naive `n` choose `k` implementation.
(define comb
  (lambda (n k)
    (/ (fact n)
       (* (fact k)
          (fact (- n k))))))

(display (comb 243 90)) (newline)
