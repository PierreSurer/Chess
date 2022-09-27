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
    possibilities = [];
    if(Board(coords.x, coords.y) == 0)
       return;
    end
    % if pawn
    if(abs(Board(coords.x, coords.y)) == 6 || abs(Board(coords.x, coords.y)) == 9) 
        % normal forward move
        if(Board(coords.x, coords.y + sign(Board(coords.x, coords.y))) == 0) 
            possibilities(end + 1) = {coords.x, coords.y + sign(Board(coords.x, coords.y))};
        end
        % double forward move (white)
        if(coords.y == 2 && sign(Board(coords.x, 2)) == 1) 
            if(Board(coords.x, 3) == 0 && Board(coords.x, 4) == 0)
                possibilities(end + 1) = {coords.x, 4};
            end
        end
        % double forward move (black)
        if(coords.y == 7 && sign(Board(coords.x, 2)) == -1) 
            if(Board(coords.x, 6) == 0 && Board(coords.x, 5) == 0)
                possibilities(end + 1) = {coords.x, 5};
            end
        end
        % diagonal attack moves
        if(coords.x + 1 < 9 && sign(Board(coords.x + 1, coords.y + sign(Board(coords.x, coords.y)))) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x + 1, coords.y + sign(Board(coords.x, coords.y))};
        end
        if(coords.x - 1 > 0 && sign(Board(coords.x - 1, coords.y + sign(Board(coords.x, coords.y)))) ~= sign(Board(coords.x, coords.y)))
            possibilities(end + 1) = {coords.x - 1, coords.y + sign(Board(coords.x, coords.y))};
        end
        % en passant
        if(coords.x + 1 < 9 && sign(Board(coords.x + 1, coords.y)) == -sign(Board(coords.x, coords.y)) * 9 && Board(coords.x + 1, coords.y + sign(Board(coords.x, coords.y))) == 0)
            possibilities(end + 1) = {coords.x + 1, coords.y + sign(Board(coords.x, coords.y))};
        end
        if(coords.x - 1 > 0 && sign(Board(coords.x - 1, coords.y)) == -sign(Board(coords.x, coords.y)) * 9 && Board(coords.x - 1, coords.y + sign(Board(coords.x, coords.y))) == 0)
            possibilities(end + 1) = {coords.x - 1, coords.y + sign(Board(coords.x, coords.y))};
        end
    end

end

function im = getPieceImage(im, index)
    [h, w] = size(im);
    w = w / 6;
    h = h / 2;

    if index == 0
        im = zeros(w, h);
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
    im = imread('pieces.png');
    imgs = arrayfun(@(x) getPieceImage(im, x), Board, 'UniformOutput', false);
    montage(imgs);
end
