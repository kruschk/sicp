;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.2 Hierarchical Data and the Closure Property
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "2.2 Hierarchical Data and the Closure Property\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.2.1 Representing Sequences
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2.2.1 Representing Sequences\n")

(display (cons 1
               (cons 2
                     (cons 3
                           (cons 4 '()))))) (newline)

(display (list 1 2 3 4)) (newline)

(let ((one-through-four (list 1 2 3 4)))
  (display (car one-through-four)) (newline)
  (display (cdr one-through-four)) (newline)
  (display (car (cdr one-through-four))) (newline)
  (display (cons 10 one-through-four)) (newline)
  (display (cons  5 one-through-four)) (newline))

; List operations
(display "\nList operations\n")
(define (list-ref items n)
  (if (= 0 n)
      (car items)
      (list-ref (cdr items) (- n 1))))

(let ((squares (list 1 4 9 16 25)))
  (display (list-ref squares 3)) (newline))

; The list `length` procedure (my implementation).
(define (length items)
  (define (helper items len)
    (if (null? items)
        len
        (helper (cdr items) (+ len 1))))
  (helper items 0))

; The list `length` procedure (book's implementation).
;(define (length items)
;  (if (null? items)
;      0
;      (+ 1 (length (cdr items)))))

; The list `length`, as an iterative procedure (book's implementation).
(define (length items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))

(let ((odds (list 1 3 5 7)))
  (display (length odds)) (newline))

(let ((odds (list 1 3 5 7))
      (squares (list 1 4 9 16 25)))
  (display (append squares odds)) (newline)
  (display (append odds squares)) (newline))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

; Mapping over lists
(display "\nMapping over lists\n")

; The `scale-list` procedure (my implementation).
(define (scale-list factor items)
  (if (null? items)
      '()
      (cons (* factor (car items))
            (scale-list factor (cdr items)))))
(display (scale-list 10 (list 1 2 3 4 5))) (newline)

; The `scale-list` procedure (book's implementation).
(define (scale-list items factor)
  (if (null? items)
      '()
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))
(display (scale-list (list 1 2 3 4 5) 10)) (newline)

; The `map` procedure.
(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))
(display (map abs (list -10 2.5 -11.6 17))) (newline)
(display (map (lambda (x) (* x x))
              (list 1 2 3 4))) (newline)

(define (scale-list items factor)
  (map (lambda (x) (* x factor))
       items))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.2.2 Hierarchical Structures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2.2.2 Hierarchical Structures\n")

(display (cons (list 1 2) (list 3 4))) (newline)

; The `count-leaves` procedure (my implementation)
(define (count-leaves tree)
  (if (null? tree)
      0
      (if (pair? tree)
          (+ (count-leaves (car tree))
             (count-leaves (cdr tree)))
          1)))
; It works!
(let ((x (cons (list 1 2) (list 3 4))))
  (display (length x)) (newline)
  (display (count-leaves x)) (newline)
  (display (list x x)) (newline)
  (display (length (list x x))) (newline)
  (display (count-leaves (list x x))) (newline))

; The `count-leaves` procedure (book's implementation)
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
; It works!
(let ((x (cons (list 1 2) (list 3 4))))
  (display (length x)) (newline)
  (display (count-leaves x)) (newline)
  (display (list x x)) (newline)
  (display (length (list x x))) (newline)
  (display (count-leaves (list x x))) (newline))

; Mapping over trees
(display "\nMapping over trees\n")

(define (scale-tree tree factor)
  (cond ((null? tree) '())
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))
(display (scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))
                     10)) (newline)

(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree sub-tree factor)
             (* sub-tree factor)))
       tree))
(display (scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))
                     10)) (newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.2.3 Sequences as Conventional Interfaces
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2.2.3 Sequences as Conventional Interfaces\n")

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))
(display (sum-odd-squares (list 1 2 (list 3 (list 4 5) 6) 7))) (newline)

(define (fib n)
  (define (fib-helper a b count)
    (cond ((= 0 count) b)
          (else (fib-helper (+ a b)
                            a
                            (- count 1)))))
  (fib-helper 1 0 n))

