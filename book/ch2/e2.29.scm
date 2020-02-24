;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.29
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.29\n")

; make-mobile: (Branch, Branch) -> Mobile
(define (make-mobile left right)
  (list left right))

; make-branch: (Length, Structure) -> Branch
; Length = Sch-Nonneg-Num
; Structure = Weight | Mobile
; Weight = Sch-Nonneg-Num
(define (make-branch length structure)
  (list length structure))

; a.
; left-branch: Mobile -> Branch
(define (left-branch mobile)
  (car mobile))
; left-branch: Mobile -> Branch
(define (right-branch mobile)
  (cadr mobile))
; branch-length: Branch -> Length
(define (branch-length branch)
  (car branch))
; branch-structure: Branch -> Structure
(define (branch-structure branch)
  (cadr branch))

; b.
; total-weight: Mobile -> Weight
(define (total-weight x)
  (if (not (pair? x))
      x
      (+ (total-weight (branch-structure (left-branch x)))
         (total-weight (branch-structure (right-branch x))))))

; c.
; balanced: Mobile -> Sch-Bool
(define (balanced? x)
  (if (not (pair? x))
      #t
      (and (= (* (branch-length (left-branch x))
                 (total-weight (branch-structure (left-branch x))))
              (* (branch-length (right-branch x))
                 (total-weight (branch-structure (right-branch x)))))
           (balanced? (branch-structure (left-branch x)))
           (balanced? (branch-structure (right-branch x))))))

(let* ((branch1 (make-branch 1 6))
       (branch2 (make-branch 2 3))
       (branch3 (make-branch 4 5))
       (mobile1 (make-mobile branch1 branch2))
       (mobile2 (make-mobile branch3 (make-branch 7 mobile1))))
  (display mobile1) (newline)
  (display (left-branch mobile1)) (newline)
  (display (right-branch mobile1)) (newline)
  (display (branch-length branch1)) (newline)
  (display (branch-structure branch1)) (newline)
  (display (total-weight mobile1)) (newline)
  (display (balanced? mobile1)) (newline)
  (display mobile2) (newline)
  (display (left-branch mobile2)) (newline)
  (display (right-branch mobile2)) (newline)
  (display (total-weight mobile2)) (newline)
  (display (balanced? mobile2)) (newline))

; d.
; Only the selector procedures need to change, given the modified
; constructor procedures, since the procedures that operate on the mobile
; data structure all use the same interface procedures defined below
; (uncomment to test). In other words, we have built an abstraction barrier
; that makes maintenance and modification of our programs much easier (see
; chapter 2.1.2 for more discussion on abstraction barriers)!
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cdr mobile))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cdr branch))

(display "Modified representations:\n")
(let* ((branch1 (make-branch 1 6))
       (branch2 (make-branch 2 3))
       (branch3 (make-branch 4 5))
       (mobile1 (make-mobile branch1 branch2))
       (mobile2 (make-mobile branch3 (make-branch 7 mobile1))))
  (display mobile1) (newline)
  (display (left-branch mobile1)) (newline)
  (display (right-branch mobile1)) (newline)
  (display (branch-length branch1)) (newline)
  (display (branch-structure branch1)) (newline)
  (display (total-weight mobile1)) (newline)
  (display (balanced? mobile1)) (newline)
  (display mobile2) (newline)
  (display (left-branch mobile2)) (newline)
  (display (right-branch mobile2)) (newline)
  (display (total-weight mobile2)) (newline)
  (display (balanced? mobile2)) (newline))
