function moves = knightMoves(x, y, Board)
    moves = zeros(0, 2, 'int8');
    if(x + 1 < 9)
        if(y - 2 > 0 && sign(Board(x + 1, y - 2)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x + 1, y - 2];
        end
        if(y + 2 < 9 && sign(Board(x + 1, y + 2)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x + 1, y + 2];
        end
    end
    if(x - 1 > 0)
        if(y - 2 > 0 && sign(Board(x - 1, y - 2)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x - 1, y - 2];
        end
        if(y + 2 < 9 && sign(Board(x - 1, y + 2)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x - 1, y + 2];
        end
    end
    if(y + 1 < 9)
        if(x - 2 > 0 && sign(Board(x - 2, y + 1)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x - 2, y + 1];
        end
        if(x + 2 < 9 && sign(Board(x + 2, y + 1)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x + 2, y + 1];
        end
    end
    if(y - 1 > 0)
        if(x - 2 > 0 && sign(Board(x - 2, y - 1)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x - 2, y - 1];
        end
        if(x + 2 < 9 && sign(Board(x + 2, y - 1)) ~= sign(Board(x, y)))
            moves(end + 1, :) = [x + 2, y - 1];
        end
    end
    return;
end