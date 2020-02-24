;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.24
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.24\n")

(display (list 1 (list 2 (list 3 4)))) (newline)
; This is the result given by the interpreter:
; (1 (2 (3 4)))
; In pair notation, the above is equivalent to (I think...):
; (1 . ((2 . ((3 . (4 . ())) . ())) . ()))
; The box-and-pointer structure is (I believe...):
; [1|.] -> [.|/]
;           |
;           v
;          [2|.] -> [.|/]
;                    |
;                    v
;                   [3|.] -> [4|/]
; The tree structure is:
; (1 (2 (3 4)))
;      / \
;     1   (2 (3 4))
;            / \
;           2   (3 4)
;                / \
;               3   4
