;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.7\n")
(define (make-interval a b) (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
(define (mul-interval x y)
  (let ((t1 (* (lower-bound x) (lower-bound y)))
        (t2 (* (lower-bound x) (upper-bound y)))
        (t3 (* (upper-bound x) (lower-bound y)))
        (t4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min t1 t2 t3 t4)
                   (max t1 t2 t3 t4))))
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))
(let ((inter1 (make-interval 1 2))
      (inter2 (make-interval 3 4)))
  (display inter1) (newline)
  (display inter2) (newline)
  (display (add-interval inter1 inter2)) (newline)
  (display (mul-interval inter1 inter2)) (newline)
  (display (div-interval inter1 inter2)) (newline))