(define (even-fibs n)
  (define (next k)
    (if (> k n)
        '()
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))
(display (even-fibs 14)) (newline)

; Sequence Operations
(display "\nSequence Operations\n")

(display (map square (list 1 2 3 4 5))) (newline)

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
(display (filter odd? (list 1 2 3 4 5))) (newline)

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
(display (accumulate + 0 (list 1 2 3 4 5))) (newline)
(display (accumulate * 1 (list 1 2 3 4 5))) (newline)
(display (accumulate cons '() (list 1 2 3 4 5))) (newline)

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low
            (enumerate-interval (+ low 1)
                                high))))
(display (enumerate-interval 2 7)) (newline)

(define (enumerate-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
(display (enumerate-tree (list 1 (list 2 (list 3 4) 5)))) (newline)

(define (sum-odd-squares tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))
(display (sum-odd-squares (list 1 2 (list 3 (list 4 5) 6) 7))) (newline)

(define (even-fibs n)
  (accumulate cons
              '()
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))
(display (even-fibs 14)) (newline)

(define (list-fib-squares n)
  (accumulate cons
              '()
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))
(display (list-fib-squares 10)) (newline)

(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))
(display (product-of-squares-of-odd-elements (list 1 2 3 4 5))) (newline)

(define (salary-of-highest-paid-programmer records)
  (accumulate max
              0
              (map salary
                   (filter programmer?
                           records))))

; Nested Mappings
(display "\nNested Mappings\n")

;(accumulate append
;            '()
;            (map (lambda (i)
;                   (map (lambda (j) (list i j))
;                        (enumerate-interval 1 (- i 1))))
;                 (enumerate-interval 1 n)))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))
(define (prime? n)
  (define (smallest-divisor n)
    (define (find-divisor n test-divisor)
      (define (divides? a b)
        (= (remainder b a) 0))
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
    (find-divisor n 2))
  (= n (smallest-divisor n)))
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap (lambda (i)
                          (map (lambda (j) (list i j))
                               (enumerate-interval 1 (- i 1))))
                        (enumerate-interval 1 n)))))
(display (prime-sum-pairs 6)) (newline)

(define (permutations s)
  (if (null? s)  ; empty set?
      (list '()) ; sequence containing empty set
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))
(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))
(display (permutations (list 1 2 3 4 5)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.2.4 Example: A Picture Language
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2.2.4 Example: A Picture Language\n")

; The picture language
(display "\nThe picture language\n")

;(define wave2 (beside wave (flip-vert wave)))
;(define wave4 (below wave2 wave2))

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

;(define wave4 (flipped-pairs wave))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))
;(right-split wave 4)
;(right-split rogers 4)
;(corner-split wave 4)
;(corner-split rogers 4)

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

; Higher-order operations
(display "\nHigher-order operations\n")

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (flipped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert
                                  identity flip-vert)))
    (combine4 painter)))
;; Alternately:
;(define flipped-pairs
;  (square-of-four identity flip-vert identity flip-vert))

(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))

; Frames
(display "\nFrames\n")

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcor-vect v)
                            (edge1-frame frame))
                (scale-vect (ycor-vect v)
                            (edge2-frame frame))))))
;((frame-coord-map a-frame) (make-vect 0 0))
;(origin-frame a-frame)

; Painters
(display "\nPainters\n")

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (draw-line ((frame-coord-map frame) (start-segment segment))
                           ((frame-coord-map frame) (end-segment segment))))
              segment-list)))

; Transforming and combining painters
(display "\nTransforming and combining painters\n")

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
          (make-frame new-origin
                      (sub-vect (m corner1) new-origin)
                      (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)   ; new origin
                     (make-vect 1.0 1.0)   ; new end of edge1
                     (make-vect 0.0 0.0))) ; new end of edge2

(define (shrink-to-upper-right painter)
  (transform-painter painter
                     (make-vect 0.5 0.5)
                     (make-vect 1.0 0.5)
                     (make-vect 0.5 1.0)))

(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (squash-inwards painter)
  (transform-painter painter
                     (make-vect 0.00 0.00)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left (transform-painter painter1
                                         (make-vect 0.0 0.0)
                                         split-point
                                         (make-vect 0.0 1.0)))
          (paint-right (transform-painter painter2
                                          split-point
                                          (make-vect 1.0 0.0)
                                          (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

; Levels of language for robust design
(display "\nLevels of language for robust design\n")
