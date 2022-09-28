function [possibilities] = getPositions(x, y, Board) 
    current = Board(x, y);
    if(current == 0)
       possibilities = [];
    
    % if pawn
    elseif(abs(current) == 6 || abs(current) == 9) 
        possibilities = pawnMoves(x, y, Board);
    
    % if rook
    elseif(abs(current) == 5 || abs(current) == 8)
       possibilities = rookMoves(x, y, Board);

    % if knight
    elseif(abs(current) == 4)
        possibilities = knightMoves(x, y, Board);

    % if bishop
    elseif(abs(current) == 3)
        possibilities = bishopMoves(x, y, Board);

    % if queen
    elseif(abs(current) == 2)
        possibilities = bishopMoves(x, y, Board);
        possibilities = cat(1, possibilities, rookMoves(x, y, Board));

    % if king
    elseif(abs(current) == 1 || abs(current) == 7)
        possibilities = kingMoves(x, y, Board);

    end
    
    finalPos = [];
    for i = 1:size(possibilities)
        if(computeMove(x, y, possibilities(i, 1), possibilities(i, 2), Board))
            finalPos(end + 1, :) =  [possibilities(i, 1), possibilities(i, 2)];
        end
    end
    possibilities = finalPos;
end