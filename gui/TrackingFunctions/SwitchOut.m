function SwitchOut(this, x, y, c)
this.Lout(x, y, c) = 1;
this.Lin(x, y, c) = 0;
this.phi(x, y, c) = 1;

if x+1 <= size(this.phi, 1)
    if this.phi(x+1, y, c) == -3
        this.Lin(x+1, y, c) = 1;
        this.phi(x+1, y, c) = -1;
    end
end

if y+1 <= size(this.phi, 2)
    if this.phi(x, y+1, c) == -3
        this.Lin(x, y+1, c) = 1;
        this.phi(x, y+1, c) = -1;
    end
end

if x-1 >= 1
    if this.phi(x-1, y, c) == -3
        this.Lin(x-1, y, c) = 1;
        this.phi(x-1, y, c) = -1;
    end
end

if y-1 >= 1
    if this.phi(x, y-1, c) == -3
        this.Lin(x, y-1, c) = 1;
        this.phi(x, y-1, c) = -1;
    end
end
end