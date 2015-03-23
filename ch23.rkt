;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ch23) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)

; 23.1.5

(define-struct employee (name salary))
(define john (make-employee "John" 50000))
(define mike (make-employee "Mike" 65000))
(define keyla (make-employee "Keyla" 52500))
(define emp-list (list john
                       mike
                       keyla))

(define (salaries l)
  (cond [(empty? l) null]
        [else (append (list (employee-name (first l))) (salaries (rest l)))]))

(define (stutter l)
  (cond [(empty? l) null]
        [else (append (list (first l)) (list (first l)) (stutter (rest l)))]))

(define l1 (list 1 2 3 4 5 6 7))
(define l2 (list "bob" "ad" "foo"))
(stutter l1)
(stutter l2)

(define (substitute s1 s2 l)
  (cond [(empty? l) null]
        [(string=? (list-ref l 0) s1) (cons s2 (substitute s1 s2 (rest l)))]
        [else (list (first l))]))

(substitute "bob" "ad" l2)

(define (remove-all s1 l)
  (cond [(empty? l) null]
        [(equal? (first l) s1) (remove-all s1 (rest l))]
        [else (remove-all s1 (append (list (first l)) (rest l)))]))

(define l3 (list 1 2 3 4 5 1 6 7 1 1 2 3 1))

(remove-all 1 l3)

(define s "this.")

(string->list s)
(string->list "abcd")

(define (replace-it-real char repl strlist)
  (cond [(empty? strlist) strlist]
        [(equal? char (first strlist)) (append (list-in strlist))

(define (list-in strlist)
  (list (first strlist)))

(define (replace-it char replacement in-string)
  (replace-it-real char
                   (string->list replacement)
                   (string->list in-string)))

; 2/20: TODAY 25.5.{3-5}
; NEXT 25.5.{6-7}


