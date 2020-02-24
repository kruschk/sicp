;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.41
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.41\n")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low
            (enumerate-interval (+ low 1)
                                high))))
(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))
(display (unique-pairs 3)) (newline)

(define (unique-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))
(display (unique-triples 4)) (newline)

(define (make-triple-sum lst)
  (let ((first (car lst))
        (second (cadr lst))
        (third (caddr lst)))
    (list first second third (+ first second third))))

(define (given-sum-triples n s)
  (map make-triple-sum
       (filter (lambda (x) (= (+ (car x) (cadr x) (caddr x)) s))
               (unique-triples n))))
(display (given-sum-triples 6 10)) (newline)
