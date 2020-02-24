;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.27
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.27\n")

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

(define (deep-reverse tree)
  (define (helper input output)
    (cond ((null? input) output)
          ((not (pair? input)) input)
          (else (helper (cdr input)
                        (cons (deep-reverse (car input))
                              output)))))
  (helper tree '()))

(let ((x (list (list 1 2) (list 3 4))))
  (display x) (newline)
  (display (reverse x)) (newline)
  (display (deep-reverse x)) (newline))

(let ((lst1 (list 1 3 (list 5 7) 9))
      (lst2 (list (list 7)))
      (lst3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))
  (display lst1) (newline)
  (display (reverse lst1)) (newline)
  (display (deep-reverse lst1)) (newline)
  (display lst2) (newline)
  (display (reverse lst2)) (newline)
  (display (deep-reverse lst2)) (newline)
  (display lst3) (newline)
  (display (reverse lst3)) (newline)
  (display (deep-reverse lst3)) (newline))
