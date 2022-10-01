function moves = rookMoves(x, y, Board)
    moves = zeros(0, 2, 'int8');
    tmpX = x - 1;
    while(tmpX > 0 && Board(tmpX, y) == 0)
        moves(end + 1, :) = [tmpX, y];
        tmpX = tmpX - 1;
    end
    if(tmpX > 0 && sign(Board(tmpX, y)) == -sign(Board(x, y)))
        moves(end + 1, :) = [tmpX, y];
    end

    tmpX = x + 1;
    while(tmpX < 9 && Board(tmpX, y) == 0)
        moves(end + 1, :) = [tmpX, y];
        tmpX = tmpX + 1;
    end
    if(tmpX < 9 && sign(Board(tmpX, y)) == -sign(Board(x, y)))
        moves(end + 1, :) = [tmpX, y];
    end

    tmpY = y - 1;
    while(tmpY > 0 && Board(x, tmpY) == 0)
        moves(end + 1, :) = [x, tmpY];
        tmpY = tmpY - 1;
    end
    if(tmpY > 0 && sign(Board(x, tmpY)) == -sign(Board(x, y)))
        moves(end + 1, :) = [x, tmpY];
    end

    tmpY = y + 1;
    while(tmpY < 9 && Board(x, tmpY) == 0)
        moves(end + 1, :) = [x, tmpY];
        tmpY = tmpY + 1;
    end
    if(tmpY < 9 && sign(Board(x, tmpY)) == -sign(Board(x, y)))
        moves(end + 1, :) = [x, tmpY];
    end
    return;
end