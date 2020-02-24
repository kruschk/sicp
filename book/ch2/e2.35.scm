;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.35
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.35\n")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (x)
                     (if (not (pair? x))
                         1
                         (count-leaves x)))
                   t)))

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (x)
                     (if (not (pair? x))
                         1
                         (count-leaves x)))
                   t)))

(display (count-leaves (cons (list 1 2) (list 3 4)))) (newline)
(display (count-leaves (list 1
                             (list 2 (list 3 4) 5)
                             (list 6 7)))) (newline)
(display (count-leaves '())) (newline)
