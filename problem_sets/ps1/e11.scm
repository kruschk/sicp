;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 11
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 11\n")
; Definition of currying (I think this is right...):
;                     | (E E1 ... En)
; (C (E E1 ... En)) = |
;                     | ((C (E E1 ... En)))
; *Note the extra set of parentheses on the lower branch.

(define foo1
  (lambda (x)
    (* x x)))
(display "foo1: ") (display (- (foo1 3) 6)) (newline)

(define foo2
  (lambda (x y)
    (/ x y)))
(display "foo2: ") (display (foo2 9 3)) (newline)

(define foo3
  (lambda (x)
    (lambda (y)
      (/ x y))))
(display "foo3: ") (display ((foo3 9) 3)) (newline)

(define foo4
  (lambda (x)
    (x 3)))
; Takes an argument and returns it unchanged.
(define foo4-helper
  (lambda (x)
    x))
; Both of these work!
(display "foo4: ") (display (foo4 foo4-helper)) (newline)
(display "foo4: ") (display (foo4 +)) (newline)

(define foo5
  (lambda (x)
    (cond ((= x 2)
           (lambda () x))
          (else (lambda () (* x 3))))))
(display "foo5: ") (display ((foo5 1))) (newline)

; I don't understand this one. :(
(define foo6
  (lambda (x)
    (x (lambda (y) (y y)))))
(define foo6-helper
  (lambda (p) p))
(display "foo6: ") (display (((foo6 foo6-helper) foo6-helper) 3)) (newline)

; A-ha! Let's start with the innermost combination...
(foo6 foo6-helper)
(foo6 (lambda (p) p))
((lambda (p) p) (lambda (y) (y y)))
(lambda (y) (y y))

; ...then combine the result with foo6-helper as an argument...
((lambda (y) (y y)) foo6-helper)
(foo6-helper foo6-helper)
((lambda (p) p) (lambda (p) p))
(lambda (p) p)

; ...then combine that result with 3 as an argument! Neat!
((lambda (p) p) 3)
3
