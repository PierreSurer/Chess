% compute the next move of the AI.
function [startPos, endPos, val] = computeAI(depth, team, alpha, beta, Board)
    win = isWin(-team, Board);
    if(win == 1) % checkmate
        val = -1000000;
        startPos = -1;
        endPos = -1;
    elseif(win == -1) % pat
        startPos = -1;
        endPos = -1;
        val = 0;
    elseif(depth == 0) % leaf node
        startPos = -1;
        endPos = -1;
        val = evaluate(team, Board);
    else % intermediate node
        pieces = find(sign(Board) == team);
        possibleMoves = zeros(0, 2); % pairs of startPos, endPos
        for i = 1:size(pieces, 1)
            moves = listMoves(pieces(i), Board);
            moves2 = [repmat(pieces(i), size(moves, 1), 1) moves]; % add startPos column
            possibleMoves = cat(1, possibleMoves, moves2);
        end

        taken = abs(Board(possibleMoves(:, 2)));
        taken = arrayfun(@(a) getVal(a + 1), taken);
        [~, idx] = sort(taken);
        val = -1000000000;
        for move = 1:size(possibleMoves)
            [~, nextBoard] = playMove(possibleMoves(idx(move), 1), possibleMoves(idx(move), 2), Board);
            [~, ~, tmpVal] = computeAI(depth - 1, -team, -beta, -alpha, nextBoard);
            if(-tmpVal > val)
                startPos = possibleMoves(idx(move), 1);
                endPos = possibleMoves(idx(move), 2);
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