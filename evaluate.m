function [val] = evaluate(team, Board)
    pieces = find(Board ~= 0);
    val = team * sum(arrayfun(@(pos) getPieceVal(pos, Board(pos)), pieces));
end

function [val] = getPieceVal(pos, piece)

        values = [-1, 11, 6, 4, 8, 1, -1, 8, 1];

        heatmap = [
           98,  99,  99,  99,  99,  99,  99,  98;
           100, 100, 100, 100, 100, 100, 100, 100;
           101, 101, 101, 102, 102, 101, 101, 101;
           102, 102, 103, 103, 103, 103, 102, 102;
           102, 102, 103, 104, 104, 103, 102, 102;
           103, 103, 104, 104, 104, 104, 103, 103;
           104, 104, 105, 105, 105, 105, 104, 104;
           105, 105, 106, 106, 106, 106, 105, 105
        ];

    if(sign(piece) == 1)
        val = values(abs(piece)) * (1 + heatmap(pos));
    else
        [x, y] = ind2sub([8 8], pos);
        val = -values(abs(piece)) * (1 + heatmap(x, 9 - y));
    end
end
