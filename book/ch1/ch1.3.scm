;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.3 Formulating Abstractions with Higher-Order Procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.3 Formulating Abstractions with Higher-Order Procedures\n")
(define (cube x) (* x x x))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.3.1 Procedures as Arguments
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.3.1 Procedures as Arguments\n")
; Define a function which sums integers between a and b.
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))
(display (sum-integers 0 5)) (newline)

; Define a function which sums cubes between a and b.
(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))
(display (sum-cubes 0 10)) (newline)

; Define a sum which converges to pi/8 (for a = 1 and b -> infinity).
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0
            (* a
               (+ a 2)))
         (pi-sum (+ a 4)
                 b))))
(display (pi-sum 1 1000)) (newline)

; Generic sum procedure.
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; Use the generic procedure to sum cubes.
(define (inc n) (+ n 1))
(define (sum-cubes a b)
  (sum cube a inc b))
(display (sum-cubes 1 10)) (newline)

; Use the generic procedure to sum integers.
(define (identity x) x)
(define (sum-integers a b)
  (sum identity a inc b))
(display (sum-integers 1 10)) (newline)

; Use the generic procedure to define a pi-sum procedure.
(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))
(display (* 8 (pi-sum 1 1000))) (newline)

; Use generic sum to define an integration procedure.
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))
(display (integral cube 0 1  0.01)) (newline)
(display (integral cube 0 1 0.001)) (newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.3.2 Constructing Procedures using Lambda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.3.2 Constructing Procedures using Lambda\n")
; The `lambda` special form.
(lambda (x) (+ x 4))
(lambda (x) (/ 1.0 (* x (+ x 2))))

; Use the generic procedure to define pi-sum, but with lambda special forms.
(define (pi-sum a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))
(display (* 8 (pi-sum 1 1000))) (newline)

(define (integral f a b dx)
  (* (sum f
          (+ a (/ dx 2.0))
          (lambda (x) (+ x dx))
          b)
     dx))
(display (integral cube 0 1  0.01)) (newline)
(display (integral cube 0 1 0.001)) (newline)

; Defining a procedure can be thought of as a special case of binding a lambda
; expression to a name.
(define (plus4 x) (+ x 4))
(define plus4 (lambda (x) (+ x 4)))

; Using lambda as the operator in an expression:
(display ((lambda (x y z) (+ x y (square z))) 1
                                              2
                                              3)) (newline)

; Using `let` to create local variables:
(display "Using `let` to create local variables\n")

; Implementing f(x, y) = x*(1 + xy)^2 + y*(1-y) + (1 + xy)*(1 - y) (the
; following four procedures do the same thing, but are written in different
; ways):
; Using an auxiliary procedure to bind the local variables:
(define (f x y)
  (define (helper a b)
    (+ (* x (square a))
       (* y b)
       (* a b)))
  (helper (+ 1 (* x y))
          (- 1 y)))

; Using a lambda expression so we don't need to give a name to the helper:
(define (f x y)
  ((lambda (a b)
     (+ (* x (square a))
        (* y b)
        (* a b)))
   (+ 1 (* x y))
   (- 1 y)))

; Using let (which is just syntactic sugar for the form of lambda expression
; used above, i.e.
; ((lambda (<var1> ... <varn>)
;    <body>
;  <exp1>
;  ...
;  <expn>))
; ):
(define (f x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))

; Using `define` to define variables (Note: using `let` is preferred for this
; purpose, and `define` is typically used for internal procedures. Apparently,
; there are some subtleties which arise if define is used in this manner, but
; they won't be discussed until chapter 4.1.6.):
(define (f x y)
  (define a (+ 1 (* x y)))
  (define b (- 1 y))
  (+ (* x (square a))
     (* y b)
     (* a b)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.3.3 Procedures as General Methods
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n1.3.3 Procedures as General Methods\n")
; Finding roots of equations by the half-interval method
(display "Finding roots of equations by the half-interval method\n")
; `search` root-finding (my implementation, slightly different from book's):
(define (search f neg-point pos-point)
  (define (average x y) (/ (+ x y) 2))
  (define (close-enough? x) (< (abs x) 0.001))
  (let ((midpoint (average neg-point pos-point))
        (mid-val (f midpoint)))
    ; My method uses f(x) for the tolerance check, but the book uses delta x.
    (cond ((close-enough? mid-val) midpoint)
          ((> mid-val 0.0) (search f neg-point midpoint))
          ((< mid-val 0.0) (search f midpoint pos-point))
          (else midpoint))))
; `search` root-finding (book's implementation):
(define (search f neg-point pos-point)
  (define (average x y) (/ (+ x y) 2))
  (define (close-enough? x y)
    (< (abs (- x y)) 0.001))
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value) (search f neg-point midpoint))
                ((negative? test-value) (search f midpoint pos-point))
                (else midpoint))))))

; Define the half-interval root-finding method.
(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
            (error "Values are not of opposite sign" a b)))))
; Test it.
(display (half-interval-method sin 2.0 4.0)) (newline)
(display (half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))
                      1.0
                      2.0)) (newline)

; Finding fixed points of functions
(display "\nFinding fixed points of functions\n")
; Define a `fixed-point` procedure (my implementation):
(define (fixed-point f guess)
  (define (good-enough?)
    (< (abs (- (f guess) guess)) 0.001))
  (if (good-enough?)
      guess
      (fixed-point f (f guess))))

; Define a `fixed-point` procedure (book's implementation):
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(display (fixed-point cos 1.0)) (newline)
(display (fixed-point (lambda (y) (+ (sin y) (cos y)))
                      1.0)) (newline)

; Defining a square root function in terms of the `fixed-point` procedure (will
; not converge):
(define (sqrt x)
  (fixed-point (lambda (y) (/ x y))
               1.0))

; Defining a square root function in terms of the `fixed-point` procedure, using
; "average damping" (will converge):
(define (sqrt x)
  (define (average x y) (/ (+ x y) 2))
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))
(display (sqrt 2.0)) (newline)
(display (sqrt 3.0)) (newline)
