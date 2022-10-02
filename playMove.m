function [success, PostBoard] = playMove(startPos, endPos, Board)
    team = sign(Board(startPos));
    Board(Board == team * 9) = team * 6; % disable en passant for current team
    PostBoard = Board;
    PostBoard(endPos) = Board(startPos);
    PostBoard(startPos) = 0;
    [startX, startY] = ind2sub([8 8], startPos);
    [endX, endY] = ind2sub([8 8], endPos);
    
    % set values for en passant
    if(abs(PostBoard(endPos)) == 6 || abs(PostBoard(endPos)) == 9)
        PostBoard(endPos) = team * 6;
        if(abs(endY - startY) > 1)
            PostBoard(endPos) = team * 9;
        end
        % queen transformation
        if(endY == 1 || endY == 8)
            PostBoard(endPos) = team * 2;
        end
    end
    % if unmoved tower moves
    if(abs(PostBoard(endPos)) == 5)
        PostBoard(endPos) = team * 8;
    end
    % if unmoved king moves
    if(abs(PostBoard(endPos)) == 1)
        PostBoard(endPos) = team * 7;
    end
    % en passant
    if(abs(PostBoard(endPos)) == 6 && PostBoard(endX, endY - team) == -team * 9)
        PostBoard(endX, endY - team) = 0;
    end
    % small castle
    if(endX == 7 && abs(Board(startPos)) == 1)
        PostBoard(6, startY) = team * 8;
        PostBoard(8, startY) = 0;
    end
    % big castle
    if(endX == 3 && abs(Board(startPos)) == 1)
        PostBoard(4, startY) = team * 8;
        PostBoard(1, startY) = 0;
    end
    if(isKingChessed(team, PostBoard))
        success = false;
    else
        success = true;
    end
end