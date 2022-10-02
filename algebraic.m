% algebraic notation for chess. parsing and stringify.
% see https://en.wikipedia.org/wiki/Algebraic_notation_(chess)

classdef algebraic
   methods (Static)

       function [startPos, endPos] = parse(str, team, Board)
            % find endPos (easiest)
            endX = str(end - 1) - 'a' + 1;
            endY = str(end - 0) - '1' + 1;
            endPos = sub2ind([8 8], endX, endY);

            % find piece type
            type = strfind('KQBNR', str(1));
            if isempty(type)
                type = 6;
            end
        
            % find pieces of the right type that can go to endPos
            pieces = find(sign(Board) == team & abs(Board) == type);
            validPieces = zeros(size(pieces, 1), 1, 'logical');
            for i = 1:size(pieces, 1)
                moves = listMoves(pieces(i), Board);
                validPieces(i) = any(moves == endPos);
            end
            pieces = pieces(validPieces);
        
            if size(pieces, 1) == 0
                error("invalid algebraic: no valid start piece");
            elseif size(pieces, 1) == 1
                startPos = pieces(1);
            else % multiple candidate pieces: desambiguate with file, then rank, then file&rank
                [x, y] = ind2sub([8 8], pieces);
                file = str(1) - 'a' + 1;
                if file < 1 || file > 8
                    rank = str(1) - '1' + 1;
                    pieces = pieces(y == rank);
                else
                    pieces = pieces(x == file);
                    if size(pieces, 1) > 1
                        rank = str(2) - '1' + 1;
                        pieces = pieces(y == rank);
                    end
                end
                if size(pieces, 1) == 1
                    startPos = pieces(1);
                else
                    error("invalid algebraic: failed to desambiguate start piece");
                end
            end
        end
        
        function str = stringify(startPos, endPos, team, Board)
            startPiece = abs(Board(startPos));
            endPiece = abs(Board(endPos));
        
            % piece name
            names = 'KQBNR_KR_';
            pieceName = '';
            if startPiece ~= 6 && startPiece ~= 9 % not pawn
                pieceName = names(startPiece);
            end
        
            % destination
            [endX, endY] = ind2sub([8 8], endPos);
            endFile = 'a' + (endX - 1);
            endRank = '1' + (endY - 1);
        
            % is a capture ?
            capture = '';
            if endPiece ~= 0
                capture = 'x';
            end
        
            % find pieces of right type that can go to (endX, endY)
            pieces = find(sign(Board) == team & abs(Board) == startPiece);
            validPieces = zeros(size(pieces, 1), 1, 'logical');
            for i = 1:size(pieces, 1)
                if pieces(i) ~= startPos
                    moves = listMoves(pieces(i), Board);
                    validPieces(i) = any(moves == endPos);
                end
            end
            pieces = pieces(validPieces);
        
            % resolve file / rank ambiguity
            startFile = '';
            startRank = '';
        
            if size(pieces, 1) > 0
                [x, y] = ind2sub([8 8], pieces);
                [startX, startY] = ind2sub([8 8], startPos);
                if any(x == startX)
                    startFile = 'a' + (startX - 1);
                end
                if any(y == startY)
                    startRank = '1' + (startY - 1);
                end
            end
        
            str = [pieceName startFile startRank capture endFile endRank];
        end
   end
end