function [possibilities] = bishopMoves(x, y, Board)
    possibilities = [];
    tmpX = x - 1;
    tmpY = y - 1;
    while(tmpX > 0 && tmpY > 0 && Board(tmpX, tmpY) == 0)
        possibilities(end + 1, :) = [tmpX, tmpY];
        tmpX = tmpX - 1;
        tmpY = tmpY - 1;
    end
    if(tmpX > 0 && tmpY > 0 && sign(Board(tmpX, tmpY)) == -sign(Board(x, y)))
        possibilities(end + 1, :) = [tmpX, tmpY];
    end

    tmpX = x + 1;
    tmpY = y - 1;
    while(tmpX < 9 && tmpY > 0 && Board(tmpX, tmpY) == 0)
        possibilities(end + 1, :) = [tmpX, tmpY];
        tmpX = tmpX + 1;
        tmpY = tmpY - 1;
    end
    if(tmpX < 9 && tmpY > 0 && sign(Board(tmpX, tmpY)) == -sign(Board(x, y)))
        possibilities(end + 1, :) = [tmpX, tmpY];
    end

    tmpX = x + 1;
    tmpY = y + 1;
    while(tmpX < 9 && tmpY < 9 && Board(tmpX, tmpY) == 0)
        possibilities(end + 1, :) = [tmpX, tmpY];
        tmpX = tmpX + 1;
        tmpY = tmpY + 1;
    end
    if(tmpX < 9 && tmpY < 9 && sign(Board(tmpX, tmpY)) == -sign(Board(x, y)))
        possibilities(end + 1, :) = [tmpX, tmpY];
    end

    tmpX = x - 1;
    tmpY = y + 1;
    while(tmpX > 0 && tmpY < 9 && Board(tmpX, tmpY) == 0)
        possibilities(end + 1, :) = [tmpX, tmpY];
        tmpX = tmpX - 1;
        tmpY = tmpY + 1;
    end
    if(tmpX > 0 && tmpY < 9 && sign(Board(tmpX, tmpY)) == -sign(Board(x, y)))
        possibilities(end + 1, :) = [tmpX, tmpY];
    end

    return;
end