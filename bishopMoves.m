% return a list of possible destinations for a bishop placed on (x, y).
function moves = bishopMoves(pos, Board)
    moves = zeros(14, 1, 'int8'); % initialized to the max number of moves
    idx = 0;
    team = sign(Board(pos));
    [x, y] = ind2sub([8 8], pos);
    
    tmpX = x - 1;
    tmpY = y - 1;
    while(min(tmpX, tmpY) > 0 && Board(tmpX, tmpY) == 0)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], tmpX, tmpY);
        tmpX = tmpX - 1;
        tmpY = tmpY - 1;
    end
    if(min(tmpX, tmpY) > 0 && sign(Board(tmpX, tmpY)) == -team)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], tmpX, tmpY);
    end

    tmpX = x + 1;
    tmpY = y - 1;
    while(tmpX < 9 && tmpY > 0 && Board(tmpX, tmpY) == 0)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], tmpX, tmpY);
        tmpX = tmpX + 1;
        tmpY = tmpY - 1;
    end
    if(tmpX < 9 && tmpY > 0 && sign(Board(tmpX, tmpY)) == -team)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], tmpX, tmpY);
    end

    tmpX = x + 1;
    tmpY = y + 1;
    while(tmpX < 9 && tmpY < 9 && Board(tmpX, tmpY) == 0)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], tmpX, tmpY);
        tmpX = tmpX + 1;
        tmpY = tmpY + 1;
    end
    if(tmpX < 9 && tmpY < 9 && sign(Board(tmpX, tmpY)) == -team)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], tmpX, tmpY);
    end

    tmpX = x - 1;
    tmpY = y + 1;
    while(tmpX > 0 && tmpY < 9 && Board(tmpX, tmpY) == 0)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], tmpX, tmpY);
        tmpX = tmpX - 1;
        tmpY = tmpY + 1;
    end
    if(tmpX > 0 && tmpY < 9 && sign(Board(tmpX, tmpY)) == -team)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], tmpX, tmpY);
    end
    moves = moves(1:idx); % shrink array to number of valid moves
end