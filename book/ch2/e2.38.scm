;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.38
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.38\n")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(let ((lst (list 1 2 3)))
  (display (fold-right / 1 lst)) (newline) ; (1/(2/(3/1))) = (1/(2/3)) = 3/2
  (display (fold-left  / 1 lst)) (newline) ; ((((1)/1)/2)/3) = 1/6
  (display (fold-right list '() lst)) (newline)  ; (1 (2 (3 ())))
  (display (fold-left  list '() lst)) (newline)) ; (((() 1) 2) 3)

; I believe the both the commutative property (a + b = b + a) and the
; associative property ((a + b) + c = a + (b + c)) must be satisfied for
; fold-right and fold-left to produce the same values for any sequence.
