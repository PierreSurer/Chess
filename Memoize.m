% dictionnary to store position and assignate a value
classdef Memoize  
    properties (Constant)
        Data = MemoizeStore
    end
    methods
        function [] = insert(obj, cell, val)
            obj.Data.Data(keyHash(cell)) = val;
            % disp(length(obj.Data.Data));
        end

        % returns all required values
        function [startPos, endPos, val, depth, flag] = lookup(obj, cell)
            d = obj.Data.Data(keyHash(cell));
            startPos = d(1);
            endPos = d(2);
            val = d(3);
            depth = d(4);
            flag = d(5);
        end

        function res = contains(obj, cell)
            res = isKey(obj.Data.Data, keyHash(cell));
        end

        function [] = reset(obj)
            obj.Data.Data = containers.Map('KeyType', 'uint64', 'ValueType', 'any');
        end
    end
end

