
% return a list of possible destinations for a bishop placed on (x, y).
function moves = bishopMoves(x, y, Board)
    moves = zeros(0, 2, 'int8');
    tmpX = x - 1;
    tmpY = y - 1;
    while(tmpX > 0 && tmpY > 0 && Board(tmpX, tmpY) == 0)
        moves(end + 1, :) = [tmpX, tmpY];
        tmpX = tmpX - 1;
        tmpY = tmpY - 1;
    end
    if(tmpX > 0 && tmpY > 0 && sign(Board(tmpX, tmpY)) == -sign(Board(x, y)))
        moves(end + 1, :) = [tmpX, tmpY];
    end

    tmpX = x + 1;
    tmpY = y - 1;
    while(tmpX < 9 && tmpY > 0 && Board(tmpX, tmpY) == 0)
        moves(end + 1, :) = [tmpX, tmpY];
        tmpX = tmpX + 1;
        tmpY = tmpY - 1;
    end
    if(tmpX < 9 && tmpY > 0 && sign(Board(tmpX, tmpY)) == -sign(Board(x, y)))
        moves(end + 1, :) = [tmpX, tmpY];
    end

    tmpX = x + 1;
    tmpY = y + 1;
    while(tmpX < 9 && tmpY < 9 && Board(tmpX, tmpY) == 0)
        moves(end + 1, :) = [tmpX, tmpY];
        tmpX = tmpX + 1;
        tmpY = tmpY + 1;
    end
    if(tmpX < 9 && tmpY < 9 && sign(Board(tmpX, tmpY)) == -sign(Board(x, y)))
        moves(end + 1, :) = [tmpX, tmpY];
    end

    tmpX = x - 1;
    tmpY = y + 1;
    while(tmpX > 0 && tmpY < 9 && Board(tmpX, tmpY) == 0)
        moves(end + 1, :) = [tmpX, tmpY];
        tmpX = tmpX - 1;
        tmpY = tmpY + 1;
    end
    if(tmpX > 0 && tmpY < 9 && sign(Board(tmpX, tmpY)) == -sign(Board(x, y)))
        moves(end + 1, :) = [tmpX, tmpY];
    end
end