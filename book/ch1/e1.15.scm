;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.15\n")
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

(display (sine 12.15)) (newline)
(sine 12.15)
(p (sine (/ 12.15 3.0)))
(p (sine 4.05))
(p (p (sine (/ 4.05 3.0))))
(p (p (sine 1.35)))
(p (p (p (sine (/ 1.35 3.0)))))
(p (p (p (sine 0.45))))
(p (p (p (p (sine (/ 0.45 3.0))))))
(p (p (p (p (sine 0.15)))))
(p (p (p (p (p (sine (/ 0.15 3.0)))))))
(p (p (p (p (p (sine 0.05))))))
(p (p (p (p (p 0.05)))))
(p (p (p (p (- (* 3 0.05) (* 4 (cube 0.05)))))))
(p (p (p (p (- 0.15 0.0005)))))
(p (p (p (p (- 0.15 0.0005)))))
(p (p (p (p 0.1495))))
(p (p (p (p 0.1495))))
(p (p (p (- 0.4485 0.0133654495))))
; ...

; a.
; The procedure p is applied as many times as is required to make\n") the
; argument to sine less than or equal to 0.1. For `(sine 12.15)`, 5
; applications of p are required because 12.15/3 = 4.05, 4.05/3 = 1.35,
; 1.35/3 = 0.45, 0.45/3 = 0.15, and 0.15/3 = 0.05.

; b.
; Steps: We need to repeatedly divide by 3 until the argument to sine is less
;        than or equal to 0.01. Therefore:
;            a/(3^n) <= 0.01
;            a <= 0.01*(3^n)
;            3^n >= a/0.01 = 100a
;            n*logn(3) >= logn(100a)
;            n*logn(3) = n*loga(3)/loga(n) and logn(100a) = loga(100a)/loga(n)
;            n*loga(3)/loga(n) >= loga(100a)/loga(n) -> 
;            n*loga(3) = loga(100a)
;            n = loga(100a)/loga(3) = C*loga(100a)
;        So sine is Theta(log(100a)) (logarithmic).
; Space: The amount of space required is directly proportional to the number of
;        times we need to divide a, so sine is Theta(n) (linear).
