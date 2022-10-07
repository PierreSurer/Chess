function [val] = evaluate(team, Board)
    pieces = find(Board ~= 0);
    values = [200, 9, 3, 3, 5, 1, 200, 5, 1];
    val = team * sum(arrayfun(@(pos) values(abs(Board(pos))), pieces));
end