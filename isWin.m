% 0 not win, 1 win, -1 pat
function[win] = isWin(team, Board)
    [x, y] = find(sign(Board) == -team);
    possibleMoves = cell2mat(arrayfun(@(a, b) size(getPositions(a,  b, Board), 1), x, y,'uniformoutput',false));
    if(any(possibleMoves))
        win = 0;
    else
        [x, y] = searchKing(-team, Board);
        if(isKingChessed(x, y, Board))
            win = 1;
        else
            win = -1;
        end
    end
    
end

function [x, y] = searchKing(team, Board)
    [x,y] = find(Board == team * 1 | Board == team * 7);
end