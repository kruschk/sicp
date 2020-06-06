;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.63 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.63\n")

(define (sqrt-improve guess x)
  (define (average x y)
    (/ (+ x y) 2))
  (average guess (/ x guess)))

; Louis Reasoner's implementation:
(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))
(display (stream-ref (sqrt-stream 2) 0)) (newline)
(display (stream-ref (sqrt-stream 2) 1)) (newline)
(display (stream-ref (sqrt-stream 2) 2)) (newline)
(display (stream-ref (sqrt-stream 2) 3)) (newline)
(display (stream-ref (sqrt-stream 2) 4)) (newline)
(display (stream-ref (sqrt-stream 2) 5)) (newline)

; Alyssa P. Hacker's implementation:
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)
(display (stream-ref (sqrt-stream 2) 0)) (newline)
(display (stream-ref (sqrt-stream 2) 1)) (newline)
(display (stream-ref (sqrt-stream 2) 2)) (newline)
(display (stream-ref (sqrt-stream 2) 3)) (newline)
(display (stream-ref (sqrt-stream 2) 4)) (newline)
(display (stream-ref (sqrt-stream 2) 5)) (newline)

; This cannot be done with `let` because the definition of `guesses` is
; self-referential. Note: Guile has a `stream-let` which I believe should
; allow this type of construction.
;(define (sqrt-stream x)
;  (let ((guesses (cons-stream 1.0
;                              (stream-map (lambda (guess)
;                                            (sqrt-improve guess x))
;                                          guesses))))
;    guesses))

; I believe the latter implementation is able to take advantage of
; memoization; therefore, previously computed results don't need to be
; recalculated. The former definition does not benefit from this
; optimisation because it calls `sqrt-stream` each time, resulting in
; a new procedure being created from scratch which does not contain the 
; memoized results.
