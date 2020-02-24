;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.53
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.53\n")

(display (list 'a 'b 'c)) (newline) ; (a b c)
(display (list (list 'george))) (newline) ; ((george))
(display (cdr '((x1 x2) (y1 y2)))) (newline) ; ((y1 y2))

(display (cadr '((x1 x2) (y1 y2)))) (newline) ; (y1 y2)
(display (pair? (car '(a short list)))) (newline) ; #f
(display (memq 'red '((red shoes) (blue socks)))) (newline) ; #f

(display (memq 'red
               '(red shoes blue socks))) (newline) ; (red shoes blue socks)
