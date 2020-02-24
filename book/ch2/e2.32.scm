;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.32
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.32\n")

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s)
                                            x))
                          rest)))))
(display (subsets (list 1 2 3))) (newline)

; The procedure traverses the entire list until it reaches the end,
; appending the subsets of the rest of the list to the lists constructed
; from the current element and the subsets of the rest of the list. The
; appending action effectively goes from the end of the list to the front,
; proceeding as follows:

; The empty list:
; (subsets '())
; `-> (if (null? s)
;       (list '())
;       (let ((rest (subsets (cdr s))))
;         (append rest (map (lambda (x) (cons (car s)
;                                             x))
;                           rest)))))
; `-> (())

; The list with only one element:
; (subsets (list 3))
; `-> (if (null? s)
;       (list '())
;       (let ((rest (subsets (cdr s))))
;         (append rest (map (lambda (x) (cons (car s)
;                                             x))
;                           rest)))))
; `-> (append (subsets (cdr (list 3)))
;             (map (lambda (x) (cons (car (list 3))
;                                    x))
;                  rest))
; `-> (append (subsets '())
;             (cons 3 '()))
; `-> (append '() (list 3))
; `-> (list '() (list 3))

; The list with two elements:
; (subsets (list 2 3))
; `-> (if (null? s)
;       (list '())
;       (let ((rest (subsets (cdr s))))
;         (append rest (map (lambda (x) (cons (car s)
;                                             x))
;                           rest)))))
; `-> (append (subsets (cdr (list 2 3)))
;             (map (lambda (x) (cons (car (list 2 3))
;                                    x))
;                  (subsets (cdr (list 2 3)))))
; `-> (append (subsets (list 3))
;             (map (lambda (x) (cons (car (list 2 3))
;                                    x))
;                  (subsets (list 3))))
; `-> (append (list '() (list 3))
;             (map (lambda (x) (cons (car (list 2 3))
;                                    x))
;                  (list '() (list 3))))
; `-> (append (list '() (list 3))
;             (list (cons 2 '()) (cons 2 (list 3))))
; `-> (append (list '() (list 3) (list 2) (list 2 3)))

; The list with three elements is not shown, but it follows the same
; pattern.
