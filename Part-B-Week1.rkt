#lang racket

; @reverse: return a list of reversed xs in O(n) time
; Tail Recursion
; Used by Both 1. and 7.
(define reverse (lambda (xs acc)
                  (if (null? xs)
                      acc
                      (reverse (cdr xs) (cons (car xs) acc)))))

; 1. 
; @add:     given two lists a and b, return a list c such that c[i] = a[i] + b[i]
(define (parlindromic xs)
  (define add (lambda (xs ys acc)
                (cond [(and (null? xs) (null? ys)) acc]
                      [(or (null? xs) (null? ys)) (error "different length in add")]
                      [#t (add (cdr xs) (cdr ys) (cons (+ (car xs) (car ys)) acc))])))
    (add xs (reverse xs null) null))

; return a list of first n elements of a stream
; Used to test streams
(define (stream-first-n strm n)
  (define pr (strm))
  (if (= n 0)
      null
      (cons (car pr) (stream-first-n (cdr pr) (- n 1)))))

; 2.
; fibonacci stream
(define fibonacci
  (letrec ([f (lambda (x1 x2) (lambda () (cons x1 (f x2 (+ x1 x2)))))])
    (f 0 1)))

; 3.
(define (stream-until f strm)
  (define pr (strm))
  (if (not (f (car pr)))
      null
      (cons (car pr) (stream-until f (cdr pr)))))

; 4.
(define (stream-map f s)
  (define pr (s))
  (lambda ()
    (cons (f (car pr)) (stream-map f (cdr pr)))))

; 5.
(define (stream-zip s1 s2)
  (define pr1 (s1))
  (define pr2 (s2))
  (lambda ()
    (cons (cons (car pr1) (car pr2))
          (stream-zip (cdr pr1) (cdr pr2)))))

; 7.
(define (interleave strms)
  (define (f old-strms new-strms)
    (cond [(null? old-strms) (define real-new-strms (reverse new-strms null))
                             (define pr ((car real-new-strms)))
                             (lambda ()
                               (cons (car pr) (f (cdr real-new-strms) (list (cdr pr)))))]
          [#t                (define pr ((car old-strms)))
                             (lambda ()
                               (cons (car pr) (f (cdr old-strms) (cons (cdr pr) new-strms))))]))
                              
  (f strms null))

; 8.
; @first-n-ele-and-last-strm given n and s, return a pair where
;   the car part is a list of first n elements of s and
;   the cdr part is the stream starting from the (n+1)th element
(define (pack n s)
  (define (first-n-ele-and-last-strm n s)
    (cond [(= n 0) (cons null s)]
          [#t (define spr (s))
              (define restpr (first-n-ele-and-last-strm (- n 1) (cdr spr)))
              (cons (cons (car spr)
                          (car restpr))
                    (cdr restpr))]))
  (lambda ()
    (define restpr (first-n-ele-and-last-strm n s))
    (cons (car restpr) (pack n (cdr restpr)))))

; 9.
(define (sqrt-stream n)
  (define (f x)
    (lambda ()
      (cons x (f (* (/ 1 2) (+ x (/ n x)))))))
  (f n))

; 10.
; @tester: return whether x is precise enough
; @stream-until-first: given a function f and a stream s
;   return the first element in s that (f x) is #t
(define (approx-sqrt n e)
  (define (tester x)
    (define sqr (* x x))
    (and (< (- n e) sqr) (> (+ n e) sqr)))
  (define (stream-until-first f s)
    (define pr (s))
    (if (f (car pr))
        (car pr)
        (stream-until-first f (cdr pr))))
  (stream-until-first tester (sqrt-stream n)))