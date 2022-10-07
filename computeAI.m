% compute the next move of the AI.
function [startPos, endPos, val] = computeAI(depth, team, alpha, beta, Board)
    % first, check if this path was already explored in a recursive call.
    memo = Memoize;
    if depth > 2 && memo.contains(Board)
        [startPos, endPos, val] = memo.lookup(Board);
        return;

    elseif(isKingChessed(-team, Board)) % still chessed -> remove
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
            thisStartPos = possibleMoves(idx(move), 1);
            thisEndPos = possibleMoves(idx(move), 2);
            [nextBoard] = playMove(thisStartPos, thisEndPos, Board);
            [~, ~, tmpVal] = computeAI(depth - 1, -team, -beta, -alpha, nextBoard);
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
            val = evaluate(team, Board); % determine whether pat is worth it
        end
    end
    
    % memoize this board result
    if depth > 2
        memo.insert(Board, [startPos, endPos, val]);
    end
end

function [val] = getVal(piece)
    values = [0, 8, 7, 5, 4, 6, 3, 8, 7, 3];
    val = values(piece);
end