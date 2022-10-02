% 0 not win, 1 win, -1 pat
function win = isWin(team, Board)
    advPieces = find(sign(Board) == -team);
    possibleMoves = arrayfun(@(pos) size(listMoves(pos, Board), 1), advPieces);
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