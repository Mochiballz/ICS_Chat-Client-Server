#lang racket
(require racket/base)
(require racket/gui/base)

(define frame (new frame% [label "Example"]
                   [width 300]
                   [height 200]))
(define msg (new message% [parent frame]
                          [label "No events so far..."]))

(define panel (new vertical-panel% [parent frame]))
(new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc (rectangle 3 3 "solid" "black")))])
(new button% [parent panel]
             [label "Hello"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send msg set-label "Button click"))])
(new button% [parent panel]
             [label "Left"]
             [callback (lambda (button event)
                         (send msg set-label "Left click"))])
(new button% [parent panel]
             [label "Right"]
             [callback (lambda (button event)
                         (send msg set-label "Right click"))])
(send frame show #t)
