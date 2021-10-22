;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname launching_rocket_v1) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define HEIGHT 80)
(define WIDTH 100)
(define BACKG (empty-scene WIDTH HEIGHT))
(define CENTER (/ (image-height ROCKET) 2))
(define YDELTA 3)

(define (place-rocket on)
  (place-image ROCKET 10 (- on CENTER) BACKG))

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)


(check-expect
 (show "resting")
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
 
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)))
 
(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 CENTER) BACKG))

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(check-expect
 (show 0)
 (place-image ROCKET 10 (- 0 CENTER) BACKG))

; LRCD -> Image
; renders the state as a resting or flying rocket 
(define (show x)
  (cond
    [(string? x)
     (place-rocket HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket HEIGHT))]
    [(>= x 0)
     (place-rocket x)]))


; launch function tests
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting 
(define (launch x ke)
  (cond
    [(and (string? x) (string=? ke " ")) -3]
    [(and (string? x) (not (string=? ke " "))) "resting"]
    [else x]))
 
; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(define (fly x)
  (cond
    [(string? x) x]
    [(= -1 x) HEIGHT]
    [(negative? x) (+ x 1)]
    [else (- x YDELTA)]))


; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]
    [on-tick fly .5]))
