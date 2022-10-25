function [val] = evaluate(team, Board)
    coder.cinclude('evaluation.h');
    % evaluate the C function
    val = double(coder.ceval('evaluation', team, Board)); 
end