;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.59
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.59\n")

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (define (helper result set)
    (if (null? set)
        result
        (if (element-of-set? (car set) result)
            (helper result (cdr set))
            (helper (cons (car set) result) (cdr set)))))
  (helper '() (append set1 set2)))

(let ((s1 (list 1 2 3 4))
      (s2 (list 4 5 6 7)))
  (display (element-of-set? 4 s1)) (newline)
  (display (adjoin-set 3 s2)) (newline)
  (display (intersection-set s1 s2)) (newline)
  (display (union-set s1 s2)) (newline))
