#lang racket
(require "player_21343296_GerardoPerezEncina.rkt");importa el player
(require "piece_21343296_GerardoPerezEncina.rkt");importa la pieza
(require "board_21343296_GerardoPerezEncina.rkt")
(provide game)
(provide game-history)
(provide game-is-draw?)
(provide game-get-current-player)
;(provide game-get-board)
;(provide game-set-end)
;(provide game-player-set-move)
;(provide game-get-current-turn)


; ------------------------------------------------
; Nombre: game
; Descripcion: Constructor de la estructura del juego
; Dominio: player1 (player), player2 (player), board (board), current-turn (int)
; Recorrido: game (estructura del juego que incluye jugadores, tablero, turno y historial)

(define (game player1 player2 board current-turn)
  (list player1 player2 board current-turn '())) ;El ultimo es para el historial

; ------------------------------------------------
; Nombre: game-history
; Descripción: Devuelve el historial de movimientos de la partida.
; Dominio: game (estructura del juego)
; Recorrido: historial de movimientos (lista de listas)

(define (game-history game)
  (fifth game)) 

; ------------------------------------------------
; Nombre: game-is-draw?
; Descripcion: Verifica si el juego actual es un empate
; Dominio: game (estructura del juego)
; Recorrido: booleano (#t si es empate, #f si no)

(define (game-is-draw? game)

  (define tablero (car (cddr game))) 
  (define jugador1 (car game))       
  (define jugador2 (cadr game))       


  (define tablero-lleno (not (board-can-play? tablero)))


  (define jugadores-sin-fichas
    (and (= (player-remaining-pieces jugador1) 0)
         (= (player-remaining-pieces jugador2) 0)))

  (or tablero-lleno jugadores-sin-fichas))

; ------------------------------------------------
; Nombre: game-get-current-player
; Descripcion: Devuelve el jugador actual según el turno
; Dominio: game (estructura del juego)
; Recorrido: player (jugador actual)

(define (game-get-current-player game)
  (if (= (fourth game) 1)
      (first game)   ; Retorna el primer jugador si el turno es 1
      (second game)))
