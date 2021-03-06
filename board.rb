#!/usr/bin/env ruby

def board_from_string(str)
  (0..2).map { |i| str.chars[i * 3, 3] }
end

def coords_from_move(move)
  [
    (move.to_i - 1) / 3,
    (move.to_i - 1) % 3
  ]
end

def in_bounds?(row, col)
  (0..2).include?(row) && (0..2).include?(col)
end

def apply_move(board, move)
  new_board = board.map { |row| row.dup }
  coords    = coords_from_move(move)

  offsets = [[-1, 0], [0, -1], [0, 0], [0, 1], [1, 0]]

  offsets.each do |row_offset, col_offset|
    row = coords.first + row_offset
    col = coords.last  + col_offset

    if in_bounds?(row, col)
      new_board[row][col] = if board[row][col] == "1"
        "0"
      else
        "1"
      end
    end
  end

  new_board
end

def print_board(board)
  board.each { |row| puts row.join }
end

board = board_from_string(ARGV[0])
moves = (ARGV[1] || "").chars

moves.each do |move|
  board = apply_move(board, move)
end

print_board(board)
