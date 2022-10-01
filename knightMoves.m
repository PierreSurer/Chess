function moves = knightMoves(x, y, Board)
    moves = zeros(8, 2, 'int8');
    idx = 0;
    team = sign(Board(x, y));

    tmpX = x + 1;
    if(tmpX < 9)
        tmpY = y - 2;
        if(tmpY > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx, :) = [tmpX, tmpY];
        end
        tmpY = y + 2;
        if(tmpY < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx, :) = [tmpX, tmpY];
        end
    end

    tmpX = x - 1;
    if(tmpX > 0)
        tmpY = y - 2;
        if(tmpY > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx, :) = [tmpX, tmpY];
        end
        tmpY = y + 2;
        if(tmpY < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx, :) = [tmpX, tmpY];
        end
    end

    tmpY = y + 1;
    if(tmpY < 9)
        tmpX = x - 2;
        if(tmpX > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx, :) = [tmpX, tmpY];
        end
        tmpX = x + 2;
        if(tmpX < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx, :) = [tmpX, tmpY];
        end
    end

    tmpY = y - 1;
    if(tmpY > 0)
        tmpX = x - 2;
        if(tmpX > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx, :) = [tmpX, tmpY];
        end
        tmpX = x + 2;
        if(tmpX < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx, :) = [tmpX, tmpY];
        end
    end
    moves = moves(1:idx, :);
end