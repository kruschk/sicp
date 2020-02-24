;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.63
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.63\n")

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(let ((tree1 (make-tree 7
                        (make-tree 3
                                   (make-tree 1 '() '())
                                   (make-tree 5 '() '()))
                        (make-tree 9
                                   '()
                                   (make-tree 11 '() '()))))
      (tree2 (make-tree 3
                        (make-tree 1 '() '())
                        (make-tree 7
                                   (make-tree 5 '() '())
                                   (make-tree 9
                                              '()
                                              (make-tree 11 '() '())))))
      (tree3 (make-tree 5
                        (make-tree 3
                                   (make-tree 1 '() '())
                                   '())
                        (make-tree 9
                                   (make-tree 7 '() '())
                                   (make-tree 11 '() '())))))
  (display tree1) (newline)
  (display (tree->list-1 tree1)) (newline)
  (display (tree->list-2 tree1)) (newline)
  (display tree2) (newline)
  (display (tree->list-1 tree2)) (newline)
  (display (tree->list-2 tree2)) (newline)
  (display tree3) (newline)
  (display (tree->list-1 tree3)) (newline)
  (display (tree->list-2 tree3)) (newline))

; a.
; As demonstrated by the procedure applications above, the two procedures
; appear to produce the same list for any given tree (i.e. in non-decreasing
; order).

; b.
; Since `tree->list-2` defines a helper function which captures state in the
; `result-list` argument, I suspect that this procedure evolves a more
; iterative process than `tree->list-1`, which appears to evolve a purely
; recursive process. Based on this observation, the orders of growth are
; most likely different. I would theorize that `tree->list-2` therefore
; grows more slowly in terms of number of steps.
