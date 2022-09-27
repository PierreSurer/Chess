Board = createBoard();
displayBoard(Board);
lastX;
lastY;
x;
y;
while(true)
    pos = [];
    success = false;

    while(not(success))
        [x, y] = userInput();
        if(not(isempty(pos)) && any(ismember(pos, [x, y], 'rows')))
            [success, Board] = computeMove(lastX, lastY, x, y, Board);
        else
            pos = getPositions(x, y, Board);
            finalPos = [];
            for i = 1:size(pos)
                if(computeMove(x, y, pos(i, 1), pos(i, 2), Board))
                    finalPos(end + 1, :) =  [pos(i, 1), pos(i, 2)];
                end
            end
            pos = finalPos;
            lastX = x;
            lastY = y;
        end
        displayBoard(Board);
        for i = 1:size(pos, 1)
            if(Board(pos(i, 1), pos(i, 2)) == 0)
                drawPoint(pos(i, 1), pos(i, 2), 45);
            else
                drawTarget(pos(i, 1), pos(i, 2), 45);
            end
        end
    
    end
    displayBoard(Board);
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
    Board(7,6) = -4;
    
    Board(3,1) = 3;
    Board(6,1) = 3;
    Board(3,8) = -3;
    Board(6,8) = -3;
    
    Board(4,1) = 2;
    Board(5,5) = 1;
    Board(4,8) = -2;
    Board(5,8) = -1;
end

function [possibilities] = getPositions(x, y, Board) 
    current = Board(x, y);
    if(current == 0)
       possibilities = [];
    
    % if pawn
    elseif(abs(current) == 6 || abs(current) == 9) 
        possibilities = pawnMoves(x, y, Board);
    
    % if rook
    elseif(abs(current) == 5 || abs(current) == 8)
       possibilities = rookMoves(x, y, Board);

    % if knight
    elseif(abs(current) == 4)
        possibilities = knightMoves(x, y, Board);

    % if bishop
    elseif(abs(current) == 3)
        possibilities = bishopMoves(x, y, Board);

    % if queen
    elseif(abs(current) == 2)
        possibilities = bishopMoves(x, y, Board);
        possibilities = cat(1, possibilities, rookMoves(x, y, Board));

    % if king
    elseif(abs(current) == 1 || abs(current) == 7)
        possibilities = kingMoves(x, y, Board);

    end
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

function [x, y] = userInput()
    type = 0;
    while(type ~= 1)
        [pixX,pixY,type] = ginput(1);
    end
    x = floor(pixY / 45) + 1;
    y = floor(pixX / 45) + 1;
    x = min(max(x, 1), 8);
    y = min(max(y, 1), 8);

end
  
