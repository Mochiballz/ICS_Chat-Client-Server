;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lesson_8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

;8.2.1

;blue-circle-of-radius: number(radius) -> image

(check-expect (blue-circle 4) (circle 4 "solid" "blue"))
(check-expect (blue-circle 21) (circle 21 "solid" "blue"))

(define (blue-circle n)
  ; radius -> number
  ; "blue" -> string
  (circle n "solid" "blue"))

;8.3.2

(define (fixed-circle n)
  (overlay/align "middle" "middle" (blue-circle n) (empty-scene 200 200)))
  
(big-bang 1
          (check-with number?)
          (on-draw fixed-circle)
          (on-tick add1 0.01))

;8.3.6

(define ball (circle 5 "solid" "red"))

(define (movement x)
  (place-image ball x (/ (* x x) 20) (empty-scene 500 500)))

(big-bang 1
          (check-with number?)
          (on-draw movement)
          (on-tick add1 0.01))

;8.4.4

(define red-ball (circle 15 "solid" "red"))
(define point-ab (beside (circle 20 "solid" "blue") 
                         (circle 20 "solid" "green")))

(define (ticker-model n)
  (if (= n 60)
      20
      (+ n 40)))

(define (alter-model n)
  (place-image red-ball n 20 point-ab))

(big-bang 20
          (check-with number?)
          (on-draw alter-model)
          (on-tick ticker-model 1))
          
;8.5.1

(define (random5 n)
  (+ 20 (* 40 (random 5))))

(define (placer5 n)
  (place-image red-ball n 50 (empty-scene 210 100)))

(big-bang 20
          (check-with number?)
          (on-draw placer5)
          (on-tick random5 1))

;8.5.2

(define (random-n n)
  (+ n (+ -1 (random 3))))

(define (place-x n)
  (place-image red-ball n 250 (empty-scene 500 500)))

(big-bang 250
          (check-with number?)
          (on-draw place-x)
          (on-tick random-n .01))

;8.5.3

(define small-ball (circle 2 "solid" "blue"))
(define plane (empty-scene 500 500))

(define (random-x
  (random (+ 1 (image-width plane))))

(define random-y
  (random (+ 1 (image-height plane))))

(define (overlayer img)
  (place-image small-ball random-x random-y img))

(big-bang 1
          (check-with number?)
          (on-draw overlayer)
          (on-tick overlayer .25))