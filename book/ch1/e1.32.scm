;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercies 1.32
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.32\n")

; Define two utility functions that will help with testing.
(define (identity x) x)
(define (inc x) (+ x 1))

; a.
; A recursive accumulator.
(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-rec combiner
                                null-value
                                term
                                (next a)
                                next
                                b))))

; Define sum in terms of accumulate-rec.
(define (sum-rec term a next b)
  (accumulate-rec + 0 term a next b))
(display (sum-rec identity 0 inc 10)) (newline)

; Define product in terms of accumulate-rec.
(define (product-rec term a next b)
  (accumulate-rec * 1 term a next b))
(display (product-rec identity 1 inc 10)) (newline)

; b.
; An iterative accumulator.
(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (combiner (term a)
                        result))))
  (iter a null-value))

; Define sum in terms of accumulate-iter.
(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))
(display (sum-iter identity 0 inc 10)) (newline)

; Define product in terms of accumulate-iter.
(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))
(display (product-iter identity 1 inc 10)) (newline)
