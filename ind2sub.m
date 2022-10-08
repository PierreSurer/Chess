function [row, col] = ind2sub(ind)
    % ind2sub function optimized for our use-case: integers, 8x8 board.
    row = rem(ind - 1, 8) + 1;
    col = ((ind - row) / 8) + 1;
end

