;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercies 1.33
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.33\n")
; A recursive filtered accumulator.
(define (filtered-accumulate-rec filter combiner null-value term a next b)
  (cond ((> a b) null-value)
        ((filter a) (combiner (term a)
                              (filtered-accumulate-rec filter
                                                       combiner
                                                       null-value
                                                       term
                                                       (next a)
                                                       next
                                                       b)))
        (else (filtered-accumulate-rec filter
                                       combiner
                                       null-value
                                       term
                                       (next a)
                                       next
                                       b))))

; a.
; Define a procedure for testing primality.
(define (prime? n)
  (define (smallest-divisor n)
    (define (divisible-by? a) (= 0 (remainder n a)))
    (define (helper a)
      (cond ((> (square a) n) n)
            ((divisible-by? a) a)
            (else (helper (+ a 1)))))
    (helper 2))
  (if (< n 2)
      #f
      (= n (smallest-divisor n))))

(define (sum-squares-primes a b)
  (filtered-accumulate-rec (lambda (x) (prime? x))
                           +
                           0
                           (lambda (x) (square x))
                           a
                           (lambda (x) (+ x 1))
                           b))
(display (sum-squares-primes 0 10)) (newline)

; b.
; Greatest common divisor.
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; Take the product of all integers in the range [1, n] that are relatively
; prime to n.
(define (product-relative-primes n)
  (filtered-accumulate-rec (lambda (x) (= 1 (gcd x n)))
                           *
                           1
                           (lambda (x) x)
                           1
                           (lambda (x) (+ x 1))
                           n))
(display (product-relative-primes 10)) (newline)
