function moves = rookMoves(x, y, Board)
    moves = zeros(14, 2, 'int8');
    idx = 0;
    team = sign(Board(x, y));

    tmpX = x - 1;
    while(tmpX > 0 && Board(tmpX, y) == 0)
        idx = idx + 1;
        moves(idx, :) = [tmpX, y];
        tmpX = tmpX - 1;
    end
    if(tmpX > 0 && sign(Board(tmpX, y)) == -team)
        idx = idx + 1;
        moves(idx, :) = [tmpX, y];
    end

    tmpX = x + 1;
    while(tmpX < 9 && Board(tmpX, y) == 0)
        idx = idx + 1;
        moves(idx, :) = [tmpX, y];
        tmpX = tmpX + 1;
    end
    if(tmpX < 9 && sign(Board(tmpX, y)) == -team)
        idx = idx + 1;
        moves(idx, :) = [tmpX, y];
    end

    tmpY = y - 1;
    while(tmpY > 0 && Board(x, tmpY) == 0)
        idx = idx + 1;
        moves(idx, :) = [x, tmpY];
        tmpY = tmpY - 1;
    end
    if(tmpY > 0 && sign(Board(x, tmpY)) == -team)
        idx = idx + 1;
        moves(idx, :) = [x, tmpY];
    end

    tmpY = y + 1;
    while(tmpY < 9 && Board(x, tmpY) == 0)
        idx = idx + 1;
        moves(idx, :) = [x, tmpY];
        tmpY = tmpY + 1;
    end
    if(tmpY < 9 && sign(Board(x, tmpY)) == -team)
        idx = idx + 1;
        moves(idx, :) = [x, tmpY];
    end
    moves = moves(1:idx, :);
end