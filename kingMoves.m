function moves = kingMoves(x, y, Board)
    moves = zeros(0, 2, 'int8');
    % normal moves
    if(x + 1 < 9)
        if(Board(x + 1, y) == 0 || sign(Board(x + 1, y)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x + 1, y];
        end
        if(y + 1 < 9 && (Board(x + 1, y + 1) == 0 || sign(Board(x + 1, y + 1)) ~= sign(Board(x, y))))
            moves(end + 1, :) = [x + 1, y + 1];
        end
        if(y - 1 > 0 && (Board(x + 1, y - 1) == 0 || sign(Board(x + 1, y - 1)) ~= sign(Board(x, y))))
            moves(end + 1, :) = [x + 1, y - 1];
        end
    end
    if(x - 1 > 0)
        if(Board(x - 1, y) == 0 || sign(Board(x - 1, y)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x - 1, y];
        end
        if(y + 1 < 9 && (Board(x - 1, y + 1) == 0 || sign(Board(x - 1, y + 1)) ~= sign(Board(x, y))))
            moves(end + 1, :) = [x - 1, y + 1];
        end
        if(y - 1 > 0 && (Board(x - 1, y - 1) == 0 || sign(Board(x - 1, y - 1)) ~= sign(Board(x, y))))
            moves(end + 1, :) = [x - 1, y - 1];
        end
    end
    if(y + 1 < 9 && (Board(x, y + 1) == 0 || sign(Board(x, y + 1)) ~= sign(Board(x, y))))
        moves(end + 1, :) = [x, y + 1];
    end
    if(y - 1 > 0 && (Board(x, y - 1) == 0 || sign(Board(x, y - 1)) ~= sign(Board(x, y))))
        moves(end + 1, :) = [x, y - 1];
    end
    % castle
    if(abs(Board(x, y)) == 1 && abs(Board(x + 3, y)) == 5)
        if(Board(x + 1, y) == 0 && Board(x + 2, y) == 0)
            moves(end + 1, :) = [x + 2, y];
        end
    end
    if(abs(Board(x, y)) == 1 && abs(Board(x - 4, y)) == 5)
        if(Board(x - 1, y) == 0 && Board(x - 2, y) == 0 && Board(x - 3, y) == 0)
            moves(end + 1, :) = [x - 2, y];
        end
    end
end
