;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.5\n")

(define (log-b n b)
  (/ (log n) (log b)))

(define (log-b-integer n b)
  (define (helper n count)
    (if (< n b)
        count
        (helper (/ n b) (+ count 1))))
  (helper n 0))

; (log-b-integer 8 2)
; `-> (helper 8 0)
; `-> (if (< 8 2) 0 (helper (/ 8 2) (+ 0 1)))
; `-> (helper (/ 8 2) (+ 0 1))
; `-> (helper 4 1)
; `-> (if (< 4 2) 1 (helper (/ 4 2) (+ 1 1)))
; `-> (helper 2 2)
; `-> (if (< 2 2) 2 (helper (/ 2 2) (+ 2 1)))
; `-> (helper 1 3)
; `-> (if (< 1 2) 3 (helper (/ 1 2) (+ 3 1)))
; `-> 3
; (display (log-b-integer 8 2)) (newline)

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car p)
  (define (helper n)
    ;(display n) (newline)
    (if (= 0 (remainder n 3))
        (helper (/ n 3))
        (log-b-integer n 2)))
  (helper p))

(define (cdr p)
  (define (helper n)
    ;(display n) (newline)
    (if (= 0 (remainder n 2))
        (helper (/ n 2))
        (log-b-integer n 3)))
  (helper p))

; Test the pair implementation.
(let* ((x 3)
       (y 6)
       (p (cons x y)))
  (display x) (display ",")
  (display y) (newline)
  (display (car p)) (newline)
  (display (cdr p)) (newline))
; It works!
