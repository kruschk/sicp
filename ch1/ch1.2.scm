; 1.2 Procedures and the Processes They Generate
(print "1.2 Procedures and the Processes They Generate")
; 1.2.1 Linear Recursion and Iteration
(print "1.2.1 Linear Recursion and Iteration")
(define (factorial n)
  (cond ((<= n 0) 1)
        ((<= n 2) n)
        (else (* n (factorial (- n 1))))))

(print "(factorial -42): " (factorial -42))
(print "(factorial 0): " (factorial 0))
(print "(factorial 1): " (factorial 1))
(print "(factorial 2): " (factorial 2))
(print "(factorial 3): " (factorial 3))
(print "(factorial 4): " (factorial 4))
(print "(factorial 5): " (factorial 5))

(define (factorial-rec n)
  (if (= n 1)
      1
      (* n (factorial-rec (- n 1)))))

(define (factorial n)
  (define (fact-iter product counter)
    (if (< n counter)
        product
        (fact-iter (* product counter)
                   (+ counter 1)
                   n)))
  (fact-iter 1 1 n))

(print "(factorial 6): " (factorial 6) "\n")

; 1.2.2. Tree Recursion
(print "1.2.2. Tree Recursion")

(define (fib n)
  (cond ((= 0 n) 0)
        ((= 1 n) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
(print "(fib 0): " (fib 0))
(print "(fib 1): " (fib 1))
(print "(fib 2): " (fib 2))
(print "(fib 3): " (fib 3))
(print "(fib 4): " (fib 4))
(print "(fib 5): " (fib 5))
(print "(fib 6): " (fib 6))
(print "(fib 7): " (fib 7))
(print "(fib 8): " (fib 8))

(define (fib-iter n)
  (define (fib-iter-helper a b count)
    (cond ((= 0 count) b)
          (else (fib-iter-helper (+ a b)
                                 a
                                 (- count 1)))))
  (fib-iter-helper 1 0 n))

(print "(fib-iter 0): " (fib-iter 0))
(print "(fib-iter 1): " (fib-iter 1))
(print "(fib-iter 2): " (fib-iter 2))
(print "(fib-iter 3): " (fib-iter 3))
(print "(fib-iter 4): " (fib-iter 4))
(print "(fib-iter 5): " (fib-iter 5))
(print "(fib-iter 6): " (fib-iter 6))
(print "(fib-iter 7): " (fib-iter 7))
(print "(fib-iter 8): " (fib-iter 8))
