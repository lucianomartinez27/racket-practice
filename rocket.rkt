;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; constants
(define WIDTH 500)
(define HEIGHT 600)
(define ROCKET (overlay (circle 10 "solid" "green")
                       (rectangle 40 4 "solid" "red")))
(define BOTTOM (- HEIGHT 10))
(define CENTER (/ WIDTH 2))
(define BACKGROUND (place-image (rectangle 40 40 "solid" "gray") CENTER BOTTOM (rectangle WIDTH HEIGHT "solid" "blue")))
(define V 3)
;functions
(define (times-bigger-than n1 n2)
  (/ n2 n1))
(define (distance t) (* V t))

(define (height-distance t) (remainder (distance t) HEIGHT))
(define (width-distance t)  (* (height-distance t) (times-bigger-than  HEIGHT WIDTH)))
(define (picture-of-rocket.v4 t)
        (place-image ROCKET
                     (width-distance t) (height-distance t)
                     BACKGROUND))


; (animate picture-of-rocket.v4)
;(/ (- HEIGHT WIDTH) HEIGHT)
; (percentage-of-change  HEIGHT WIDTH)