#lang racket

(require "TDAPlayer.rkt")
(require "TDAPiece.rkt")
(require "TDABoard.rkt")
(provide player piece board)

;; =====================================================================
;;
;;                              RF-01
;;
;; =====================================================================

#|----------------------------------------------------------------------|#

;; =====================================================================
;;
;;                              RF-02
;;
;; =====================================================================

;; Nombre: player
;; Descripcion: Constructor del TDA Player
;; Dominio: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining-pieces (int)
;; Recorrido: player
;; Recursion: No aplica
;; Tipo de Recursion: No aplica

(define (player id name color wins losses draws remaining-pieces)
  (list id name color wins losses draws remaining-pieces)
  )

#|----------------------------------------------------------------------|#


;; =====================================================================
;;
;;                              RF-03
;;
;; =====================================================================

;; Nombre: piece
;; Descripcion: Constructor del TDA Piece
;; Dominio: color (string)
;; Recorrido: piece
;; Recursion: No aplica
;; Tipo de Recursion: No aplica

(define (piece color)
  (list color))


#|----------------------------------------------------------------------|#


;; =====================================================================
;;
;;                              RF-04
;;
;; =====================================================================

;; Nombre: board
;; Descripcion: Permite la creacion del tablero
;; Dominio: No aplica
;; Recorrido: board
;; Recursion: No aplica
;; Tipo de Recursion: No aplica

(define empty-board (board))

#|----------------------------------------------------------------------|#

;; =====================================================================
;;
;;                              RF-05
;;
;; =====================================================================

;; Nombre:
;; Descripcion:
;; Dominio:
;; Recorrido: 
;; Recursion:
;; Tipo de Recursion: