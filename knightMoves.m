% lists all possible moves for a knight
function moves = knightMoves(pos, Board)
    moves = zeros(8, 1, 'int8'); % initialized to the max number of moves
    idx = 0;
    team = sign(Board(pos));
    [x, y] = myind2sub( pos);

    tmpX = x + 1;
    if(tmpX < 9)
        tmpY = y - 2;
        if(tmpY > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
        tmpY = y + 2;
        if(tmpY < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
    end

    tmpX = x - 1;
    if(tmpX > 0)
        tmpY = y - 2;
        if(tmpY > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
        tmpY = y + 2;
        if(tmpY < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
    end

    tmpY = y + 1;
    if(tmpY < 9)
        tmpX = x - 2;
        if(tmpX > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
        tmpX = x + 2;
        if(tmpX < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
    end

    tmpY = y - 1;
    if(tmpY > 0)
        tmpX = x - 2;
        if(tmpX > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
        tmpX = x + 2;
        if(tmpX < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
    end
    moves = moves(1:idx); % shrink array to number of valid moves
end