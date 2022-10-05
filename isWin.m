% 0 not win, 1 win, -1 pat
function win = isWin(team, Board)
    advPieces = find(sign(Board) == -team);
    
    % is a move playable
    for i = 1:size(advPieces)
        possibleMoves = listMoves(advPieces(i), Board);
        for j = 1:size(possibleMoves)
            TmpBoard = playMove(advPieces(i), possibleMoves(j), Board);
            if(not(isKingChessed(-team, TmpBoard)))
                win = 0;
                return;
            end
        end
    end
    
    if(isKingChessed(-team, Board))
        win = 1;
    else
        win = -1;
    end
    
end