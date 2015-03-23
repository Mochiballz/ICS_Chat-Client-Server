;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ch23-quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)

(define (go-fishing string)
  (cond
    [(equal? "" string) ""]
    [(equal? "t" (list->string (list (first (string->list string))))) 
         (string-append "trout" 
                 (go-fishing (list->string (rest (string->list string)))))]
        [(equal? "w" (list->string (list (first (string->list string))))) 
         (string-append "walleye" 
                 (go-fishing (list->string (rest (string->list string)))))]
        [else (string-append (list->string (list (first (string->list string))))
                             (go-fishing (list->string (rest (string->list string)))))]))
                 