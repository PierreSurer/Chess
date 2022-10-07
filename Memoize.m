classdef Memoize  
    properties (Constant)
        Data = MemoizeStore
    end
    methods
        function [] = insert(obj, Board, val)
            obj.Data.Data(keyHash(Board)) = val;
            % disp(length(obj.Data.Data));
        end

        function [startPos, endPos, val] = lookup(obj, Board)
            d = obj.Data.Data(keyHash(Board));
            startPos = d(1);
            endPos = d(2);
            val = d(3);
        end

        function res = contains(obj, Board)
            res = isKey(obj.Data.Data, keyHash(Board));
        end

        function [] = reset(obj)
            obj.Data.Data = containers.Map('KeyType', 'uint64', 'ValueType', 'any');
        end
    end
end

