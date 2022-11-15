function val = evaluate(team, Board)
    eval = HeatMap;
    pieces = find(Board ~= 0);
    values = Board(pieces);
    positions = abs(65 * (values < 0) - pieces);
    val = team * dot(eval.getVal(abs(values), int8(positions)), double(sign(values)));

end