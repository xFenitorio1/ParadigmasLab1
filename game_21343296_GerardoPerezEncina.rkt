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
(provide game-player-set-move)


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


; ------------------------------------------------
; Nombre: game-player-set-move
; Descripcion: Realiza un movimiento en el juego, actualizando el tablero, turno y jugadores
; Dominio: game (estructura del juego), player (jugador actual), column (int)
; Recorrido: game (estructura actualizada del juego después del movimiento)

(define (game-player-set-move game player column)
  ; Extraer datos del juego
  (define turno-actual (fourth game))
  (define jugador1 (first game))
  (define jugador2 (second game))
  (define tablero (third game))
  (define historial (fifth game))

  ; Verificar si es el turno del jugador correcto
  (cond
    [(and (= turno-actual 1) (not (equal? player jugador1)))
     (error "Turno incorrecto para el jugador")]
    [(and (= turno-actual 2) (not (equal? player jugador2)))
     (error "Turno incorrecto para el jugador")]
    [else #t]) ; Si el turno es correcto, continúa

  ; Obtener el color del jugador actual
  (define color (player-color player))

  ; Colocar la pieza en el tablero
  (define tablero-actualizado (board-set-play-piece tablero column color))

  ; Reducir las fichas del jugador actual
  (define jugador1-actualizado
    (if (= turno-actual 1)
        (list (player-id jugador1)
              (player-name jugador1)
              (player-color jugador1)
              (player-wins jugador1)
              (player-loses jugador1)
              (player-draws jugador1)
              (- (player-remaining-pieces jugador1) 1))
        jugador1))

  (define jugador2-actualizado
    (if (= turno-actual 2)
        (list (player-id jugador2)
              (player-name jugador2)
              (player-color jugador2)
              (player-wins jugador2)
              (player-loses jugador2)
              (player-draws jugador2)
              (- (player-remaining-pieces jugador2) 1))
        jugador2))

  ; Actualizar el historial (incluye ID, columna y color)
  (define historial-actualizado
    (append historial (list (list (player-id player) column color))))

  ; Verificar si el juego ha terminado
  (define ganador (board-who-is-winner tablero-actualizado))
  (define es-empate (game-is-draw? (list jugador1-actualizado jugador2-actualizado tablero-actualizado turno-actual historial-actualizado)))

  ; Si el juego ha terminado, actualizar estadísticas y finalizar
  (if (or ganador es-empate)
      (game-set-end (list 
                     jugador1-actualizado
                     jugador2-actualizado
                     tablero-actualizado
                     0
                     historial-actualizado))

      ; Si el juego continúa, actualizar el turno y retornar el estado actualizado
      (list
       jugador1-actualizado
       jugador2-actualizado
       tablero-actualizado
       (if (= turno-actual 1) 2 1) ; Cambiar el turno al otro jugador
       historial-actualizado)))


