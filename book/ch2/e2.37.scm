;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.37
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.37\n")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op
                        init
                        (map (lambda (x) (car x)) seqs))
            (accumulate-n op
                          init
                          (map (lambda (x) (cdr x)) seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product v x)) m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (map (lambda (y) (dot-product x y)) cols)) m)))

(let ((v (list 1 2 3 4))
      (w (list 5 6 7 8))
      (m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9))))
  (display v) (newline)
  (display w) (newline)
  (display m) (newline)
  (display (dot-product v w)) (newline)
  (display (matrix-*-vector m v)) (newline)
  (display (transpose m)) (newline)
  (display (matrix-*-matrix m (transpose m))) (newline))
