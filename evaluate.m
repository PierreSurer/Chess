function [val] = evaluate(team, Board)
    values = [200, 9, 3, 3, 5, 1, 200, 5, 1];
    pieces = double(Board(Board ~= 0));
    val = team * sum(values(abs(pieces)) * sign(pieces));
end