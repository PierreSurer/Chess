function [startX, startY, endX, endY, val] = computeIA(depth, team, Board)
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

        if(depth == 1)
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
            val = -100000000000000;
            for move = 1:size(possibleMoves)
                [~, nextBoard] = computeMove(possibleMoves(move, 1), possibleMoves(move, 2), possibleMoves(move, 3), possibleMoves(move, 4), Board);
                [~, ~, ~, ~, tmpVal] = computeIA(depth - 1, -team, nextBoard); % TODO : reuse moves
                if(-tmpVal > val)
                    startX = possibleMoves(move, 1);
                    startY = possibleMoves(move, 2);
                    endX = possibleMoves(move, 3);
                    endY = possibleMoves(move, 4);
                    val = -tmpVal;
                end
            end

        end
    end
end