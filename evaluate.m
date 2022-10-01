function [val] = evaluate(team, Board)
    [x, y] = find(sign(Board) == team);
    [x2, y2] = find(sign(Board) == -team);
    if(team == 1)
        teamVal = sum(cell2mat(arrayfun(@(a, b) getPieceVal(abs(Board(a, b))) * getHeatmap(a, b, team), x, y,'uniformoutput',false)));
        enemyVal = sum(cell2mat(arrayfun(@(a, b) getPieceVal(abs(Board(a, b))) * getHeatmap(a, 9 - b, -team), x2, y2,'uniformoutput',false)));
        val = teamVal - enemyVal;
    else
        teamVal = sum(cell2mat(arrayfun(@(a, b) getPieceVal(abs(Board(a, b))) * getHeatmap(a, 9 - b, team), x, y,'uniformoutput',false)));
        enemyVal = sum(cell2mat(arrayfun(@(a, b) getPieceVal(abs(Board(a, b))) * getHeatmap(a, b, -team), x2, y2,'uniformoutput',false)));
        val = teamVal - enemyVal;
    end
    

end

function [val] = getPieceVal(val)
    persistent values
    if isempty(values)
        values = [-1, 11, 6, 4, 8, 1, -1, 8, 1];
    end
    val = values(val);

end

function [val] = getHeatmap(x, y, team)
    persistent heatmap
    if isempty(heatmap)
        heatmap = [0, 0, 0, 0, 0, 0, 0, 0;
               0, 0, 0, 0, 0, 0, 0, 0;
               1, 1, 1, 2, 2, 1, 1, 1;
               2, 2, 3, 3, 3, 3, 2, 2;
               2, 2, 3, 4, 4, 3, 2, 2;
               3, 3, 4, 4, 4, 4, 3, 3;
               4, 4, 5, 5, 5, 5, 4, 4;
               5, 5, 6, 6, 6, 6, 5, 5] * 0.015625;
    end
        val = 1 + heatmap(x, y);
end