function [possibilities] = pawnMoves(x, y, Board)
    possibilities = [];
    % normal forward move
    if(Board(x, y + sign(Board(x, y))) == 0) 
        possibilities(end + 1, :) = [x, y + sign(Board(x, y))];
    end
    % double forward move (white)
    if(y == 2 && sign(Board(x, 2)) == 1) 
        if(Board(x, 3) == 0 && Board(x, 4) == 0)
            possibilities(end + 1, :) = [x, 4];
        end
    end
    % double forward move (black)
    if(y == 7 && sign(Board(x, 7)) == -1) 
        if(Board(x, 6) == 0 && Board(x, 5) == 0)
            possibilities(end + 1, :) = [x, 5];
        end
    end
    % diagonal attack moves
    if(x + 1 < 9 && sign(Board(x + 1, y + sign(Board(x, y)))) == -sign(Board(x, y)))
        possibilities(end + 1, :) = [x + 1, y + sign(Board(x, y))];
    end
    if(x - 1 > 0 && sign(Board(x - 1, y + sign(Board(x, y)))) == -sign(Board(x, y)))
        possibilities(end + 1, :) = [x - 1, y + sign(Board(x, y))];
    end
    % en passant
    if(x + 1 < 9 && Board(x + 1, y) == -sign(Board(x, y)) * 9 && Board(x + 1, y + sign(Board(x, y))) == 0)
        possibilities(end + 1, :) = [x + 1, y + sign(Board(x, y))];
    end
    if(x - 1 > 0 && Board(x - 1, y) == -sign(Board(x, y)) * 9 && Board(x - 1, y + sign(Board(x, y))) == 0)
        possibilities(end + 1, :) = [x - 1, y + sign(Board(x, y))];
    end
    return;
end