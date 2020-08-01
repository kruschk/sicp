;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 5.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 5.2\n")

;(controller
;  test-b
;  (test (op =) (reg b) (const 0))
;  (branch (label gcd-done))
;  (assign t (op rem) (reg a) (reg b))
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label test-b))
;  gcd-done)

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

(controller
  (assign product (const 1))
  (assign counter (const 1))
  test-count
  (test (op >) (reg counter) (reg n))
  (branch (label fact-done))
  (assign product (op *) (reg counter) (reg product))
  (assign counter (op +) (reg counter) (const 1))
  (goto (label test-count))
  fact-done) ; result is in `product` register
