Board = createBoard();
openGame(Board)
displayBoard(Board);

team = 1; % team: 1=white, -1=black
humanPlayers = [false, true]; % white, black players are either AI or human player

while(true)
    if team == 1 && humanPlayers(1) || team == -1 && humanPlayers(2)
        fprintf('Team %s played by human\n', teamName(team));
        [startX, startY, endX, endY] = playUserMove(team, Board);
    else
        fprintf('Team %s played by AI - ', teamName(team));
        tic;
        [startX, startY, endX, endY] = playAIMove(team, Board);
        toc;
    end
  
    [~, Board] = playMove(startX, startY, endX, endY, Board);
    displayBoard(Board);

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

function [startX, startY, endX, endY] = playAIMove(team, Board)
    [startX, startY, endX, endY] = computeAI(2, team, -1E9, +1E9, Board);
end

function [startX, startY, endX, endY] = playUserMove(team, Board)
    targetPos = zeros(0, 2);

    while true
        [x, y] = userInput();

        % the user clicked on one of its pieces
        if sign(Board(x, y)) == team 
            startX = x;
            startY = y;
            targetPos = listMoves(startX, startY, Board);
            
            % update display
            displayBoard(Board);
            drawSelectedPiece(startX, startY, 45);
            for i = 1:size(targetPos, 1)
                if(Board(targetPos(i, 1), targetPos(i, 2)) == 0)
                    drawPoint(targetPos(i, 1), targetPos(i, 2), 45);
                else
                    drawTarget(targetPos(i, 1), targetPos(i, 2), 45);
                end
            end
        
        % the user clicked on a possible move
        elseif any(ismember(targetPos, [x, y], 'rows'))
            endX = x;
            endY = y;
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
    Board = zeros(8,8, 'int8');
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

function [] = displayBoard(Board)
    [im, ~, alpha] = imread('pieces.png');
    imgs = arrayfun(@(x) getPieceImage(im, x), Board, 'UniformOutput', false);
    alphas = arrayfun(@(x) getPieceImage(alpha, x), Board, 'UniformOutput', false);
    imgs = cell2mat(imgs);
    alphas = cell2mat(alphas);
    
    tile = [181 136 99; 240 217 181; 240 217 181; 181 136 99] / 255;
    tile = reshape(tile, [2, 2, 3]);
    s = size(imgs);
    checker = repmat(tile, 4);
    checker = imresize(checker, s(1) / 8, 'nearest');

    imshow(checker);
    hold on
    h = imshow(imgs);
    set(h, 'AlphaData', alphas);
    hold off
end

% draw a circle in tile (x, y). (possible moves for a selected piece)
function h = drawPoint(x, y, tileWidth)
    hold on
    x = double(x);
    y = double(y);
    theta = 0:pi/50:2*pi;
    x = (x - 0.5 + cos(theta) * 0.15) * tileWidth;
    y = (y - 0.5 + sin(theta) * 0.15) * tileWidth;
    h = fill(y, x, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
    shg
end

% draw a target in tile (x, y). (adversary pieces to take)
function h = drawTarget(x, y, tileWidth)
    hold on
    x = double(x);
    y = double(y);
    theta = 0:pi/50:2*pi;
    xVals = [x * tileWidth, x * tileWidth, (x - 1) * tileWidth, (x - 1) * tileWidth, x * tileWidth, x * tileWidth];
    yVals = [(y - 0.5) * tileWidth, (y - 1) * tileWidth, (y - 1) * tileWidth, y * tileWidth, y * tileWidth, (y - 0.5) * tileWidth];
    xVals = [xVals, (cos(theta) * 0.45 - 0.5 + x) * tileWidth];
    yVals = [yVals, (y - 0.5 + sin(theta) * 0.45) * tileWidth];
    h = fill(yVals, xVals, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
end

% draw a selection in tile (x, y). (selected piece before moving)
function h = drawSelectedPiece(x, y, tileWidth)
    hold on
    x = double(x);
    y = double(y);
    xVals = [x * tileWidth, (x - 1) * tileWidth, (x - 1) * tileWidth, x * tileWidth];
    yVals = [(y - 1) * tileWidth, (y - 1) * tileWidth, y * tileWidth, y * tileWidth];
    h = fill(yVals, xVals, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
end

% wait for the user to click on a tile and return its coordinates
function [x, y] = userInput()
    [pixX,pixY,~] = ginput(1);
    x = floor(pixY / 45) + 1;
    y = floor(pixX / 45) + 1;
    x = min(max(x, 1), 8);
    y = min(max(y, 1), 8);
end
  
