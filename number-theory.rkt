;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname number-theory) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)
(require racket/list)

; count-up: list(strt) number(inc) number(limit) -> list
; takes an initial number and adds it by the increment until it reaches limit

(define (count-up strt inc limit)
  (cond [(empty? strt) (error "No elements found")]
        [(>= (length strt) limit) strt]
        [else (count-up (append strt (list (+ inc (last strt)))) inc limit)]))

; fib-seq: number(limit) list(empty) -> list
; creates the fibonacci sequence up to a certain limit

(define (fib-seq limit list)
  (cond [(>= (length list) limit) list]
        [else (let ([n1 0]
                    [n2 1])
                (let ([f1 n1]

