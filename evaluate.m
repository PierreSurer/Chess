function [val] = evaluate(team, Board)
    [x, y] = find(sign(Board) == team);
    [x2, y2] = find(sign(Board) == -team);
    
    teamVal = sum(cell2mat(arrayfun(@(a, b) getVal(abs(Board(a, b))), x, y,'uniformoutput',false)));
    enemyVal = sum(cell2mat(arrayfun(@(a, b) getVal(abs(Board(a, b))), x2, y2,'uniformoutput',false)));
    val = teamVal - enemyVal;

end

function [val] = getVal(val)
    values = [100, 16, 7, 6, 10, 1, 100, 10, 1];
    val = values(val);

end