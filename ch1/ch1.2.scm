; 1.2 Procedures and the Processes They Generate
(display "1.2 Procedures and the Processes They Generate\n")
; 1.2.1 Linear Recursion and Iteration
(display "\n1.2.1 Linear Recursion and Iteration\n")
(define (factorial n)
  (cond ((<= n 0) 1)
        ((<= n 2) n)
        (else (* n (factorial (- n 1))))))

(display "(factorial -42): ") (display (factorial -42)) (newline)
(display "(factorial 0): ") (display (factorial 0)) (newline)
(display "(factorial 1): ") (display (factorial 1)) (newline)
(display "(factorial 2): ") (display (factorial 2)) (newline)
(display "(factorial 3): ") (display (factorial 3)) (newline)
(display "(factorial 4): ") (display (factorial 4)) (newline)
(display "(factorial 5): ") (display (factorial 5)) (newline)

(define (factorial-rec n)
  (if (= n 1)
      1
      (* n (factorial-rec (- n 1)))))

(define (factorial n)
  (define (fact-iter product counter)
    (if (< n counter)
        product
        (fact-iter (* product counter)
                   (+ counter 1))))
  (fact-iter 1 1))

(display "(factorial 6): ") (display (factorial 6)) (newline)

; 1.2.2. Tree Recursion
(display "\n1.2.2. Tree Recursion\n")

(define (fib n)
  (cond ((= 0 n) 0)
        ((= 1 n) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
(display "(fib 0): ") (display (fib 0)) (newline)
(display "(fib 1): ") (display (fib 1)) (newline)
(display "(fib 2): ") (display (fib 2)) (newline)
(display "(fib 3): ") (display (fib 3)) (newline)
(display "(fib 4): ") (display (fib 4)) (newline)
(display "(fib 5): ") (display (fib 5)) (newline)
(display "(fib 6): ") (display (fib 6)) (newline)
(display "(fib 7): ") (display (fib 7)) (newline)
(display "(fib 8): ") (display (fib 8)) (newline)

(define (fib-iter n)
  (define (fib-iter-helper a b count)
    (cond ((= 0 count) b)
          (else (fib-iter-helper (+ a b)
                                 a
                                 (- count 1)))))
  (fib-iter-helper 1 0 n))

(display "(fib-iter 0): ") (display (fib-iter 0)) (newline)
(display "(fib-iter 1): ") (display (fib-iter 1)) (newline)
(display "(fib-iter 2): ") (display (fib-iter 2)) (newline)
(display "(fib-iter 3): ") (display (fib-iter 3)) (newline)
(display "(fib-iter 4): ") (display (fib-iter 4)) (newline)
(display "(fib-iter 5): ") (display (fib-iter 5)) (newline)
(display "(fib-iter 6): ") (display (fib-iter 6)) (newline)
(display "(fib-iter 7): ") (display (fib-iter 7)) (newline)
(display "(fib-iter 8): ") (display (fib-iter 8)) (newline)
