; Exercise 1.14
(display "Exercise 1.14\n")

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

(display (count-change 11)) (newline)
(display (cc 11 5)) (newline)
(display (+ (cc 11 4)
            (cc -39 5))) (newline)
(display (+ (+ (cc 11 3) 0) 0)) (newline)
(display (+ (+ (+ (cc 11 2) (cc  1 3)) 0) 0)) (newline)
(display (+ (+ (+ (+ (cc 11 1)
                     (cc 6 2))
                  (+ (cc 1 2)
                     (cc -11 3)))
               0)
            0)) (newline)
; "And so on...

; The orders of growth are as follows (I think):
; - Space: linear, i.e. Theta(n). This process is similar to Fib(n) where you
;   only need to keep track of the node above you.
; - Time: exponential, i.e. Theta(k^n)). The number of leaves in the tree (or
;   how many times we encounter a base/degenerate case) is exponentially
;   related to the amount of change we want to apply count-change to.
