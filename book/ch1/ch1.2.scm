;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.2 Procedures and the Processes They Generate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "1.2 Procedures and the Processes They Generate\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.2.1 Linear Recursion and Iteration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.2.2 Tree Recursion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.2.2 Tree Recursion\n")

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

; Example: Counting change
(display "Example: Counting change\n")
(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1)  1)
        ((= kinds-of-coins 2)  5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
(display (count-change 10)) (newline)

(define (count-change amount)
  (define (cc amount kinds-of-coins)
    (define (first-denomination)
      (cond ((= kinds-of-coins 1)  1)
            ((= kinds-of-coins 2)  5)
            ((= kinds-of-coins 3) 10)
            ((= kinds-of-coins 4) 25)
            ((= kinds-of-coins 5) 50)))
    ;(display amount) (display " ")
    ;(display kinds-of-coins) (newline)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
          (else ;(display amount) (display " ")
            ;(display kinds-of-coins) (newline)
            (+ (cc amount
                   (- kinds-of-coins 1))
               (cc (- amount (first-denomination))
                   kinds-of-coins)))))
  (cc amount 5))
(display (count-change 10)) (newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.2.3 Orders of Growth
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.2.3 Orders of Growth\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.2.4 Exponentiation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.2.4 Exponentiation\n")
; Recursive expt process
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))
(display (expt 2 10)) (newline)

; Iterative expt process
(define (expt b n)
  (expt-iter b n 1))
(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                 (- counter 1)
                 (* b product))))
(display (expt 2 10)) (newline)

; Iterative expt process with block structure and lexical scoping.
(define (expt b n)
  (define (expt-iter counter product)
    (if (= counter 0)
        product
        (expt-iter (- counter 1)
                   (* b product))))
  (expt-iter n 1))
(display (expt 2 10)) (newline)

; Recursive fast-expt, which uses successive squaring.
(define (fast-expt b n)
  (define (even?)
    (= (remainder n 2) 0))
  (cond ((= n 0) 1)
        ((even?) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
(display (fast-expt 2 10)) (newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.2.5 Greatest Common Divisors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.2.5 Greatest Common Divisors\n")
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(display (gcd 16 28)) (newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.2.6 Example: Testing for Primality
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.2.6 Example: Testing for Primality\n")
; Searching for divisors
(display "Searching for divisors\n")
; Simple prime testing (my version):
(define (smallest-divisor n)
  (define (divisible-by? a) (= 0 (remainder n a)))
  (define (helper a)
    (cond ((> (square a) n) n)
          ((divisible-by? a) a)
          (else (helper (+ a 1)))))
  (helper 2))
(define (prime? n)
  (= n (smallest-divisor n)))
(display (smallest-divisor   6)) (newline)
(display (smallest-divisor   7)) (newline)
(display (smallest-divisor 169)) (newline)
(display (prime?   6)) (newline)
(display (prime?   7)) (newline)
(display (prime? 169)) (newline)

; Simple prime testing (book version):
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))
(display (smallest-divisor   6)) (newline)
(display (smallest-divisor   7)) (newline)
(display (smallest-divisor 169)) (newline)
(display (prime?   6)) (newline)
(display (prime?   7)) (newline)
(display (prime? 169)) (newline)

; The Fermat test
(display "The Fermat test\n")
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base
                                                (/ exp 2)
                                                m))
                                m))
        (else (remainder (* base (expmod base (- exp 1) m))
                         m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(display (fast-prime? 920419823 32)) (newline)
