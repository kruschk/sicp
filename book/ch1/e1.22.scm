;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.22
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.22\n")
(define (prime? n)
  (define (smallest-divisor)
    (define (divisible-by? a) (= 0 (remainder n a)))
    (define (helper a)
      (cond ((> (square a) n) n)
            ((divisible-by? a) a)
            (else (helper (+ a 1)))))
    (helper 2))
  (= n (smallest-divisor)))
(display (prime? 123)) (newline)

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes candidate)
  (define (helper candidate count)
    (timed-prime-test candidate)
    (if (< count 3)
        (if (prime? candidate)
            (helper (+ candidate 2)
                    (+ count 1))
            (helper (+ candidate 2)
                    count))))
  (if (even? candidate)
      (helper (+ candidate 1) 0)
      (helper candidate 0)))

; Sample 1, sample 2, sample 3 -> average
(search-for-primes   1000000000) ; Test 1: 0.05, 0.03, 0.03 -> 0.0367
(search-for-primes  10000000000) ; Test 2: 0.10, 0.13, 0.13 -> 0.1200
(search-for-primes 100000000000) ; Test 3: 0.38, 0.36, 0.35 -> 0.3633
(newline)
; We expect that each order of 10 greater should take sqrt(10) ~= 3.1623 times
; as long to compute, because the number of steps our algorithm must take to
; test if n is prime grows with sqrt(n). Let's see if this holds:
; Test 2/Test 1: 0.1200/0.0367 ~= 3.2698
; Test 3/Test 2: 0.3633/0.1200 ~= 3.0275
; Both cases display roughly sqrt(n) order of growth (actually, the results are
; remarkably close to the prediction). Noise can easily be introduced by how
; busy the operating system is, i.e. how it schedules the process alongside
; other running processes and how long it takes to handle system calls (namely
; runtime and display).
