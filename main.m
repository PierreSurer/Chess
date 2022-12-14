HeatMap; %init heatmap

Board = createBoard();
displayBoard(Board, 1);
previousMoves = cell(0);

team = 1; % team: 1=white, -1=black
humanPlayers = [true, false]; % white, black players are either AI or human player
depth = 5; % AI search depth (number of moves)
rng('shuffle'); % seed for the rng: comment for non-predictible outputs

while(true)
    if team == 1 && humanPlayers(1) || team == -1 && humanPlayers(2) % choose the display side
        fprintf('Team %s played by human - ', teamName(team));
        [startPos, endPos] = playUserMove(team, Board);
        fprintf('%s\n', algebraic.stringify(startPos, endPos, team, Board));
    else
        fprintf('Team %s played by AI ', teamName(team));
        [startPos, endPos] = playAIMove(depth, previousMoves, team, Board);
    end
    previousMoves(end + 1, :) = { algebraic.stringify(startPos, endPos, team, Board) };

    Board = playMove(startPos, endPos, Board);
    if(team == 1 && humanPlayers(2) || not(humanPlayers(1)) && humanPlayers(2))
        displayBoard(Board, -1);
    else
        displayBoard(Board, 1);
    end

    win = isWin(team, Board);
    if(win == 1)
        fprintf('%s wins !\n', teamName(team));
        break;
    elseif(win == -1)
        fprintf('pat\n');
        break;
    else
        team = -team;
    end
end

function [startPos, endPos] = playAIMove(depth, previousMoves, team, Board)
    persistent lastTimeElapsed; % stores timings across functions call
    persistent newDepth; % stores depth across calls
    % reset memoization of board values
    memo = Memoize;
    memo.reset;
    
    if size(previousMoves, 1) < 8
        tStart = tic;
        [success, startPos, endPos] = computeOpening(Board, previousMoves);
        tEnd = toc(tStart);
        if ~success % Opening in dataset
            fprintf('depth %d - ', depth);
            tStart = tic;
            [startPos, endPos] = computeAI(depth, team, -1E8, +1E8, Board);
            tEnd = toc(tStart);
            lastTimeElapsed(end + 1, :) = tEnd;
            fprintf('%s - ', algebraic.stringify(startPos, endPos, team, Board));
            fprintf('Played in %f s\n', tEnd);
        else
            fprintf('depth 0 - %s - ', algebraic.stringify(startPos, endPos, team, Board));
            fprintf('Played in %f s\n', tEnd);
            lastTimeElapsed = [];
            newDepth = depth;
        end
    else
        if(size(lastTimeElapsed, 1) >= 3)
            val = sum(lastTimeElapsed(end-2:end)); % sum of last 3 moves
            if val < 20.0
                newDepth = newDepth + 1;
            elseif val > 250.0 
                newDepth = newDepth - 1;
                lastTimeElapsed = lastTimeElapsed(end-1:end);
            end
        end
        fprintf('depth %d - ', max(depth, newDepth));
        tStart = tic;
        [startPos, endPos] = computeAI(max(depth, newDepth), team, -1E8, +1E8, Board);
        tEnd = toc(tStart);
        lastTimeElapsed(end + 1, :) = tEnd;
        fprintf('%s - ', algebraic.stringify(startPos, endPos, team, Board));
        fprintf('Played in %f s\n', tEnd);
    end
    % reset memoization of board values
    memo = Memoize;
    memo.reset;

    if startPos < 0 || endPos < 0
        disp([startPos, endPos]);
        throw("unexpected error");
    end
end

function [startPos, endPos] = playUserMove(team, Board)
    targetPos = zeros(0, 1);

    while true
        pos = userInput(team);

        % the user clicked on one of its pieces
        if sign(Board(pos)) == team
            startPos = pos;
            targetPos = listMoves(startPos, Board);
            % only keep moves which are playable
            moveSuccess = zeros(size(targetPos, 1), 1, 'logical');
            for i = 1:size(targetPos)
                TmpBoard = playMove(pos, targetPos(i), Board);
                moveSuccess(i) = not(isKingChessed(team, TmpBoard)); 
            end
            targetPos = targetPos(moveSuccess, :);
            
            % update display
            displayBoard(Board, team);
            drawSelectedPiece(pos, 45, team);
            for i = 1:size(targetPos, 1)
                if(Board(targetPos(i)) == 0)
                    drawPoint(targetPos(i), 45, team);
                else
                    drawTarget(targetPos(i), 45, team);
                end
            end
        
        % the user clicked on a possible move
        elseif any(targetPos == pos)
            endPos = pos;
            return;
        end
    end
end

function name = teamName(team)
    if team == 1
        name = 'white';
    else
        name = 'black';
    end
end

function [Board] = createBoard()
    Board = zeros(8, 8, 'int8');
    % 1 : king
    % 2 : queen
    % 3 : bishop
    % 4 : knight
    % 5 : rook
    % 6 : pawn
    % 7 : moved_king
    % 8 : moved_rook
    % 9 : pawn_en_passant

    for i = 1:8
        Board(i,2) = 6;
        Board(i,7) = -6;
    end
    
    Board(1,1) = 5;
    Board(8,1) = 5;
    Board(1,8) = -5;
    Board(8,8) = -5;
    
    Board(2,1) = 4;
    Board(7,1) = 4;
    Board(2,8) = -4;
    Board(7,8) = -4;
    
    Board(3,1) = 3;
    Board(6,1) = 3;
    Board(3,8) = -3;
    Board(6,8) = -3;
    
    Board(4,1) = 2;
    Board(5,1) = 1;
    Board(4,8) = -2;
    Board(5,8) = -1;

