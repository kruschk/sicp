;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1. Procedure Types and Procedure Constructors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "1. Procedure Types and Procedure Constructors\n")
(define (compose f g)
  (lambda (x)
    (f (g x))))

(display (log 2)) (newline)
(display ((compose square log) 2)) (newline)
(display ((compose log square) 2)) (newline)

(define (thrice f)
  (compose (compose f f) f))
; or
;(define (thrice f)
;  (compose f (compose f f)))

(display ((thrice square) 3)) (newline)
(display (square (square (square 3)))) (newline)

(define (identity x) x)

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

(display ((repeated sin 5) 3.1)) (newline)
(display (sin (sin (sin (sin (sin 3.1)))))) (newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2. Curves as Procedures and Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2. Curves as Procedures and Data\n")
; (x-of (make-point n m)) = n
; (y-of (make-point n m)) = m
(define (make-point x y)
  (lambda (bit)
    (if (zero? bit) x y)))

(define (x-of point)
  (point 0))

(define (y-of point)
  (point 1))

(define (unit-circle t)
  (make-point (sin (* 2pi t))
              (cos (* 2pi t))))

(define (unit-line-at y)
  (lambda (t) (make-point t y)))

(define unit-line (unit-line-at 0))

; `rotate-pi/2` procedure (my implementation).
(define (rotate-pi/2 curve)
  (lambda (t)
    (make-point (- (y-of (curve t)))
                (x-of (curve t)))))

; `rotate-pi/2` procedure (book's implementation).
(define (rotate-pi/2 curve)
  (lambda (t)
    (let ((ct (curve t)))
      (make-point (- (y-of ct))
                  (x-of ct)))))


