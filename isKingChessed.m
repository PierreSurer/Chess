function [result] = isKingChessed(x, y, Board)
    tmpX = x - 1;
    tmpY = y - 1;
    while(tmpX > 1 && tmpY > 1 && Board(tmpX, tmpY) == 0)
        tmpX = tmpX - 1;
        tmpY = tmpY - 1;
    end
    if(tmpX > 0 && tmpY > 0 && (Board(tmpX, tmpY) == -sign(Board(x, y)) * 2 || Board(tmpX, tmpY) == -sign(Board(x, y)) * 3))
        result = 1;
        return;
    end

    tmpX = x + 1;
    tmpY = y - 1;
    while(tmpX < 8 && tmpY > 1 && Board(tmpX, tmpY) == 0)
        tmpX = tmpX + 1;
        tmpY = tmpY - 1;
    end
    if(tmpX < 9 && tmpY > 0 && (Board(tmpX, tmpY) == -sign(Board(x, y)) * 2 || Board(tmpX, tmpY) == -sign(Board(x, y)) * 3))
        result = 1;
        return;
    end

    tmpX = x - 1;
    tmpY = y + 1;
    while(tmpX > 1 && tmpY < 8 && Board(tmpX, tmpY) == 0)
        tmpX = tmpX - 1;
        tmpY = tmpY + 1;
    end
    if(tmpX > 0 && tmpY < 9 && (Board(tmpX, tmpY) == -sign(Board(x, y)) * 2 || Board(tmpX, tmpY) == -sign(Board(x, y)) * 3))
        result = 1;
        return;
    end

    tmpX = x + 1;
    tmpY = y + 1;
    while(tmpX < 8 && tmpY < 8 && Board(tmpX, tmpY) == 0)
        tmpX = tmpX + 1;
        tmpY = tmpY + 1;
    end
    if(tmpX < 9 && tmpY < 9 && (Board(tmpX, tmpY) == -sign(Board(x, y)) * 2 || Board(tmpX, tmpY) == -sign(Board(x, y)) * 3))
        result = 1;
        return;
    end
    
    tmpX = x - 1;
    while(tmpX > 1 && Board(tmpX, y) == 0)
        tmpX = tmpX - 1;
    end
    if(tmpX > 0 && (Board(tmpX, y) == -sign(Board(x, y)) * 2 || Board(tmpX, y) == -sign(Board(x, y)) * 5 || Board(tmpX, y) == -sign(Board(x, y)) * 8))
        result = 1;
        return;
    end

    tmpX = x + 1;
    while(tmpX < 8 && Board(tmpX, y) == 0)
        tmpX = tmpX + 1;
    end
    if(tmpX < 9 && (Board(tmpX, y) == -sign(Board(x, y)) * 2 || Board(tmpX, y) == -sign(Board(x, y)) * 5 || Board(tmpX, y) == -sign(Board(x, y)) * 8))
        result = 1;
        return;
    end

    tmpY = y + 1;
    while(tmpY < 8 && Board(x, tmpY) == 0)
        tmpY = tmpY + 1;
    end
    if(tmpY < 9 && (Board(x, tmpY) == -sign(Board(x, y)) * 2 || Board(x, tmpY) == -sign(Board(x, y)) * 5 || Board(x, tmpY) == -sign(Board(x, y)) * 8))
        result = 1;
        return;
    end

    tmpY = y - 1;
    while(tmpY > 1 && Board(x, tmpY) == 0)
        tmpY = tmpY - 1;
    end
    if(tmpY > 0 && (Board(x, tmpY) == -sign(Board(x, y)) * 2 || Board(x, tmpY) == -sign(Board(x, y)) * 5 || Board(x, tmpY) == -sign(Board(x, y)) * 8))
        result = 1;
        return;
    end
    
    
    if(y + sign(Board(x, y)) < 9 && y + sign(Board(x, y)) > 0)
        if(x + 1 < 9 && (Board(x + 1, y + sign(Board(x, y))) == -sign(Board(x, y)) * 6 || Board(x + 1, y + sign(Board(x, y))) == -sign(Board(x, y)) * 9))
            result = 1;
            return;
        end
        if(x - 1 > 0 && (Board(x - 1, y + sign(Board(x, y))) == -sign(Board(x, y)) * 6 || Board(x - 1, y + sign(Board(x, y))) == -sign(Board(x, y)) * 9))
            result = 1;
            return;
        end
    end

    knightpos = knightMoves(x, y, Board);
    if(size(knightpos) > 0)
        if(any(Board(sub2ind(size(Board), knightpos(:,1), knightpos(:,2))) == -sign(Board(x, y)) * 4))
            result = 1;
            return;
        end
    end

    kingpos = kingMoves(x, y, Board);
    if(size(kingpos) > 0)
        if(any(Board(sub2ind(size(Board), kingpos(:,1), kingpos(:,2))) == -sign(Board(x, y)) * 1 | Board(sub2ind(size(Board), kingpos(:,1), kingpos(:,2))) == -sign(Board(x, y)) * 7))
            result = 1;
            return;
        end
    end

    result = 0;
    return;

end