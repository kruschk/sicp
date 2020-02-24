;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2\n")

; Utility procedures.
(define (make-point x y)
  (lambda (bit)
    (if (zero? bit) x y)))

(define (x-of point)
  (point 0))

(define (y-of point)
  (point 1))

; 1.
(display "1.\n")
; unit-line-at: Sch-Num -> Curve
; where
;     Curve = Unit-Interval -> Point
; so
; unit-line-at: Sch-Num -> (Unit-Interval -> Point)

; 2.
(display "2.\n")
(define (vertical-line point len)
  (lambda (t)
    (make-point (x-of point)
                (+ (* t len) (y-of point)))))
; Test it out...
(display (y-of (make-point 0 1))) (newline)
(display (y-of ((vertical-line (make-point 1 2) 2.3) 0.5))) (newline)
; It seems to be working!

; 3.
(display "3.\n")
; vertical-line: (Point, Sch-Num) -> Curve
