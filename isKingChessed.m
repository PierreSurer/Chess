function [result] = isKingChessed(team, Board)
    [x, y] = searchKing(team, Board);
    tmpX = x - 1;
    tmpY = y - 1;
    while(tmpX > 1 && tmpY > 1 && Board(tmpX, tmpY) == 0)
        tmpX = tmpX - 1;
        tmpY = tmpY - 1;
    end
    if(tmpX > 0 && tmpY > 0 && (Board(tmpX, tmpY) == -team * 2 || Board(tmpX, tmpY) == -team * 3))
        result = 1;
        return;
    end

    tmpX = x + 1;
    tmpY = y - 1;
    while(tmpX < 8 && tmpY > 1 && Board(tmpX, tmpY) == 0)
        tmpX = tmpX + 1;
        tmpY = tmpY - 1;
    end
    if(tmpX < 9 && tmpY > 0 && (Board(tmpX, tmpY) == -team * 2 || Board(tmpX, tmpY) == -team * 3))
        result = 1;
        return;
    end

    tmpX = x - 1;
    tmpY = y + 1;
    while(tmpX > 1 && tmpY < 8 && Board(tmpX, tmpY) == 0)
        tmpX = tmpX - 1;
        tmpY = tmpY + 1;
    end
    if(tmpX > 0 && tmpY < 9 && (Board(tmpX, tmpY) == -team * 2 || Board(tmpX, tmpY) == -team * 3))
        result = 1;
        return;
    end

    tmpX = x + 1;
    tmpY = y + 1;
    while(tmpX < 8 && tmpY < 8 && Board(tmpX, tmpY) == 0)
        tmpX = tmpX + 1;
        tmpY = tmpY + 1;
    end
    if(tmpX < 9 && tmpY < 9 && (Board(tmpX, tmpY) == -team * 2 || Board(tmpX, tmpY) == -team * 3))
        result = 1;
        return;
    end
    
    tmpX = x - 1;
    while(tmpX > 1 && Board(tmpX, y) == 0)
        tmpX = tmpX - 1;
    end
    if(tmpX > 0 && (Board(tmpX, y) == -team * 2 || Board(tmpX, y) == -team * 5 || Board(tmpX, y) == -team * 8))
        result = 1;
        return;
    end

    tmpX = x + 1;
    while(tmpX < 8 && Board(tmpX, y) == 0)
        tmpX = tmpX + 1;
    end
    if(tmpX < 9 && (Board(tmpX, y) == -team * 2 || Board(tmpX, y) == -team * 5 || Board(tmpX, y) == -team * 8))
        result = 1;
        return;
    end

    tmpY = y + 1;
    while(tmpY < 8 && Board(x, tmpY) == 0)
        tmpY = tmpY + 1;
    end
    if(tmpY < 9 && (Board(x, tmpY) == -team * 2 || Board(x, tmpY) == -team * 5 || Board(x, tmpY) == -team * 8))
        result = 1;
        return;
    end

    tmpY = y - 1;
    while(tmpY > 1 && Board(x, tmpY) == 0)
        tmpY = tmpY - 1;
    end
    if(tmpY > 0 && (Board(x, tmpY) == -team * 2 || Board(x, tmpY) == -team * 5 || Board(x, tmpY) == -team * 8))
        result = 1;
        return;
    end
    
    
    if(y + team < 9 && y + team > 0)
        if(x + 1 < 9 && (Board(x + 1, y + team) == -team * 6 || Board(x + 1, y + team) == -team * 9))
            result = 1;
            return;
        end
        if(x - 1 > 0 && (Board(x - 1, y + team) == -team * 6 || Board(x - 1, y + team) == -team * 9))
            result = 1;
            return;
        end
    end

    % knight + king
    tmpX = x + 1;
    if(tmpX < 9)
        tmpY = y - 2;
        if(tmpY > 0 && Board(tmpX, tmpY) == -team * 4)
            result = 1;
            return;
        end
        tmpY = y + 2;
        if(tmpY < 9 && Board(tmpX, tmpY) == -team * 4)
            result = 1;
            return;
        end
        tmpY = y - 1;
        if(tmpY > 0 && (Board(tmpX, tmpY) == -team * 1 || Board(tmpX, tmpY) == -team * 7))
            result = 1;
            return;
        end
        if(Board(tmpX, y) == -team * 1 || Board(tmpX, y) == -team * 7)
            result = 1;
            return;
        end
        tmpY = y + 1;
        if(tmpY < 9 && (Board(tmpX, tmpY) == -team * 1 || Board(tmpX, tmpY) == -team * 7))
            result = 1;
            return;
        end
    end
    tmpX = x - 1;
    if(tmpX > 0)
        tmpY = y - 2;
        if(tmpY > 0 && Board(tmpX, tmpY) == -team * 4)
            result = 1;
            return;
        end
        tmpY = y + 2;
        if(tmpY < 9 && Board(tmpX, tmpY) == -team * 4)
            result = 1;
            return;
        end
        tmpY = y - 1;
        if(tmpY > 0 && (Board(tmpX, tmpY) == -team * 1 || Board(tmpX, tmpY) == -team * 7))
            result = 1;
            return;
        end
        if(Board(tmpX, y) == -team * 1 || Board(tmpX, y) == -team * 7)
            result = 1;
            return;
        end
        tmpY = y + 1;
        if(tmpY < 9 && (Board(tmpX, tmpY) == -team * 1 || Board(tmpX, tmpY) == -team * 7))
            result = 1;
            return;
        end
    end
    tmpY = y + 1;
    if(tmpY < 9)
        tmpX = x - 2;
        if(tmpX > 0 && Board(tmpX, tmpY) == -team * 4)
            result = 1;
            return;
        end
        tmpX = x + 2;
        if(tmpX < 9 && Board(tmpX, tmpY) == -team * 4)
            result = 1;
            return;
        end
        if(Board(x, tmpY) == -team * 1 || Board(x, tmpY) == -team * 7)
            result = 1;
            return;
        end
    end
    tmpY = y - 1;
    if(tmpY > 0)
        tmpX = x - 2;
        if(tmpX > 0 && Board(tmpX, tmpY) == -team * 4)
            result = 1;
            return;
        end
        tmpX = x + 2;
        if(tmpX < 9 && Board(tmpX, tmpY) == -team * 4)
            result = 1;
            return;
        end
        if(Board(x, tmpY) == -team * 1 || Board(x, tmpY) == -team * 7)
            result = 1;
            return;
        end
    end
    result = 0;
end

function [x, y] = searchKing(team, Board)
    if(team == 1)
        if(Board(5, 1) == team * 1)
            x = 5;
            y = 1;
        else
            [x, y] = find(Board == team * 7);
        end
    else
        if(Board(5, 8) == team * 1)
            x = 5;
            y = 8;
        else
            [x, y] = find(Board == team * 7);
        end
    end
end