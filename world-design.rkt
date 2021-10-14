;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname world-design) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; CONSTANTS DEFINITIONS
(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BG (place-image tree 200 30 (empty-scene 250 40)))
(define (wheel p) (circle p "solid" "black"))
(define (wheels p) (beside (wheel p) (rectangle p (* p 3) "solid" "white") (wheel p)))
(define (vehicle p) (overlay/offset (rectangle (* p 7) (* 2 p) "solid" "gray") 0 8 (wheels p)))

(define INITIAL_WORLD_STATE (list 10 100))

; WorldState -> Image
; big-bang obtains the image of the current state of the world evaluating this function
(check-expect (render INITIAL_WORLD_STATE) (overlay/align "right" "top" (text "100" 20 "red") (place-image (vehicle 10) 10 20 BG)))
(define (render ws) (overlay/align "right" "top" (text (number->string (second ws)) 20 "red") (place-image (vehicle 10) (first ws) 20 BG)) )


; WorldState String -> WorldState
; for a key pressed a string is passed as argument representing it, 
; and big-bang obtains the next state of the world
(define (move-to ws key)
  (cond
    [(string=? key "a") (list(- (first ws) 3) (second ws))]
    [(string=? key "d") (list(+ (first ws) 3) (second ws))]
    [#true ws]))
  
(check-expect (move-to INITIAL_WORLD_STATE "a") (list 7 100))
(check-expect (move-to INITIAL_WORLD_STATE "d") (list 13 100))
(check-expect (move-to INITIAL_WORLD_STATE "x") (list 10 100))


; WorldState -> WorldState
; for a given state and a clock tick return a return a state with the second value changed
; and the first non-changed

(check-expect (rest-time INITIAL_WORLD_STATE) (list 10 99))
(define (rest-time ws)
  (list (first ws) (- (second ws) 1)))

;WorldState Number -> List
; for a WorldState it determines if a World must finish
; it must finish if the "restant time" is zero

(check-expect #true (must-finish? (list 10 0)))
(check-expect #true (must-finish? (list 251 1)))
(check-expect #true (must-finish? (list 300 0)))
(check-expect #false (must-finish? (list 200 1)))
(define (must-finish? ws)                                      ; this (vehicle 10) is harcoded, how to fix it?
  (or (= 0 (second ws)) (>= (first ws) (- (image-width BG) (/ (image-width (vehicle 10)) 2))))
  )


; WorldState Number Number String -> WorldState
; places a car at x position of the mouse
; if the given me is "button-down"

(define (hyper ws x-mouse y-mouse me) 
  (list x-mouse (second ws)))

; WorldState -> World
; A WorldState is a list of two numbers, the first one represents the position of the vehicle
; the second one represents the restant time between the start of the game
; for a initial state returns a world with that state
(define (main ws) (big-bang ws
    [to-draw render]
    [on-key move-to]
    [on-tick rest-time]
    [stop-when must-finish?]
    [on-mouse hyper]
                    ))
; (main INITIAL_WORLD_STATE)
