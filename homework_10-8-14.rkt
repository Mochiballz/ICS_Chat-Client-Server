;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname homework_10-8-14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

;7.7.7

(define (hours minutes)
  (/ minutes 60))

;7.7.8

(define (hours-to-days days)
  (* days 24))

;7.7.9

(define (days-minutes days)
  (* days (* 24 60)))

;7.7.10

(define (dhm d h m)
  (+ (* d (* 24 60)) (* h 60) m))

;7.7.11

(define (feet inches)
  (/ inches 12))

;7.7.12

(define (total-inches f i)
  (+ (* f 12) i))

;7.7.14

(define (at-most-10 n)
  (<= n 10))