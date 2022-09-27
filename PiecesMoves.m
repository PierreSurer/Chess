function [possibilities] = pawnMoves(coords, Board)
    possibilities = [];
    % normal forward move
    if(Board(coords.x, coords.y + sign(Board(coords.x, coords.y))) == 0) 
        possibilities(end + 1) = {coords.x, coords.y + sign(Board(coords.x, coords.y))};
    end
    % double forward move (white)
    if(coords.y == 2 && sign(Board(coords.x, 2)) == 1) 
        if(Board(coords.x, 3) == 0 && Board(coords.x, 4) == 0)
            possibilities(end + 1) = {coords.x, 4};
        end
    end
    % double forward move (black)
    if(coords.y == 7 && sign(Board(coords.x, 2)) == -1) 
        if(Board(coords.x, 6) == 0 && Board(coords.x, 5) == 0)
            possibilities(end + 1) = {coords.x, 5};
        end
    end
    % diagonal attack moves
    if(coords.x + 1 < 9 && sign(Board(coords.x + 1, coords.y + sign(Board(coords.x, coords.y)))) ~= sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {coords.x + 1, coords.y + sign(Board(coords.x, coords.y))};
    end
    if(coords.x - 1 > 0 && sign(Board(coords.x - 1, coords.y + sign(Board(coords.x, coords.y)))) ~= sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {coords.x - 1, coords.y + sign(Board(coords.x, coords.y))};
    end
    % en passant
    if(coords.x + 1 < 9 && sign(Board(coords.x + 1, coords.y)) == -sign(Board(coords.x, coords.y)) * 9 && Board(coords.x + 1, coords.y + sign(Board(coords.x, coords.y))) == 0)
        possibilities(end + 1) = {coords.x + 1, coords.y + sign(Board(coords.x, coords.y))};
    end
    if(coords.x - 1 > 0 && sign(Board(coords.x - 1, coords.y)) == -sign(Board(coords.x, coords.y)) * 9 && Board(coords.x - 1, coords.y + sign(Board(coords.x, coords.y))) == 0)
        possibilities(end + 1) = {coords.x - 1, coords.y + sign(Board(coords.x, coords.y))};
    end
    return;
end

function [possibilities] = rookMoves(coords, Board)
    possibilities = [];
    x = coords.x - 1;
    while(x > 0 && Board(x, coords.y) == 0)
        possibilities(end + 1) = {x, coords.y};
        x = x - 1;
    end
    if(x > 0 && sign(Board(x, coords.y)) == -sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {x, coords.y};
    end

    x = coords.x + 1;
    while(x < 9 && Board(x, coords.y) == 0)
        possibilities(end + 1) = {x, coords.y};
        x = x + 1;
    end
    if(x < 9 && sign(Board(x, coords.y)) == -sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {x, coords.y};
    end

    y = coords.y - 1;
    while(y > 0 && Board(coords.x, y) == 0)
        possibilities(end + 1) = {coords.x, y};
        y = y - 1;
    end
    if(y > 0 && sign(Board(coords.x, y)) == -sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {coords.x, y};
    end

    y = coords.y + 1;
    while(y < 9 && Board(coords.x, y) == 0)
        possibilities(end + 1) = {coords.x, y};
        y = y + 1;
    end
    if(y < 9 && sign(Board(coords.x, y)) == -sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {coords.x, y};
    end
    return;
end

function [possibilities] = knightMoves(coords, Board)
    possibilities = [];
    if(coords.x + 1 < 9)
        if(coords.y - 2 > 0 && sign(Board(coords.x + 1, coords.y - 2)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x + 1, coords.y - 2};
        end
        if(coords.y + 2 < 9 && sign(Board(coords.x + 1, coords.y + 2)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x + 1, coords.y + 2};
        end
    end
    if(coords.x - 1 > 0)
        if(coords.y - 2 > 0 && sign(Board(coords.x - 1, coords.y - 2)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x - 1, coords.y - 2};
        end
        if(coords.y + 2 < 9 && sign(Board(coords.x - 1, coords.y + 2)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x - 1, coords.y + 2};
        end
    end
    if(coords.y + 1 < 9)
        if(coords.x - 2 > 0 && sign(Board(coords.x - 2, coords.y + 1)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x - 2, coords.y + 1};
        end
        if(coords.x + 2 < 9 && sign(Board(coords.x + 2, coords.y + 1)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x + 2, coords.y + 1};
        end
    end
    if(coords.y - 1 > 0)
        if(coords.x - 2 > 0 && sign(Board(coords.x - 2, coords.y - 1)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x - 2, coords.y - 1};
        end
        if(coords.x + 2 < 9 && sign(Board(coords.x + 2, coords.y - 1)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x + 2, coords.y - 1};
        end
    end
    return;
end

function [possibilities] = bishopMoves(coords, Board)
    possibilities = [];
    x = coords.x - 1;
    y = coords.y - 1;
    while(x > 0 && y > 0 && Board(x, y) == 0)
        possibilities(end + 1) = {x, y};
        x = x - 1;
        y = y - 1;
    end
    if(x > 0 && y > 0 && sign(Board(x, y)) == -sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {x, y};
    end

    x = coords.x + 1;
    y = coords.y - 1;
    while(x < 9 && y > 0 && Board(x, y) == 0)
        possibilities(end + 1) = {x, y};
        x = x + 1;
        y = y - 1;
    end
    if(x < 9 && y > 0 && sign(Board(x, y)) == -sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {x, y};
    end

    x = coords.x + 1;
    y = coords.y + 1;
    while(x < 9 && y < 9 && Board(x, y) == 0)
        possibilities(end + 1) = {x, y};
        x = x + 1;
        y = y + 1;
    end
    if(x < 9 && y < 9 && sign(Board(x, y)) == -sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {x, y};
    end

    x = coords.x - 1;
    y = coords.y + 1;
    while(x > 0 && y < 9 && Board(x, y) == 0)
        possibilities(end + 1) = {x, y};
        x = x - 1;
        y = y + 1;
    end
    if(x > 0 && y < 9 && sign(Board(x, y)) == -sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {x, y};
    end

    return;
end


function [possibilities] = kingMoves(coords, Board)
    possibilities = [];
    % normal moves
    if(coords.x + 1 < 9)
        if(Board(coords.x + 1, coords.y) == 0 || sign(Board(coords.x + 1, coords.y)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x + 1, coords.y};
        end
        if(coords.y + 1 < 9 && Board(coords.x + 1, coords.y + 1) == 0 || sign(Board(coords.x + 1, coords.y + 1)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x + 1, coords.y + 1};
        end
        if(coords.y - 1 > 0 && Board(coords.x + 1, coords.y - 1) == 0 || sign(Board(coords.x + 1, coords.y - 1)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x + 1, coords.y - 1};
        end
    end
    if(coords.x - 1 > 0)
        if(Board(coords.x - 1, coords.y) == 0 || sign(Board(coords.x - 1, coords.y)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x - 1, coords.y};
        end
        if(coords.y + 1 < 9 && Board(coords.x - 1, coords.y + 1) == 0 || sign(Board(coords.x - 1, coords.y + 1)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x - 1, coords.y + 1};
        end
        if(coords.y - 1 > 0 && Board(coords.x - 1, coords.y - 1) == 0 || sign(Board(coords.x - 1, coords.y - 1)) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x - 1, coords.y - 1};
        end
    end
    if(coords.y + 1 < 9 && Board(coords.x, coords.y + 1) == 0 || sign(Board(coords.x, coords.y + 1)) ~= sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {coords.x, coords.y + 1};
    end
    if(coords.y - 1 > 0 && Board(coords.x, coords.y - 1) == 0 || sign(Board(coords.x, coords.y - 1)) ~= sign(Board(coords.x, coords.y)))
        possibilities(end + 1) = {coords.x, coords.y - 1};
    end
    % castle
    if(abs(Board(coords.x, coords.y)) == 1 && abs(Board(coords.x + 3, coords.y)) == 5)
        if(Board(coords.x + 1, coords.y) == 0 && Board(coords.x + 2, coords.y) == 0)
            possibilities(end + 1) = {coords.x + 2, coords.y};
        end
    end
    if(abs(Board(coords.x, coords.y)) == 1 && abs(Board(coords.x - 4, coords.y)) == 5)
        if(Board(coords.x - 1, coords.y) == 0 && Board(coords.x - 2, coords.y) == 0 && Board(coords.x - 3, coords.y) == 0)
            possibilities(end + 1) = {coords.x - 2, coords.y};
        end
    end
end
