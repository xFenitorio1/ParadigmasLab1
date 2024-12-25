#lang racket
(require "player_21343296_GerardoPerezEncina.rkt");importa el player
(require "piece_21343296_GerardoPerezEncina.rkt");importa la pieza
(require "board_21343296_GerardoPerezEncina.rkt")
(provide game)
(provide game-history)
(provide game-is-draw?)
(provide game-get-current-player)
(provide game-get-board)
(provide game-set-end)
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

; ------------------------------------------------
; Nombre: game-get-board
; Descripcion: Devuelve el tablero actual del juego
; Dominio: game (estructura del juego)
; Recorrido: board (tablero actual del juego)

(define (game-get-board game)
  (third game))

; ------------------------------------------------
; Nombre: game-set-end
; Descripcion: Finaliza el juego actual, actualizando las estadísticas según el resultado
; Dominio: game (estructura del juego)
; Recorrido: game (estructura actualizada con el estado final del juego)

(define (game-set-end game)
  ; Extraer datos del juego
  (define jugador1 (first game))
  (define jugador2 (second game))
  (define tablero (third game))
  (define historial (fifth game))

  ; Determinar el ganador o empate
  (cond
    [(= (board-who-is-winner tablero) 1) ; Si el jugador 1 gana
     (list 
      (player-update-stats jugador1 "win") ; Actualizar jugador 1 como ganador
      (player-update-stats jugador2 "loss") ; Actualizar jugador 2 como perdedor
      tablero ; Tablero sin cambios
      0 ; Juego terminado
      historial)] ; Mantener el historial

    [(= (board-who-is-winner tablero) 2) ; Si el jugador 2 gana
     (list 
      (player-update-stats jugador1 "loss") ; Actualizar jugador 1 como perdedor
      (player-update-stats jugador2 "win") ; Actualizar jugador 2 como ganador
      tablero ; Tablero sin cambios
      0 ; Juego terminado
      historial)] ; Mantener el historial

    [(game-is-draw? game) ; Si es empate
     (list 
      (player-update-stats jugador1 "draw") ; Actualizar jugador 1 como empate
      (player-update-stats jugador2 "draw") ; Actualizar jugador 2 como empate
      tablero ; Tablero sin cambios
      0 ; Juego terminado
      historial)] ; Mantener el historial

    [else game])) ; Si no hay ganador ni empate, retorna el juego sin cambios

