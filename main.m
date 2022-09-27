Board = createBoard();
displayBoard(Board);

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

function [possibilities] = getPositions(coords, Board) 
    if(Board(coords.x, coords.y) == 0)
       possibilities = [];
       return;
    end
    % if pawn
    if(abs(Board(coords.x, coords.y)) == 6 || abs(Board(coords.x, coords.y)) == 9) 
        possibilities = pawnMoves(coords, Board);
        return;
    end
    % if rook
    if(abs(Board(coords.x, coords.y)) == 5 || abs(Board(coords.x, coords.y)) == 8)
       possibilities = rookMoves(coords, Board);
       return;
    end
    % if knight
    if(abs(Board(coords.x, coords.y)) == 4)
        possibilities = knightMoves(coords, Board);
        return;
    end
    % if bishop
    if(abs(Board(coords.x, coords.y)) == 3)
        possibilities = bishopMoves(coords, Board);
        return;
    end
    % if queen
    if(abs(Board(coords.x, coords.y)) == 2)
        possibilities = bishopMoves(coords, Board);
        possibilities = cat(1, possibilities, rookMoves(coords, Board));
        return;
    end
    % if king
    if(abs(Board(coords.x, coords.y)) == 1 || abs(Board(coords.x, coords.y)) == 7)
        possibilities = kingMoves(coords, Board);
        return;
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
        0, 1, 2, 3, 4, 5, 6, 7, 8
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
