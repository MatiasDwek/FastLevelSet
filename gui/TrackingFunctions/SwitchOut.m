function SwitchOut(this, x, y)
this.Lout(x, y) = 1;
this.Lin(x, y) = 0;
this.phi(x, y) = 1;

if x+1 <= size(this.phi, 1)
    if this.phi(x+1, y) == -3
        this.Lin(x+1, y) = 1;
        this.phi(x+1, y) = -1;
    end
end

if y+1 <= size(this.phi, 2)
    if this.phi(x, y+1) == -3
        this.Lin(x, y+1) = 1;
        this.phi(x, y+1) = -1;
    end
end

if x-1 >= 1
    if this.phi(x-1, y) == -3
        this.Lin(x-1, y) = 1;
        this.phi(x-1, y) = -1;
    end
end

if y-1 >= 1
    if this.phi(x, y-1) == -3
        this.Lin(x, y-1) = 1;
        this.phi(x, y-1) = -1;
    end
end
end