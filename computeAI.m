% compute the next move of the AI.
% prev contains the ancestor moves in the recursive call and can be
% initialized to zeros(0, 2).
function [startPos, endPos, val] = computeAI(depth, team, alpha, beta, prev, Board)
    if(isKingChessed(-team, Board)) % still chessed -> remove
        startPos = -1;
        endPos = -1;
        val = +1E7;
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
        [~, idx] = sort(taken, 'descend');
        val = -1E6; % 1E6 < 1E7
        for move = 1:size(possibleMoves)
            [thisStartPos, thisEndPos] = possibleMoves(idx(move));
            [nextBoard] = playMove(thisStartPos, thisEndPos, Board);
            [~, ~, tmpVal] = computeAI(depth - 1, -team, -beta, -alpha, [prev; [thisStartPos, thisEndPos]], nextBoard);
            if(-tmpVal > val)
                startPos = thisStartPos;
                endPos = thisEndPos;
                val = -tmpVal;
                if(val >= beta)
                    break;
                end
            end
            alpha = max(alpha, val);
        end
        if(val == -1E6) % pat
            startPos = -1;
            endPos = -1;
            val = evaluate(team, Board); %determine whether pat is worth it
        end
    end
end

function [val] = getVal(piece)
    values = [0, 8, 7, 5, 4, 6, 3, 8, 7, 3];
    val = values(piece);
end