;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.18
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.18\n")

; First attempt at implementing `reverse`:
(define (reverse items)
  (define (helper items nth)
    (if (< nth 0)
        '()
        (cons (list-ref items nth) (helper items (- nth 1)))))
  (helper items (- (length items) 1)))
; It works!
(display (reverse (list 1 4 9 16 25))) (newline)
(display (reverse (list 9 16))) (newline)
(display (reverse (list 9))) (newline)
(display (reverse '())) (newline)

; A more idiomatic implementation of `reverse`:
(define (reverse items)
  (define (helper input output)
    (if (null? input)
        output
        (helper (cdr input) (cons (car input) output))))
  (helper items '()))
; It works!
(display (reverse (list 1 4 9 16 25))) (newline)
(display (reverse (list 9 16))) (newline)
(display (reverse (list 9))) (newline)
(display (reverse '())) (newline)
