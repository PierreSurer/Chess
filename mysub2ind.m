function ind = mysub2ind(row, col)
    % sub2ind function optimized for our use-case: integers from 8x8 board.
    ind = row + (col - 1) * 8;
end

