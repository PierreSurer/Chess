function moves = pawnMoves(pos, Board)
    moves = zeros(4, 1, 'int8');
    idx = 0;
    team = sign(Board(pos));
    [x, y] = ind2sub([8 8], pos);
    tmpY = y + team;

    % normal forward move
    if(Board(x, tmpY) == 0)
        idx = idx + 1;
        moves(idx) = sub2ind([8 8], x, tmpY);
    end

    % double forward move (white)
    if(y == 2 && sign(Board(x, 2)) == 1) 
        if(Board(x, 3) == 0 && Board(x, 4) == 0)
            idx = idx + 1;
            moves(idx) = sub2ind([8 8], x, 4);
        end
        % double forward move (black)
    elseif(y == 7 && sign(Board(x, 7)) == -1) 
        if(Board(x, 6) == 0 && Board(x, 5) == 0)
            idx = idx + 1;
            moves(idx) = sub2ind([8 8], x, 5);
        end
    end

    tmpX = x + 1;
    if(tmpX < 9)
        % diagonal attack move
        if(sign(Board(tmpX, tmpY)) == -team)
            idx = idx + 1;
            moves(idx) = sub2ind([8 8], tmpX, tmpY);
        else
            % en passant
            if(Board(tmpX, y) == -team * 9 && Board(tmpX, tmpY) == 0)
                idx = idx + 1;
                moves(idx) = sub2ind([8 8], tmpX, tmpY);
            end
        end
    end
    tmpX = x - 1;
    if(tmpX > 0)
        % diagonal attack move
        if(sign(Board(tmpX, tmpY)) == -team)
            idx = idx + 1;
            moves(idx) = sub2ind([8 8], tmpX, tmpY);
        else
            % en passant
            if(Board(tmpX, y) == -team * 9 && Board(tmpX, tmpY) == 0)
                idx = idx + 1;
                moves(idx) = sub2ind([8 8], tmpX, tmpY);
            end
        end
    end
    moves = moves(1:idx); % shrink array to number of valid moves
end