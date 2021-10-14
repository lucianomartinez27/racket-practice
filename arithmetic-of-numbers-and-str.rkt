;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname arithmetic-of-numbers-and-str) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define x 3) 
(define y 4)
(define prefix "hello") 
(define suffix "world")
(define str "helloworld") 
(define i 5)

(define (distance-to-origin p1 p2)
  (sqrt (+(expt p1 2) (expt p2 2))))


(define (add-hyphen word1 word2)
  (string-append word1 "_" word2))

(define (add-hyphen-at a_word at)
  (string-append (substring a_word 0 at) 
                            "_" (substring a_word at (string-length a_word))))

(define (delete-char-at a_word at)
  (string-append (substring a_word 0 (- at 1)) 
    (substring a_word at (string-length a_word))))