;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.69
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.69\n")

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
; Representation of a leaf of a Huffman tree.
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
; Selectors of a leaf.
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))
; Representation of a Huffman tree.
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))
; Selectors of a Huffman tree.
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))
(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)   ; symbol
                               (cadr pair)) ; frequency
                    (make-leaf-set (cdr pairs))))))
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((element-of-set? symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((element-of-set? symbol (symbols (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else (error "symbol not found in tree -- ENCODE-SYMBOL"
                     symbol))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (cond ((null? leaf-set)
         (error "cannot merge an empty leaf set -- SUCCESSIVE-MERGE"
                leaf-set))
        ((null? (cdr leaf-set)) (car leaf-set))
        (else (successive-merge (adjoin-set (make-code-tree (car leaf-set)
                                                            (cadr leaf-set))
                                            (cddr leaf-set))))))

(let ((sample-tree
        (make-code-tree
          (make-leaf 'A 4)
          (make-code-tree
            (make-leaf 'B 2)
            (make-code-tree
              (make-leaf 'D 1)
              (make-leaf 'C 1)))))
      (sample-encoded '(0 1 1 0 0 1 0 1 0 1 1 1 0))
      (sample-decoded '(a d a b b c a))
      (pairs (list (list 'A 4)
                   (list 'B 2)
                   (list 'C 1)
                   (list 'D 1)))
      (book-example-pairs (list (list 'A 8)
                        (list 'B 3)
                        (list 'C 1)
                        (list 'D 1)
                        (list 'E 1)
                        (list 'F 1)
                        (list 'G 1)
                        (list 'H 1))))
  (display sample-tree) (newline)
  (display (decode sample-encoded sample-tree)) (newline) ; prints (a d a b b c a)
  (display (encode sample-decoded sample-tree)) (newline)
  (display (generate-huffman-tree pairs)) (newline)
  (display (generate-huffman-tree book-example-pairs)) (newline))
