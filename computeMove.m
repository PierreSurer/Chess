function [success, Board] = computeMove(startX, startY, endX, endY, Board)
    team = sign(Board(startX, startY));
    Board(Board == team * 9) = team * 6;
    PostBoard = Board;
    PostBoard(endX, endY) = Board(startX, startY);
    PostBoard(startX, startY) = 0;
    
    % set values for en passant
    if(abs(PostBoard(endX, endY)) == 6 || abs(PostBoard(endX, endY)) == 9)
        PostBoard(endX, endY) = team * 6;
        if(abs(endY - startY) > 1)
            PostBoard(endX, endY) = team * 9;
        end
        % queen transformation
        if(endY == 1 || endY == 8)
            PostBoard(endX, endY) = team * 2;
        end
    end
    % if unmoved tower moves
    if(abs(PostBoard(endX, endY)) == 5)
        PostBoard(endX, endY) = team * 8;
    end
    % if unmoved king moves
    if(abs(PostBoard(endX, endY)) == 1)
        PostBoard(endX, endY) = team * 7;
    end
    % en passant
    if(abs(PostBoard(endX, endY)) == 6 && PostBoard(endX, endY - team) == -team * 9)
        PostBoard(endX, endY - team) = 0;
    end
    % small castle
    if(endX == 7 && abs(Board(startX, startY)) == 1)
        PostBoard(6, startY) = team * 8;
        PostBoard(8, startY) = 0;
    end
    % big castle
    if(endX == 3 && abs(Board(startX, startY)) == 1)
        PostBoard(4, startY) = team * 8;
        PostBoard(1, startY) = 0;
    end
    [x, y] = searchKing(team, PostBoard);
    if(isKingChessed(x, y, PostBoard))
        success = false;
    else
        success = true;
        Board = PostBoard;
    end
end

function [x, y] = searchKing(team, Board)
    [x,y] = find(Board == team * 1 | Board == team * 7);
end