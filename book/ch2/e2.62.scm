;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.62
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.62\n")

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((x1 (car set1)) (x2 (car set2)))
                (cond ((= x1 x2)
                       (cons x1
                             (union-set (cdr set1)
                                        (cdr set2))))
                      ((< x1 x2)
                       (cons x1
                             (union-set (cdr set1)
                                        set2)))
                      ((< x2 x1)
                       (cons x2
                             (union-set set1
                                        (cdr set2)))))))))

(let ((s1 (list 1 3 5 7 9))
      (s2 (list 0 2 4 6 8))
      (s3 (list 1 2 3 4 5))
      (s4 (list 4 5 6 7 8)))
  (display (union-set s1 s2)) (newline)
  (display (union-set s2 s1)) (newline)
  (display (union-set s3 s4)) (newline))
