% algebraic notation for chess. parsing and stringify.
% see https://en.wikipedia.org/wiki/Algebraic_notation_(chess)

classdef algebraic
   methods (Static)

       function [startPos, endPos] = parse(str, team, Board)
            str = erase(str,['+']);
            Board(Board == team * 9) = team * 6;
            Board(Board == team * 7) = team * 1;
            Board(Board == team * 8) = team * 5;


            % find endPos (easiest)
            endX = str(end - 1) - 'a' + 1;
            endY = str(end - 0) - '1' + 1;
            endPos = mysub2ind(endX, endY);
            
            % kingside castling
            if str == "O-O"
                if team == 1
                    startPos = mysub2ind(5, 1);
                    endPos = mysub2ind(7, 1);
                else
                    startPos = mysub2ind(5, 8);
                    endPos = mysub2ind(7, 8);
                end
                return;
            end
            
            % queenside castling
            if str == "O-O-O"
                if team == 1
                    startPos = mysub2ind(5, 1);
                    endPos = mysub2ind(3, 1);
                else
                    startPos = mysub2ind(5, 8);
                    endPos = mysub2ind(3, 8);
                end
                return;
            end

            % find piece type
            type = strfind('KQBNR', str(1));
            if isempty(type)
                type = 6;
            else
                str = str(2:end); %clear piece type
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
                [x, y] = myind2sub(pieces);
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

            % kingside castling
            if (startPos == mysub2ind(5, 1) && endPos == mysub2ind(7, 1) || startPos == mysub2ind(5, 8) && endPos == mysub2ind(7, 8)) && startPiece == 1
                str = "O-O";
                return;
            end
            
            % queenside castling
            if (startPos == mysub2ind(5, 1) && endPos == mysub2ind(3, 1) || startPos == mysub2ind(5, 8) && endPos == mysub2ind(3, 8)) && startPiece == 1
                str = "O-O-O";
                return;
            end
        
            % piece name
            names = 'KQBNR_KR_';
            pieceName = '';
            if startPiece ~= 6 && startPiece ~= 9 % not pawn
                pieceName = names(startPiece);
            end
        
            % destination
            [endX, endY] = myind2sub(endPos);
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
                [x, y] = myind2sub(pieces);
                [startX, startY] = myind2sub(startPos);
                if any(x == startX) % same file, desambiguate with rank
                    startRank = '1' + (startY - 1);
                end
                if any(y == startY) % same rank, desambiguate with file
                    startFile = 'a' + (startX - 1);
                end
            end
        
            str = [pieceName startFile startRank capture endFile endRank];
        end
   end
end