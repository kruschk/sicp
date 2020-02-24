;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "e2.2.scm")
(display "Exercise 2.3\n")
; Implement a representation for rectangles. These are the interface
; procedures.
; Constructor
(define (make-rectangle p1 p2)
  (cons p1 p2))
; Selector
(define (p1-rectangle rectangle)
  (car rectangle))
; Selector
(define (p2-rectangle rectangle)
  (cdr rectangle))
; Compute the perimeter of a rectangle.
(define (perimeter-rectangle rectangle)
  (let* ((p1 (p1-rectangle rectangle))
         (x1 (x-point p1))
         (y1 (y-point p1))
         (p2 (p2-rectangle rectangle))
         (x2 (x-point p2))
         (y2 (y-point p2)))
    (+ (abs (* 2 (- x2 x1)))
       (abs (* 2 (- y2 y1))))))
; Compute the area of a rectangle.
(define (area-rectangle rectangle)
  (let* ((p1 (p1-rectangle rectangle))
         (x1 (x-point p1))
         (y1 (y-point p1))
         (p2 (p2-rectangle rectangle))
         (x2 (x-point p2))
         (y2 (y-point p2)))
    (abs (* (- x2 x1)
            (- y2 y1)))))
; Test the implementation.
(let* ((p1 (make-point 0 5))
       (p2 (make-point 2 2))
       (rect (make-rectangle p1 p2)))
  (print-point p1)
  (print-point p2)
  (display (perimeter-rectangle rect)) (newline)
  (display (area-rectangle rect)) (newline))
; It seems to work!

; As a second implementation, we could also use a segment to represent a
; rectangle.
; Constructor
(define (make-rectangle segment)
  segment)
; Selector
(define (p1-rectangle rectangle)
  (start-segment rectangle))
; Selector
(define (p2-rectangle rectangle)
  (end-segment rectangle))
; Test the implementation.
(let* ((p1 (make-point 0 5))
       (p2 (make-point 2 2))
       (seg (make-segment p1 p2))
       (rect (make-rectangle seg)))
  (print-point p1)
  (print-point p2)
  (display (perimeter-rectangle rect)) (newline)
  (display (area-rectangle rect)) (newline))
; The output is the same! The `perimeter-rectangle` and `area-rectangle`
; procedures still work without any modifications, despite having changed
; the implementation details of a rectangle. This is because we defined
; these two procedures in terms of the rectangle's interface procedures,
; which resulted in a suitable level of abstraction.
