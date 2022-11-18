% lists all possible moves for a king
function moves = kingMoves(pos, Board)
    moves = zeros(8, 1, 'int8'); % initialized to the max number of moves
    idx = 0;
    team = sign(Board(pos));
    [x, y] = myind2sub(pos);

    % normal moves
    tmpX = x + 1;
    if(tmpX < 9)
        tmpY = y - 1;
        if(tmpY > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
        if(sign(Board(tmpX, y)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, y);
        end
        tmpY = y + 1;
        if(tmpY < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
    end

    tmpX = x - 1;
    if(tmpX > 0)
        tmpY = y - 1;
        if(tmpY > 0 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
        if(sign(Board(tmpX, y)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, y);
        end
        tmpY = y + 1;
        if(tmpY < 9 && sign(Board(tmpX, tmpY)) ~= team)
            idx = idx + 1;
            moves(idx) = mysub2ind(tmpX, tmpY);
        end
    end

    tmpY = y + 1;
    if(tmpY < 9 && sign(Board(x, tmpY)) ~= team)
        idx = idx + 1;
        moves(idx) = mysub2ind(x, tmpY);
    end
    
    tmpY = y - 1;
    if(tmpY > 0 && sign(Board(x, tmpY)) ~= team)
        idx = idx + 1;
        moves(idx) = mysub2ind(x, tmpY);
    end

    % castle
    if(abs(Board(x, y)) == 1 && abs(Board(x + 3, y)) == 5)
        if(Board(x + 1, y) == 0 && Board(x + 2, y) == 0)
            idx = idx + 1;
            moves(idx) = mysub2ind(x + 2, y);
        end
    end
    if(abs(Board(x, y)) == 1 && abs(Board(x - 4, y)) == 5)
        if(Board(x - 1, y) == 0 && Board(x - 2, y) == 0 && Board(x - 3, y) == 0)
            idx = idx + 1;
            moves(idx) = mysub2ind(x - 2, y);
        end
    end
    moves = moves(1:idx); % shrink array to number of valid moves
end
