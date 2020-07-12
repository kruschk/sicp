;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 4.19
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 4.19\n")

; I agree with Eva's view; however, it is difficult to implement because of
; potential cross-references among the defined names. It could possibly be
; implemented by wrapping the value of each `define` in a`delay`, and then
; forcing the values as needed:
;(lambda <vars>
;  (define u <e1>)
;  (define v <e2>)
;  <e3>)
; becomes:
;(lambda <vars>
;  (define u (delay <e1>))
;  (define v (delay <e2>))
;  <e3>)
; Although, maybe not...

; It might be possible to implement by somehow resolving dependencies among
; the defined variables, but this would be quite difficult in general (if
; possible). For example, the following case would generate a reference
; cycle that is impossible to resolve:
;(define (f x)
;  (define a (+ b 1))
;  (define b (+ a 1))
;  '...)
; See note 26 in the book for further discussion on the problem. What it
; says is quite reasonable.
