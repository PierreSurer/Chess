function [startX, startY, endX, endY] = openGame(Board)
    T = readtable('high_elo_opening.csv','NumHeaderLines',1).Var19;
    T = string(T(~cellfun(@isempty, T)));
    T = char(arrayfun(@(a) erase(erase(a, 'x'), '+'), T));
end