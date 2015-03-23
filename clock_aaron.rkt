;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname clock_aaron) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

;converts time to degrees

(define (minute-degrees m s)
  (+ (* 6 m) (* .1 s)))

(define (hour-degrees h m s)
  (+ (* h 30) (* m 1/2) (* s 1/120)))

(define (second-degrees s)
  (* 6 s))

;converts degrees to clock hands

(define (minute-hand m s)
  (rotate (minute-degrees m s) (above (triangle 3 "solid" "black")
                                      (rectangle 3 120 "solid" "black")
                                      (rectangle 3 120 "solid" (make-color 255 255 255 0)))))

(define (hour-hand h m s)
  (rotate (hour-degrees h m s) (above (triangle 3 "solid" "blue")
                                      (rectangle 3 60 "solid" "blue")
                                      (rectangle 3 60 "solid" (make-color 255 255 255 0)))))

(define (second-hand s)
  (rotate (second-degrees s) (above (triangle 3 "solid" (make-color 255 0 0 126))
                                              (rectangle 3 110 "solid" (make-color 255 0 0 126))
                                              (rectangle 3 110 "solid" (make-color 255 0 0 0)))))
;takes hand and makes clock

(define (clock h m s)
  (overlay/align "middle" "middle"
                 (circle 5 "solid" "black")
                 (hour-hand h m s)
                 (minute-hand m s)
                 (second-hand s)
                 (circle 160 "outline" "black")))

;converts seconds to larger times

(define (seconds-minutes s)
  (/ 60 s))

(define (seconds-hours s)
  (/ 3600 s))

;turns time into only seconds

(define (clock-second-convert h m s)
  (+ (* h 3600)
     (* m 60)
     s))

;animation junk and other things

(define (clock-handler s)
  (flip-horizontal (clock (seconds-hours s) (seconds-minutes s) s)))

(define (increment s)
  (+ s 1))

(big-bang (clock-second-convert 3 37 30)
          (to-draw clock-handler)
          (on-tick increment 1))
