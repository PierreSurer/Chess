function [success, startPos, endPos] = computeOpening(Board, previousMoves)
    persistent T;
    if isempty(T)
        opts = detectImportOptions('high_elo_opening.csv');
        for i = 1:8
            opts = setvartype(opts, {moveName(i)}, 'string');
        end
        T = readtable('high_elo_opening.csv', opts);
    end
    
    table = T;

    startPos = -1;
    endPos = -1;
    success = true;

    % filter table by previousMoves
    for i = 1:size(previousMoves, 1)
        move = moveName(i);
        prev = previousMoves(i, :);
        table = table(table.(move) == prev, :);
    end

    if size(table, 1) == 0
        success = false;
        return;
    end
    
    move = moveName(size(previousMoves, 1) + 1);
    team = 1 - mod(size(previousMoves, 1), 2) * 2;

    % remove rows without the next move
    table = rmmissing(table, 'DataVariables', move);
    if isempty(table)
        success = false;
        return;
    end

    moveScores = groupsummary(table, move, 'sum', 'num_games');
    scores = moveScores.sum_num_games(:,1);
    scores = scores / max(scores);
    idx = randsample(1:height(scores), 1, true, scores);

    best = moveScores(idx, 1);
    best = char(best{1, move});
    [startPos, endPos] = algebraic.parse(best, team, Board);
end


function name = moveName(n)
    turn = ceil(n / 2);
    color = 'wb';
    color = color(mod(n - 1, 2) + 1); % w or b
    name = sprintf('move%d%s', turn, color); % move1w, move1b, move2w, ...
end
