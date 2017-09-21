classdef ObjectTrackingLauncher < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        handles;
        filename;
        videofile;
        click_position_start; %[x y]
        click_position_end; %[x y]
        
        current_frame;
        current_frame_copy;
        
        %Algorithm variables
        phi; %level set function
        F; %evolution speed
        Lin; %neighboring pixels in
        Lout; %neighboring pixels out
        
        %Algorithm parameters
        distribution;
    end
    
    methods
        function this = ObjectTrackingLauncher(this)
            hfig = hgload('ObjectTracking.fig');
            this.handles = guihandles(hfig);
            movegui(hfig,'center');
            
            set(this.handles.pushbutton_next,'callback', @this.pushbutton_next_callback);
            set(this.handles.pushbutton_select,'callback', @this.pushbutton_select_callback);
            set(this.handles.pushbutton_iterate,'callback', @this.pushbutton_iterate_callback);
            set(this.handles.togglebutton_play,'callback', @this.togglebutton_play_callback);
            set(this.handles.radiobutton_l1norm,'callback', @this.radiobutton_l1norm);
            set(this.handles.radiobutton_l2norm,'callback', @this.radiobutton_l2norm);
            set(this.handles.radiobutton_gaussian,'callback', @this.radiobutton_gaussian);
            
            %data = {'' ; ''; ''};
            %set(this.handles.uitable_H1,'Data',data);
            %set(this.handles.uitable_H1, 'RowName', {'', '', ''}, 'ColumnName', {'', '', ''});
            
            this.filename = 'SampleVideoBunny.mp4';
            this.videofile = VideoReader(this.filename);
            
            if hasFrame(this.videofile)
                this.current_frame = readFrame(this.videofile);
            end
            
            axes(this.handles.axes_image);
            image(this.current_frame,'Parent',this.handles.axes_image);
            clean_axes(this.handles.axes_image);
            
            this.distribution = L1Norm;
            
        end
        
        % View next frame
        function pushbutton_next_callback(this, varargin)
            
            if hasFrame(this.videofile)
                this.current_frame = readFrame(this.videofile);
            end
            
            image(this.current_frame, 'Parent', this.handles.axes_image);
            clean_axes(this.handles.axes_image);
        end
        
        function pushbutton_select_callback(this, varargin)
            
            temp_start = ginput(1); % [x y]
            size_image = size(this.current_frame); % [y x dim]
            if ((temp_start(1) > size_image(2)) || ...
                    (temp_start(2) > size_image(1)) || ...
                    (temp_start(1) < 0) || ...
                    (temp_start(2) < 0))
                return;
            end
            
            temp_end = ginput(1); % [x y]
            if ((temp_end(1) > size_image(2)) || ...
                    (temp_end(2) > size_image(1)) || ...
                    (temp_end(1) < 0) || ...
                    (temp_end(2) < 0))
                return;
            end
            
            this.click_position_start(1) = min(temp_start(1), temp_end(1));
            this.click_position_start(2) = min(temp_start(2), temp_end(2));
            this.click_position_end(1) = max(temp_start(1), temp_end(1));
            this.click_position_end(2) = max(temp_start(2), temp_end(2));
            
            
            start_pos = round(this.click_position_start);
            end_pos = round(this.click_position_end);
            this.current_frame_copy = this.current_frame;
            
            line_width = 3;
            %Lin
            this.current_frame_copy(start_pos(2):start_pos(2)+line_width, start_pos(1):end_pos(1), :) = 255; %|o
            this.current_frame_copy(end_pos(2)-line_width:end_pos(2), start_pos(1):end_pos(1), :) = 255; %o|
            this.current_frame_copy(start_pos(2):end_pos(2), start_pos(1):start_pos(1)+line_width, :) = 255; %ó
            this.current_frame_copy(start_pos(2):end_pos(2), end_pos(1)-line_width:end_pos(1), :) = 255; %_o
            
            %Lout
            this.current_frame_copy(start_pos(2)-line_width:start_pos(2), start_pos(1):end_pos(1), :) = 0; %|o
            this.current_frame_copy(end_pos(2):end_pos(2)+line_width, start_pos(1):end_pos(1), :) = 0; %o|
            this.current_frame_copy(start_pos(2):end_pos(2), start_pos(1)-line_width:start_pos(1), :) = 0; %ó
            this.current_frame_copy(start_pos(2):end_pos(2), end_pos(1):end_pos(1)+line_width, :) = 0; %_o
            
            image(this.current_frame_copy, 'Parent', this.handles.axes_image);
            clean_axes(this.handles.axes_image);
            
            InitVariables(this);
        end
        
        function togglebutton_play_callback(this, varargin)
            set(this.handles.togglebutton_stop, 'Value', 0);
            
            while ((get(this.handles.togglebutton_stop, 'Value') ~= 1) && (get(this.handles.togglebutton_play, 'Value') ~= 0))
                if hasFrame(this.videofile)
                    this.current_frame = readFrame(this.videofile);
                end
                
                image(this.current_frame, 'Parent', this.handles.axes_image);
                clean_axes(this.handles.axes_image);
                pause(.05);
            end
            
            set(this.handles.togglebutton_play, 'Value', 0);
            set(this.handles.togglebutton_stop, 'Value', 0);
        end
        
        function radiobutton_l1norm(this, varargin)
            this.distribution = L1Norm;
        end
        
        function radiobutton_l2norm(this, varargin)
            this.distribution = L2Norm;
        end
        
        function radiobutton_gaussian(this, varargin)
            this.distribution = Gaussian;
        end
       
        function pushbutton_iterate_callback(this, varargin)
            IterationStep(this);
        end
    end
    methods (Static)
        InitVariables(this);
        SwitchIn(this, x, y, c);
        SwitchOut(this, x, y, c);
        IterationStep(this);
    end
end

