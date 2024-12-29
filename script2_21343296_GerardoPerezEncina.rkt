#lang racket


(require "player_21343296_GerardoPerezEncina.rkt")
(require "piece_21343296_GerardoPerezEncina.rkt")
(require "board_21343296_GerardoPerezEncina.rkt")
(require "game_21343296_GerardoPerezEncina.rkt")


; 1. Creación de jugadores (10 fichas cada uno para un juego corto)
(define p1 (player 1 "Juan" "red" 0 0 0 10))
(define p2 (player 2 "Mauricio" "yellow" 0 0 0 10))

; 2. Creación de piezas
(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))

; 3. Creación del tablero inicial
(define empty-board (board))

; 4. Creación de un nuevo juego
(define g0 (game p1 p2 empty-board 1))

; 5. Realizando movimientos para crear una victoria diagonal
(define g1 (game-player-set-move g0 p1 3))  ; Juan coloca en columna 0
(define g2 (game-player-set-move g1 p2 0))  ; Mauricio coloca en columna 1
(define g3 (game-player-set-move g2 p1 1))  ; Juan coloca en columna 1
(define g4 (game-player-set-move g3 p2 0))  ; Mauricio coloca en columna 2
(define g5 (game-player-set-move g4 p1 1))  ; Juan coloca en columna 2
(define g6 (game-player-set-move g5 p2 0))  ; Mauricio coloca en columna 3
(define g7 (game-player-set-move g6 p1 4))  ; Juan coloca en columna 2
(define g8 (game-player-set-move g7 p2 0))

; 6. Verificaciones durante el juego
(display "¿Se puede jugar en el tablero vacío? ")
(board-can-play? empty-board)

(display "¿Se puede jugar después de 11 movimientos? ")
(board-can-play? (game-get-board g8))

(display "Jugador actual después de 11 movimientos: ")
(game-get-current-player g8)

; 7. Verificación de victoria
(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g8))

(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g8))

(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g8))

(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g8))

; 8. Verificación de empate
(display "¿Es empate? ")
(game-is-draw? g8)

; 9. Finalizar el juego y actualizar estadísticas
(define ended-game (game-set-end g8))


; 10. Mostrar historial de movimientos
(display "Historial de movimientos: ")
;(game-history ended-game)

; 11. Mostrar estado final del tablero
(display "Estado final del tablero: ")
(game-get-board ended-game)