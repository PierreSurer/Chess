% compute the next move of the AI.
function [startX, startY, endX, endY, val] = computeAI(depth, team, alpha, beta, Board)
    win = isWin(-team, Board);
    if(win == 1) % checkmate
        val = -1000000;
        startX = 1;
        startY = 1;
        endX = 1;
        endY = 1;
    elseif(win == -1) % pat
        startX = 1;
        startY = 1;
        endX = 1;
        endY = 1;
        val = 0;
    elseif(depth == 0) % leaf node
        startX = 1;
        startY = 1;
        endX = 1;
        endY = 1;
        val = evaluate(team, Board);
    else % intermediate node
        [x, y] = find(sign(Board) == team);
        possibleMoves = zeros(0, 4);
        for i = 1:size(x, 1)
            moves = listMoves(x(i), y(i), Board);
            moves2 = [repmat([x(i) y(i)], size(moves, 1), 1) moves]; % add startX startY columns
            possibleMoves = cat(1, possibleMoves, moves2);
        end

        taken = abs(Board(sub2ind(size(Board), possibleMoves(:, 3), possibleMoves(:, 4))));
        taken = arrayfun(@(a) getVal(a + 1), taken);
        [~, idx] = sort(taken);
        val = -1000000000;
        for move = 1:size(possibleMoves)
            [~, nextBoard] = playMove(possibleMoves(idx(move), 1), possibleMoves(idx(move), 2), possibleMoves(idx(move), 3), possibleMoves(idx(move), 4), Board);
            [~, ~, ~, ~, tmpVal] = computeAI(depth - 1, -team, -beta, -alpha, nextBoard);
            if(-tmpVal > val)
                startX = possibleMoves(idx(move), 1);
                startY = possibleMoves(idx(move), 2);
                endX = possibleMoves(idx(move), 3);
                endY = possibleMoves(idx(move), 4);
                val = -tmpVal;
            end
            alpha = max(alpha, val);
            if(alpha >= beta)
                break;
            end
        end
    end
end

function [val] = getVal(piece)
    values = [0, 100, 16, 7, 6, 10, 1, 100, 10, 1];
    val = values(piece);
end