end

function im = getPieceImage(im, index)
    [h, w] = size(im);
    w = w / 6;
    h = h / 2;

    if index == 0
        im = zeros(w, h, 'uint8');
        return;
    end

    lookup = [0, 1, 2, 3, 4, 5, 0, 4, 5];
    x = w * lookup(abs(index));
    y = h * (index < 0);

    im = im(1+y:y+h, 1+x:x+w);
end

function [] = displayBoard(Board, side)
    Board = Board.';
    if(side == 1) % flip display side
        Board = flip(Board, 1);
    else
        Board = flip(Board, 2);
    end
    [im, ~, alpha] = imread('pieces.png');
    imgs = arrayfun(@(x) getPieceImage(im, x), Board, 'UniformOutput', false);
    alphas = arrayfun(@(x) getPieceImage(alpha, x), Board, 'UniformOutput', false);
    imgs = cell2mat(imgs);
    alphas = cell2mat(alphas);
    
    tile = [240 217 181; 181 136 99; 181 136 99; 240 217 181] / 255;
    tile = reshape(tile, [2, 2, 3]);
    s = size(imgs);
    checker = repmat(tile, 4);
    checker = imresize(checker, s(1) / 8, 'nearest');
    imshow(checker);

    % coordinates display
    txt = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    colors = [240 217 181; 181 136 99] / 255;
    for i = 1:8
        if(side == 1)
            text((8 - 0.03) * s(1) / 8, (i - 1.03) * s(1) / 8, string(9 - i), 'Color', colors(1 + mod(i + 1,2), :), 'FontSize', s(1) / 50 ,'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
            text((i - 0.97) * s(1) / 8, (8 - 0.03) * s(1) / 8, txt(i), 'Color', colors(1 + mod(i + 1,2), :), 'FontSize', s(1) / 50 , 'VerticalAlignment', 'baseline', 'HorizontalAlignment', 'left');
        else
            text((8 - 0.03) * s(1) / 8, (i - 1.03) * s(1) / 8, string(i), 'Color', colors(1 + mod(i + 1,2), :), 'FontSize', s(1) / 50 ,'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
            text((i - 0.97) * s(1) / 8, (8 - 0.03) * s(1) / 8, txt(9 - i), 'Color', colors(1 + mod(i + 1,2), :), 'FontSize', s(1) / 50 , 'VerticalAlignment', 'baseline', 'HorizontalAlignment', 'left');
        end
        
    end

    hold on
    h = imshow(imgs);
    set(h, 'AlphaData', alphas);
    hold off
    shg
end

% draw a circle at pos. (possible moves for a selected piece)
function h = drawPoint(pos, tileWidth, side)
    hold on
    [x, y] = ind2sub([8 8], pos);
    if(side == 1)
        y = 9 - y;
    else
        x = 9 - x;
    end
    theta = 0:pi/50:2*pi;
    x = (x - 0.5 + cos(theta) * 0.15) * tileWidth;
    y = (y - 0.5 + sin(theta) * 0.15) * tileWidth;
    h = fill(x, y, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
end

% draw a target at pos. (adversary pieces to take)
function h = drawTarget(pos, tileWidth, side)
    hold on
    [x, y] = ind2sub([8 8], pos);
    if(side == 1)
        y = 9 - y;
    else
        x = 9 - x;
    end
    theta = 0:pi/50:2*pi;
    xVals = [x * tileWidth, x * tileWidth, (x - 1) * tileWidth, (x - 1) * tileWidth, x * tileWidth, x * tileWidth];
    yVals = [(y - 0.5) * tileWidth, (y - 1) * tileWidth, (y - 1) * tileWidth, y * tileWidth, y * tileWidth, (y - 0.5) * tileWidth];
    xVals = [xVals, (cos(theta) * 0.45 - 0.5 + x) * tileWidth];
    yVals = [yVals, (y - 0.5 + sin(theta) * 0.45) * tileWidth];
    h = fill(xVals, yVals, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
end

% draw a selection at pos. (selected piece before moving)
function h = drawSelectedPiece(pos, tileWidth, side)
    hold on
    [x, y] = ind2sub([8 8], pos);
    if(side == 1)
        y = 9 - y;
    else
        x = 9 - x;
    end
    xVals = [x * tileWidth, (x - 1) * tileWidth, (x - 1) * tileWidth, x * tileWidth];
    yVals = [(y - 1) * tileWidth, (y - 1) * tileWidth, y * tileWidth, y * tileWidth];
    h = fill(xVals, yVals, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
end

% wait for the user to click on a tile and return its coordinates
function pos = userInput(side)
    [pixY,pixX,~] = ginput(1);
    x = floor(pixY / 45) + 1;
    y = floor(pixX / 45) + 1;
    x = min(max(x, 1), 8);
    y = min(max(y, 1), 8);
    if(side == 1)
        y = 9 - y;
    else
        x = 9 - x;
    end
    pos = mysub2ind(x, y);
end
  
