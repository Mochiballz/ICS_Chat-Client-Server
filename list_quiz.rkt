;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname list_quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)

(define list1 (list "dog" "cat" "mouse" "father" "son" "kiwi"))
(define list2 (list "you" "amazing" "yams"))

(define (list-string-append list)
  (cond [(empty? list) ""]
  [else (string-append (first list) (list-string-append (rest list)))]))

(check-expect (list-string-append list1) "dogcatmousefathersonkiwi")
