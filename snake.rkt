;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname snake) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

; snake-game: struct(player) struct(block) struct(menu) -> struct
; struct to hold all info, including player stats, block stats, and menu info

(define-struct snake-game (player block menu))

; player: number(x) number(y) -> struct
; player stats to hold x and y coordinates of player

(define-struct player (x y))

; block: number(x) number(y) -> struct
; holds coordinates for block being collected

(define-struct block (x y))

; menu: number