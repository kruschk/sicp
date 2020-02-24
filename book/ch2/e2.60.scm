;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.60
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.60\n")

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (append set1 set2))

(let ((s1 (list 1 2 3 4))
      (s2 (list 4 5 6 7)))
  (display (element-of-set? 4 s1)) (newline)
  (display (adjoin-set 3 s2)) (newline)
  (display (intersection-set s1 s2)) (newline)
  (display (union-set s1 s2)) (newline))

; With this representation, the `adjoin-set` and `union-set` procedures
; become more efficient in the number of steps, but the `element-of-set?`
; and `intersection-set` procedures take a performance hit (because they
; must work with longer lists as input). At the same time, the space
; requirements of each procedure grow significantly.

; This representation may be preferable in the case where elements are
; frequently added to sets and the union operation is performed.
