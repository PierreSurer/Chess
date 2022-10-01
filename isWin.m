% 0 not win, 1 win, -1 pat
function[win] = isWin(team, Board)
    [x, y] = find(sign(Board) == -team);
    possibleMoves = arrayfun(@(a, b) size(listMoves(a,  b, Board), 1), x, y);
    if(any(possibleMoves))
        win = 0;
    else
        if(isKingChessed(-team, Board))
            win = 1;
        else
            win = -1;
        end
    end
    
end