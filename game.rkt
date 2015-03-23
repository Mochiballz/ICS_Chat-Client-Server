;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

; game-character-values: number(x) number(y) string(color) number(size) number(time) -> posn
; takes in x and y values to determine coordinates
; also recieves color for character

(define-struct game-character-values (x y color size time))
(define aaron (make-game-character-values 30 50 "blue" 5 0))

; game-scene: struct(game-character-values) -> image
; creates scene of character at coordinates with specified color

(define game-scene-background (empty-scene 500 500))
(define (game-character struct)
  (circle (game-character-values-size struct)
          "solid" (game-character-values-color struct)))

(define (game-scene struct)
  (place-image (game-character struct)
               (game-character-values-x struct)
               (game-character-values-y struct)
               game-scene-background))

; game-key-handler: struct(game-character-values) key -> struct
; takes in initial struct and creates a new one depending on the key pressed

(define (game-key-handler struct key)
  (cond [(key=? key "w") (make-game-character-values
                          (game-character-values-x struct)
                          (+ -4 (game-character-values-y struct))
                          (game-character-values-color struct)
                          (game-character-values-size struct)
                          (game-character-values-time struct))]
        [(key=? key "a") (make-game-character-values
                          (+ -4 (game-character-values-x struct))
                          (game-character-values-y struct)
                          (game-character-values-color struct)
                          (game-character-values-size struct)
                          (game-character-values-time struct))]
        [(key=? key "s") (make-game-character-values
                          (game-character-values-x struct)
                          (+ 4 (game-character-values-y struct))
                          (game-character-values-color struct)
                          (game-character-values-size struct)
                          (game-character-values-time struct))]
        [(key=? key "d") (make-game-character-values
                          (+ 4 (game-character-values-x struct))
                          (game-character-values-y struct)
                          (game-character-values-color struct)
                          (game-character-values-size struct)
                          (game-character-values-time struct))]
        [(and (key=? key "shift")
              (string=? (game-character-values-color struct) "red"))
         (make-game-character-values
          (game-character-values-x struct)
          (game-character-values-y struct)
          "blue"
          (game-character-values-size struct)
          (game-character-values-time struct))]
        [(key=? key "shift") (make-game-character-values
                              (game-character-values-x struct)
                              (game-character-values-y struct)
                              "red"
                              (game-character-values-size struct)
                              (game-character-values-time struct))]
        [(key=? key "up") (make-game-character-values
                           (game-character-values-x struct)
                           (game-character-values-y struct)
                           (game-character-values-color struct)
                           (max 5 (+ 1 (game-character-values-size struct)))
                           (game-character-values-time struct))]
        [(key=? key "down") (make-game-character-values
                             (game-character-values-x struct)
                             (game-character-values-y struct)
                             (game-character-values-color struct)
                             (max 5 (+ -1 (game-character-values-size struct)))
                             (game-character-values-time struct))]
        [else struct]))

(define (game-tick-handler struct)
  (make-game-character-values
   (game-character-values-x struct)
   (game-character-values-y struct)
   (game-character-values-color struct)
   (game-character-values-size struct)
   (+ 0.01 (game-character-values-time struct))))

(check-expect (game-key-handler aaron "s")
              (make-game-character-values
               (game-character-values-x aaron)
               (+ (game-character-values-y aaron) 4)
               (game-character-values-color aaron)
               (game-character-values-size aaron)
               (game-character-values-time aaron)))


(big-bang aaron
          (on-draw game-scene)
          (on-key game-key-handler)
          (on-tick game-tick-handler 0.01))