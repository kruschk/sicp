;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.25
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.25\n")

(let ((lst1 (list 1 3 (list 5 7) 9))
      (lst2 (list (list 7)))
      (lst3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))
  (display lst1) (newline)
  (display (car (cdr (car (cdr (cdr lst1)))))) (newline)
  (display (car (cdaddr lst1))) (newline)
  (display lst2) (newline)
  (display (car (car lst2))) (newline)
  (display (caar lst2)) (newline)
  (display lst3) (newline)
  (display (car (cdr
                  (car (cdr
                         (car (cdr
                                (car (cdr
                                       (car (cdr
                                              (car (cdr lst3)))))))))))))
  (newline)
  (display (cadadr (cadadr (cadadr lst3)))) (newline))
