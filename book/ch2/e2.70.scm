;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.70
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.70\n")

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

(let* ((frequencies (list (list 'A 2)
                         (list 'BOOM 1)
                         (list 'GET 2)
                         (list 'JOB 2)
                         (list 'NA 16)
                         (list 'SHA 3)
                         (list 'YIP 9)
                         (list 'WAH 1)))
       (huffman-tree (generate-huffman-tree frequencies))
       (message '(GET A JOB
                  SHA NA NA NA NA NA NA NA NA
                  GET A JOB
                  SHA NA NA NA NA NA NA NA NA
                  WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
                  SHA BOOM))
       (encoded-message (encode message huffman-tree)))
  (display frequencies) (newline)
  (display huffman-tree) (newline)
  (display message) (newline)
  (display (length message)) (newline)
  (display encoded-message) (newline)
  (display (length encoded-message)) (newline))

; The length of the message is 36 symbols, while the length of the encoded
; message is 84 bits. To encode 8 symbols with a fixed-length code, 3 bits
; would be required (because 2^2 + 2^1 + 2^0 = 0 or log2(8) = 3). As a
; result, each symbol would require 3 bits, so the message would require
; 3*36 = 108 bits in total to encode. The Huffman encoding therefore saves
; more than 20 % in space compared to the fixed-width representation
; (1 - 84/108) = 22.2... %
