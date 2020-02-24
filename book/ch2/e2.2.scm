;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.2\n")
; Procedure provided for printing points.
(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))

; Make a segment from two points.
; make-segment: (Point, Point) -> Segment
(define (make-segment start end)
  (cons start end))
; start-segment: Segment -> Point
(define (start-segment segment)
  (car segment))
; end-segment: Segment -> Point
(define (end-segment segment)
  (cdr segment))

; Make a point from two numbers.
; make-point: (Sch-Num, Sch-Num) -> Point
(define (make-point x y)
  (cons x y))
; x-point: Point -> Sch-Num
(define (x-point point)
  (car point))
; x-point: Point -> Sch-Num
(define (y-point point)
  (cdr point))

; Compute the midpoint of a segment.
; midpoint-segment: Segment -> Point
(define (midpoint-segment segment)
  (let* ((start (start-segment segment))
         (start-x (x-point start))
         (start-y (y-point start))
         (end (end-segment segment))
         (end-x (x-point end))
         (end-y (y-point end)))
    (make-point (/ (+ start-x end-x) 2)
                (/ (+ start-y end-y) 2))))

; Test the Segment and Point procedures.
(let* ((p1 (make-point 0 3))
       (p2 (make-point 1 2))
       (seg (make-segment p1 p2)))
  (print-point p1)
  (print-point p2)
  (print-point (midpoint-segment seg)))
