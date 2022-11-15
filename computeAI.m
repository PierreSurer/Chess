% compute the next move of the AI.
function [startPos, endPos, val] = computeAI(depth, team, alpha, beta, Board)
    hasDictionnary = false; % enable if matlab version supports dictionnaries
    if(isKingChessed(-team, Board)) % still chessed -> forbidden move
        startPos = -1;
        endPos = -1;
        val = (depth + 1) * 1E5; % reward more if mat quickly
        return;
    end

    % https://en.wikipedia.org/wiki/Negamax
    alphaOrig = alpha;

    % first, check if this path was already explored in a recursive call.
    memo = Memoize;
    if hasDictionnary && memo.contains({team, Board})
        [startPos, endPos, val, dictDepth, flag] = memo.lookup({team, Board});
        if dictDepth >= depth % Check if dictionnary is useful
            if flag == 0
                return;
            elseif flag == -1
                alpha = max(alpha, val);
            elseif flag == 1
                beta = min(beta, val);
            end
        end
        if alpha >= beta
            return;
        end
       
    elseif(depth == 0) % leaf node
        startPos = -2;
        endPos = -2;
        val = evaluate(team, Board);

    else % intermediate node
        % get list of possible moves
        pieces = find(sign(Board) == team);
        possibleMoves = zeros(0, 2); % pairs of startPos, endPos
        for i = 1:size(pieces, 1)
            moves = listMoves(pieces(i), Board);
            moves2 = [repmat(pieces(i), size(moves, 1), 1) moves]; % add startPos column
            possibleMoves = cat(1, possibleMoves, moves2);
        end

        % shuffle possibleMoves to allow variations in case of equal values
        possibleMoves = possibleMoves(randperm(size(possibleMoves, 1)), :);
        
        % explore the nodes in order of pieces taken
        taken = getPieceVal(abs(Board(possibleMoves(:, 2))));
        [~, idx] = sort(taken, 'descend');

        val = -depth * 1E6;
        for move = 1:size(possibleMoves)
            thisStartPos = possibleMoves(idx(move), 1);
            thisEndPos = possibleMoves(idx(move), 2);
            [nextBoard] = playMove(thisStartPos, thisEndPos, Board);
            [~, ~, thisVal] = computeAI(depth - 1, -team, -beta, -alpha, nextBoard);
            if(-thisVal > val)
                startPos = thisStartPos;
                endPos = thisEndPos;
                val = -thisVal;
                if(val >= beta) % alpha/beta pruning
                    break;
                end
            end
            alpha = max(alpha, val);
        end
        
        if val == -depth * 1E5 % pat: best next move is chess, or no next move
            if(isKingChessed(team, Board))
                startPos = -3;
                endPos = -3;
            else
                startPos = -4;
                endPos = -4;
                val = evaluate(team, Board);
            end
            % memoize this board result
        elseif hasDictionnary && depth > 2
            if val <= alphaOrig
                flag = 1;
            elseif val >= beta
                flag = -1;
            else
                flag = 0;
            end
            memo.insert({team, Board}, [startPos, endPos, val, depth, flag]);
        end
    end
    
end

function [val] = getPieceVal(piece)
    values = [0, 8, 7, 5, 4, 6, 3, 8, 7, 3];
    val = values(piece + 1);
end