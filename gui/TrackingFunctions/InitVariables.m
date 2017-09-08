function InitVariables(this)
this.phi = ones(size(this.current_frame));

start_pos = round(this.click_position_start);
end_pos = round(this.click_position_end);

%exterior pixels
this.phi = this.phi*-3;

%interior pixels
this.phi(start_pos(2)+1:end_pos(2)-1, start_pos(1)+1:end_pos(1)-1, :) = 3;

%Lin
this.phi(start_pos(2), start_pos(1):end_pos(1), :) = -1; %|o
this.phi(end_pos(2), start_pos(1):end_pos(1), :) = -1; %o|
this.phi(start_pos(2):end_pos(2), start_pos(1), :) = -1; %ó
this.phi(start_pos(2):end_pos(2), end_pos(1), :) = -1; %_o

%Lout
this.phi(start_pos(2)-1, start_pos(1):end_pos(1), :) = 1; %|o
this.phi(end_pos(2)+1, start_pos(1):end_pos(1), :) = 1; %o|
this.phi(start_pos(2):end_pos(2), start_pos(1)-1, :) = 1; %ó
this.phi(start_pos(2):end_pos(2), end_pos(1)+1, :) = 1; %_o

end