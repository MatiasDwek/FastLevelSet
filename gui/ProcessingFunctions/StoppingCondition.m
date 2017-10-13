function result = StoppingCondition(this)

result = true;

ones_of_Lout = find(this.Lout)';
for iter = ones_of_Lout
    [it1, it2] = ind2sub(size(this.Lout), iter);
    if this.Fd(it1, it2) >= 0
        result = false;
        return;
    end
    
end

ones_of_Lin = find(this.Lin)';
for iter = ones_of_Lin
    [it1, it2] = ind2sub(size(this.Lin), iter);
    if this.Fd(it1, it2) <= 0
        result = false;
        return;
    end
end


end