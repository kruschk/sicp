;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3\n")

; Utility procedures.
(define (make-point x y)
  (lambda (bit)
    (if (zero? bit) x y)))
(define (x-of point)
  (point 0))
(define (y-of point)
  (point 1))

; `reflect-through-y-axis` procedure.
; reflect-through-y-axis: Curve-Transform
; Curve-Transform = Curve -> Curve
(define (reflect-through-y-axis curve)
  (lambda (t)
    (let ((ct (curve t)))
      (make-point (- (x-of ct))
                  (y-of ct)))))
; Define a linear curve (y = mx + b) to test the above procedure.
(define (linear m b)
  (lambda (x)
    (make-point x
                (+ (* m x) b))))
; Test `linear` to see if it's working.
(display (x-of ((linear 1 2) 3))) (newline)
(display (y-of ((linear 1 2) 3))) (newline)
; Test `reflect-through-y-axis` to see if it's working.
(display (x-of ((reflect-through-y-axis (linear 1 2)) 3))) (newline)
(display (y-of ((reflect-through-y-axis (linear 1 2)) 3))) (newline)
; Everything seems to work!
