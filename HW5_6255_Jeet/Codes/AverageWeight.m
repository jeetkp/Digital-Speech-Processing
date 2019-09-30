function [ val ] = AverageWeight(weights, values)
    val = weights' * values;
    val = val ./ sum(weights, 1);    
end

