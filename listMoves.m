function moves = listMoves(x, y, Board) 
    current = abs(Board(x, y));
    if(current == 0)
       moves = zeros(0, 2, 'int8');
    
    % if pawn
    elseif(current == 6 || current == 9) 
        moves = pawnMoves(x, y, Board);
    
    % if rook
    elseif(current == 5 || current == 8)
       moves = rookMoves(x, y, Board);

    % if knight
    elseif(current == 4)
        moves = knightMoves(x, y, Board);

    % if bishop
    elseif(current == 3)
        moves = bishopMoves(x, y, Board);

    % if queen
    elseif(current == 2)
        moves = bishopMoves(x, y, Board);
        moves = cat(1, moves, rookMoves(x, y, Board));

    % if king
    elseif(current == 1 || current == 7)
        moves = kingMoves(x, y, Board);

    end
    
    % only keep moves which are playable - i.e. playMove() returns
    % success=1
    moveSuccess = zeros(size(moves, 1), 1, 'logical');
    for i = 1:size(moves)
        moveSuccess(i) = playMove(x, y, moves(i, 1), moves(i, 2), Board);
    end
    moves = moves(moveSuccess, :);
end