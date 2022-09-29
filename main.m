Board = createBoard();
openGame(Board)
displayBoard(Board);
shg
lastX = 0;
lastY = 0;
x = 4;
y = 4;
team = 1;
while(true)
    pos = [];
    success = false;
    while(not(success))
        if(team == 0)
            [x, y] = userInput();
        else
            tic;
            [a, b, c, d, val] = computeIA(5, team, -1000000000, 1000000000, Board);
            toc;
            lastX = a;
            lastY = b;
            x = c;
            y = d;
            pos = [[c, d]];
        end
        if(not(isempty(pos)) && any(ismember(pos, [x, y], 'rows')))
            [success, Board] = computeMove(lastX, lastY, x, y, Board);
        else
            pos = getPositions(x, y, Board);
            if(sign(Board(x, y)) ~= team)
                pos = [];
            end
            lastX = x;
            lastY = y;
        end
        displayBoard(Board);
        if(size(pos) > 0)
            selectPawn(x, y, 45);
        end
        for i = 1:size(pos, 1)
            if(Board(pos(i, 1), pos(i, 2)) == 0)
                drawPoint(pos(i, 1), pos(i, 2), 45);
            else
                drawTarget(pos(i, 1), pos(i, 2), 45);
            end
        end
    
    end
    displayBoard(Board);
    shg
    win = isWin(team, Board);
    if(win == 1)
        if(team == 1)
            fprintf('white wins !\n');
        else
            fprintf('black wins !\n');
        end
        break;
    elseif(win == -1)
        fprintf('pat\n');
        break;
    else
        team = -team;
    end
    
end

function [Board] = createBoard()
    Board = zeros(8,8);
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

    lookup = containers.Map({
        1, 2, 3, 4, 5, 6, 7, 8, 9
    }, {
        0, 1, 2, 3, 4, 5, 0, 4, 5
    });

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

% draw a circle in tile (x, y).
function [] = drawPoint(x, y, tileWidth)
    hold on
    theta = 0:pi/50:2*pi;
    x = (x - 0.5 + cos(theta) * 0.15) * tileWidth;
    y = (y - 0.5 + sin(theta) * 0.15) * tileWidth;
    h = fill(y, x, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
end

% draw a target in tile (x, y).
function [] = drawTarget(x, y, tileWidth)
    hold on
    theta = 0:pi/50:2*pi;
    xVals = [x * tileWidth, x * tileWidth, (x - 1) * tileWidth, (x - 1) * tileWidth, x * tileWidth, x * tileWidth];
    yVals = [(y - 0.5) * tileWidth, (y - 1) * tileWidth, (y - 1) * tileWidth, y * tileWidth, y * tileWidth, (y - 0.5) * tileWidth];
    xVals = [xVals, (x - 0.5 + cos(theta) * 0.45) * tileWidth];
    yVals = [yVals, (y - 0.5 + sin(theta) * 0.45) * tileWidth];
    h = fill(yVals, xVals, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
end

% draw a selection in tile (x, y).
function [] = selectPawn(x, y, tileWidth)
    hold on
    theta = 0:pi/50:2*pi;
    xVals = [x * tileWidth, (x - 1) * tileWidth, (x - 1) * tileWidth, x * tileWidth];
    yVals = [(y - 1) * tileWidth, (y - 1) * tileWidth, y * tileWidth, y * tileWidth];
    h = fill(yVals, xVals, 'green', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    hold off
end

function [x, y] = userInput()
    [pixX,pixY,~] = ginput(1);
    x = floor(pixY / 45) + 1;
    y = floor(pixX / 45) + 1;
    x = min(max(x, 1), 8);
    y = min(max(y, 1), 8);

end
  
