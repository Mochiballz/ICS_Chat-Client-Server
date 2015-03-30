#lang racket

(require racket/base)
(require picturing-programs)
(require 2htdp/universe)

; CONSTANTS

(struct posn (x y) #:transparent)
(define BALL-LOCATION-1 (posn 0 0))
(define BALL-LOCATION-2 (posn 0 0))

(define BALL-RADIUS-1 10)
(define BALL-RADIUS-2 10)

(define BALL-COLOR-1 "red")
(define BALL-COLOR-2 "blue")

(struct circle-info (x y r clr) #:transparent)
(define BALL-INFO-1 (circle-info 0 0 BALL-RADIUS-1 BALL-COLOR-1))
(define BALL-INFO-2 (circle-info 0 0 BALL-RADIUS-2 BALL-COLOR-2))

(struct 2-ci (b1 b2) #:transparent)
(define var (2-ci BALL-INFO-1 BALL-INFO-2))

; FUNCTIONS

(define (arrow-move struct ch-X ch-Y)
  (2-ci (struct-copy circle-info (2-ci-b1 struct) [x (+ (circle-info-x (2-ci-b1 struct)) ch-X)]
                     [y (+ (circle-info-y (2-ci-b1 struct)) ch-Y)]) (2-ci-b2 struct)))

(define (wasd-move struct ch-X ch-Y)
  (2-ci (2-ci-b1 struct) (struct-copy circle-info (2-ci-b2 struct) [x (+ (circle-info-x (2-ci-b2 struct)) ch-X)]
                                      [y (+ (circle-info-y (2-ci-b2 struct)) ch-Y)])))

(define (left-move struct)
  (arrow-move struct -5 0))

(define (right-move struct)
  (arrow-move struct 5 0))

(define (up-move struct)
  (arrow-move struct 0 -5))

(define (down-move struct)
  (arrow-move struct 0 5))

(define (a-move struct)
  (wasd-move struct -5 0))

(define (d-move struct)
  (wasd-move struct 5 0))

(define (w-move struct)
  (wasd-move struct 0 -5))

(define (s-move struct)
  (wasd-move struct 0 5))

(define (ci->list struct)
  (list (circle-info-x (2-ci-b1 struct))
        (circle-info-y (2-ci-b1 struct))
        (circle-info-r (2-ci-b1 struct))
        (circle-info-clr (2-ci-b1 struct))
        (circle-info-x (2-ci-b2 struct))
        (circle-info-y (2-ci-b2 struct))
        (circle-info-r (2-ci-b2 struct))
        (circle-info-clr (2-ci-b2 struct))))

(define (list->ci list)
  (2-ci (circle-info (list-ref list 0)
                     (list-ref list 1)
                     (list-ref list 2)
                     (list-ref list 3))
        (circle-info (list-ref list 4)
                     (list-ref list 5)
                     (list-ref list 6)
                     (list-ref list 7))))

(define (pkgify struct)
  (ci->list struct))

(define (arrow-handler struct key)
  (cond [(key=? key "left") (left-move struct)]
        [(key=? key "right") (right-move struct)]
        [(key=? key "up") (up-move struct)]
        [(key=? key "down") (down-move struct)]
        [else struct]))

(define (wasd-handler struct key)
  (cond [(key=? key "a") (a-move struct)]
        [(key=? key "d") (d-move struct)]
        [(key=? key "w") (w-move struct)]
        [(key=? key "s") (s-move struct)]
        [else struct]))

(define (key-handler struct key)
  (cond [(or (key=? key "left") (key=? key "right") (key=? key "up") (key=? key "down"))
         (arrow-handler struct key)]
        [(or (key=? key "a") (key=? key "d") (key=? key "w") (key=? key "s"))
         (wasd-handler struct key)]
        [else struct]))

(define (draw-handler struct)
  (place-image (circle 5 "solid" (circle-info-clr (2-ci-b1 struct))) 
               (circle-info-x (2-ci-b1 struct))
               (circle-info-y (2-ci-b1 struct))
               (place-image (circle 5 "solid" (circle-info-clr (2-ci-b2 struct))) 
                            (circle-info-x (2-ci-b2 struct))
                            (circle-info-y (2-ci-b2 struct))
                            (rectangle 800 600 "solid" "white"))))

  

(big-bang var
          (on-draw draw-handler)
          (on-key key-handler)
          (register "10.14.73.231")
          (name "test"))