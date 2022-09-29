function [startX, startY, endX, endY, val] = computeIA(depth, team, alpha, beta, Board)
    win = isWin(-team, Board);
    if(win == 1)
        val = -1000000;
        startX = 1;
        startY = 1;
        endX = 1;
        endY = 1;
    elseif(win == -1)
        startX = 1;
        startY = 1;
        endX = 1;
        endY = 1;
        val = 0;
    else

        if(depth == 0)
            startX = 1;
            startY = 1;
            endX = 1;
            endY = 1;
            val = evaluate(team, Board);
        else
            [x, y] = find(sign(Board) == team); 
            possibleMoves = [];
            for i = 1:size(x)
                pos = getPositions(x(i, 1),  y(i, 1), Board);
                for j = 1:size(pos,1)
                    possibleMoves(end + 1, :) = [x(i, 1), y(i, 1), pos(j, 1), pos(j, 2)];
                end
            end
            taken = abs(Board(sub2ind(size(Board), possibleMoves(:, 4),possibleMoves(:, 4))));
            taken = arrayfun(@(a) getVal(a + 1), taken);
            [~, idx] = sort(taken);
            val = -1000000000;
            for move = 1:size(possibleMoves)
                [~, nextBoard] = computeMove(possibleMoves(idx(move), 1), possibleMoves(idx(move), 2), possibleMoves(idx(move), 3), possibleMoves(idx(move), 4), Board);
                [~, ~, ~, ~, tmpVal] = computeIA(depth - 1, -team, -beta, -alpha, nextBoard); % TODO : reuse moves
                if(-tmpVal > val)
                    startX = possibleMoves(idx(move), 1);
                    startY = possibleMoves(idx(move), 2);
                    endX = possibleMoves(idx(move), 3);
                    endY = possibleMoves(idx(move), 4);
                    val = -tmpVal;
                end
                alpha = max(alpha, val);
                if(alpha >= beta)
                    return;
                end
            end

        end
    end
end

function [val] = getVal(val)
    values = [0, 100, 16, 7, 6, 10, 1, 100, 10, 1];
    val = values(val);

end