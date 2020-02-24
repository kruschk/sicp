;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.33
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.33\n")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
              '()
              sequence))
(display (map (lambda (x) (+ x 1)) (list 0 1 2 3 4))) (newline)

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(display (append (list 0 1 2 3 4) (list 5 6 7 8 9))) (newline)

(define (length sequence)
  (accumulate (lambda (x y) (+ y 1))
              0
              sequence))
(display (length (list 0 1 2 3 4))) (newline)
(display (length (append (list 0 1 2 3 4) (list 5 6 7 8 9)))) (newline)
