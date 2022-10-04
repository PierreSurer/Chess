function moves = listMoves(pos, Board) 
    current = abs(Board(pos));
    if(current == 0)
       moves = zeros(0, 1, 'int8');
    
    % if pawn
    elseif(current == 6 || current == 9) 
        moves = pawnMoves(pos, Board);
    
    % if rook
    elseif(current == 5 || current == 8)
       moves = rookMoves(pos, Board);

    % if knight
    elseif(current == 4)
        moves = knightMoves(pos, Board);

    % if bishop
    elseif(current == 3)
        moves = bishopMoves(pos, Board);

    % if queen
    elseif(current == 2)
        moves = bishopMoves(pos, Board);
        moves = cat(1, moves, rookMoves(pos, Board));

    % if king
    elseif(current == 1 || current == 7)
        moves = kingMoves(pos, Board);
    end
end