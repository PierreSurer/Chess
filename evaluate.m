function [val] = evaluate(team, Board)
    pieces = find(Board ~= 0);
    val = team * sum(arrayfun(@(pos) getPieceVal(pos, Board(pos)), pieces));
end

function [val] = getPieceVal(pos, piece)

        values = [-1, 11, 6, 4, 8, 1, -1, 8, 1];

        heatmap = [
           -2, -1, -1, -1, -1, -1, -1, -2;
           0, 0, 0, 0, 0, 0, 0, 0;
           1, 1, 1, 2, 2, 1, 1, 1;
           2, 2, 3, 3, 3, 3, 2, 2;
           2, 2, 3, 4, 4, 3, 2, 2;
           3, 3, 4, 4, 4, 4, 3, 3;
           4, 4, 5, 5, 5, 5, 4, 4;
           5, 5, 6, 6, 6, 6, 5, 5
        ] / 64;

    if(sign(piece) == 1)
        val = values(abs(piece)) * (1 + heatmap(pos));
    else
        [x, y] = ind2sub([8 8], pos);
        val = -values(abs(piece)) * (1 + heatmap(x, 9 - y));
    end
end
