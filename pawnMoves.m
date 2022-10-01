function moves = pawnMoves(x, y, Board)
    moves = zeros(4, 2, 'int8');
    idx = 0;
    team = sign(Board(x, y));
    tmpY = y + team;

    % normal forward move
    if(Board(x, tmpY) == 0)
        idx = idx + 1;
        moves(idx, 1) = x;
        moves(idx, 2) = tmpY;
    end

    % double forward move (white)
    if(y == 2 && sign(Board(x, 2)) == 1) 
        if(Board(x, 3) == 0 && Board(x, 4) == 0)
            idx = idx + 1;
            moves(idx, 1) = x;
            moves(idx, 2) = 4;
        end
        % double forward move (black)
    elseif(y == 7 && sign(Board(x, 7)) == -1) 
        if(Board(x, 6) == 0 && Board(x, 5) == 0)
            idx = idx + 1;
            moves(idx, 1) = x;
            moves(idx, 2) = 5;
        end
    end

    tmpX = x + 1;
    if(tmpX < 9)
        % diagonal attack move
        if(sign(Board(tmpX, tmpY)) == -team)
            idx = idx + 1;
            moves(idx, 1) = tmpX;
            moves(idx, 2) = tmpY;
        else
            % en passant
            if(Board(tmpX, y) == -team * 9 && Board(tmpX, tmpY) == 0)
                idx = idx + 1;
                moves(idx, 1) = tmpX;
                moves(idx, 2) = tmpY;
            end
        end
    end
    tmpX = x - 1;
    if(tmpX > 0)
        % diagonal attack move
        if(sign(Board(tmpX, tmpY)) == -team)
            idx = idx + 1;
            moves(idx, 1) = tmpX;
            moves(idx, 2) = tmpY;
        else
            % en passant
            if(Board(tmpX, y) == -team * 9 && Board(tmpX, tmpY) == 0)
                idx = idx + 1;
                moves(idx, 1) = tmpX;
                moves(idx, 2) = tmpY;
            end
        end
    end    
    moves = moves(1:idx, :);
end