function [val] = evaluate(team, Board)
    [x, y] = find(Board ~= 0);
    val = team * sum(arrayfun(@(a, b) getPieceVal(a, b, Board(a, b)), x, y));

end

function [val] = getPieceVal(x, y, piece)

        values = [-1, 11, 6, 4, 8, 1, -1, 8, 1];

        heatmap = [
           0, 0, 0, 0, 0, 0, 0, 0;
           0, 0, 0, 0, 0, 0, 0, 0;
           1, 1, 1, 2, 2, 1, 1, 1;
           2, 2, 3, 3, 3, 3, 2, 2;
           2, 2, 3, 4, 4, 3, 2, 2;
           3, 3, 4, 4, 4, 4, 3, 3;
           4, 4, 5, 5, 5, 5, 4, 4;
           5, 5, 6, 6, 6, 6, 5, 5
        ] / 64;

    if(sign(piece) == 1)
        val = values(abs(piece)) * (1 + heatmap(x, y));
    else
        val = -values(abs(piece)) * (1 + heatmap(x, 9 - y));
    end
end
