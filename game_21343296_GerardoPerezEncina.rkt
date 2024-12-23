#lang racket
(require "player_21343296_GerardoPerezEncina.rkt");importa el player
(require "piece_21343296_GerardoPerezEncina.rkt");importa la pieza
(require "board_21343296_GerardoPerezEncina.rkt")
(provide game)
;(provide game-is-draw?)
;(provide game-get-current-player)
;(provide game-get-board)
;(provide game-set-end)
;(provide game-player-set-move)
;(provide game-history)
;(provide game-get-current-turn)


; ------------------------------------------------
; Nombre: game
; Descripcion: 
; Dominio: player1 (player) 
; Recorrido: 

(define (game player1 player2 board current-turn)
  (list player1 player2 board current-turn '())) ;El ultimo es para el historial
