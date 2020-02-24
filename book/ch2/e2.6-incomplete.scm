;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.6\n")

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(display (add-1 zero)) (newline)

; How do we define `one`? Consider:
; (add-1 zero)
; `-> (lambda (f) (lambda (x) (f ((zero f) x))))
; `-> (lambda (f) (lambda (x) (f ((lambda (g) (lambda (y) y)) f) x)))
; `-> (lambda (f) (lambda (x) (f (lambda (y) y) x)))
; `-> (lambda (f) (lambda (x) (f x)))
; We can therefore define `one` as:
(define one (lambda (f) (lambda (x) (f x))))

; Similarly, `two` can be defined as:
(define two (lambda (f) (lambda (x) (f (f x)))))
; because
; (add-1 one)
; `-> (lambda (f) (lambda (x) (f ((one f) x))))
; `-> (lambda (f) (lambda (x) (f (((lambda (g) (lambda (y) (g y))) f) x))))
; `-> (lambda (f) (lambda (x) (f ((lambda (y) (f y)) x))))
; `-> (lambda (f) (lambda (x) (f (f x))))

; I don't think this is right.
; We can define addition as follows (the same as composition!?):
; (define add (lambda (f g) (lambda (x) (f (g x)))))
; For example, consider adding `zero` and `one`:
; (add zero one)
; `-> ((lambda (f g) (lambda (x) (f (g x)))) zero one)
; `-> (lambda (x) (zero (one x)))
; `-> (lambda (x) ((lambda (f) (lambda (y) y)) (one x)))

; `-> ((lambda (f g) (lambda (x) (f (g x)))) (lambda (f) (lambda (x) x)) (lambda (f) (lambda (x) (f x))))
; `-> (lambda (x) ((lambda (f) (lambda (x) x)) ((lambda (f) (lambda (x) (f x))) x)))
; `-> (lambda (x) ((lambda (f) (lambda (x) x)) ((lambda (f) (lambda (x) (f x))) x)))

; I don't think this is right.
; (define add (lambda (f g) (lambda (x) (f ((g f) x)))))
; (add zero one)
; `-> ((lambda (f g) (lambda (x) (f ((g f) x)))) zero one)
; `-> (lambda (x) (zero ((one f) x)))
; `-> (lambda (x) (zero (((lambda (g) (lambda (y) (g y))) f) x)))
; `-> (lambda (x) (zero (lambda (y) (f y)) x))
; `-> (lambda (x) (zero (lambda (y) (f y)) x))
; `-> (lambda (x) (zero (f x)))
; `-> (lambda (x) ((lambda (g) (lambda (y) y)) (f x)))
; `-> (lambda (x) ((lambda (g) (lambda (y) y)) (f x)))

; Hmmmm...
