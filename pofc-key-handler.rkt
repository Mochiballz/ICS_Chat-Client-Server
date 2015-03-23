#lang racket

(require racket/base)
(require 2htdp/universe)
(require picturing-programs)
(require test-engine/racket-tests)

(struct boop (n) #:transparent)
(define booper (boop ""))

(define (key-handler struct key)
  (boop key))

(define (draw-handler struct)
  (overlay/align "middle" "middle" (text (boop-n struct) 50 "black")
                 (rectangle 200 100 "solid" "white")))

(big-bang booper
          (on-draw draw-handler)
          (on-key key-handler))