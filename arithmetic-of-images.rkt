;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname airthmetic-of-images) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define BACKGROUND (empty-scene 300 300))
(define tree-leaves  (circle (/ (image-width BACKGROUND) 4) "solid" "green"))
(define tree-trunk (rectangle (/ (image-width BACKGROUND) 4) (image-height BACKGROUND) "solid" "brown"))
(define BACKGROUND-WIDTH-CENTER (/ (image-width BACKGROUND) 2))
(define BACKGROUND-TOP (/ (image-height tree-leaves) 1.8))
(define BACKGROUND-TOP-CENTER (/ (image-height BACKGROUND) 1.8))

(define tree (place-image tree-leaves BACKGROUND-WIDTH-CENTER BACKGROUND-TOP
                          (place-image tree-trunk BACKGROUND-WIDTH-CENTER BACKGROUND-TOP-CENTER BACKGROUND)))