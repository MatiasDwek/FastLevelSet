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
        
        frame_height;
        frame_width;
        
        %Algorithm variables
        phi; %level set function
        Fd; %evolution speed
        Lin; %neighboring pixels in
        Lout; %neighboring pixels out
        
        init;
        
        %Algorithm parameters
        distribution;
        feature;
        frame_average;
        threshold;
    end
    
    methods
        function this = ObjectTrackingLauncher(this)
            hfig = hgload('ObjectTracking.fig');
            this.handles = guihandles(hfig);
            movegui(hfig,'center');
            
            set(this.handles.pushbutton_open,'callback', @this.pushbutton_open_callback);
            set(this.handles.pushbutton_next,'callback', @this.pushbutton_next_callback);
            set(this.handles.pushbutton_prev,'callback', @this.pushbutton_prev_callback);
            set(this.handles.pushbutton_select,'callback', @this.pushbutton_select_callback);
            set(this.handles.pushbutton_iterate,'callback', @this.pushbutton_iterate_callback);
            set(this.handles.togglebutton_play,'callback', @this.togglebutton_play_callback);
            set(this.handles.pushbutton_iteratemultiple,'callback', @this.pushbutton_iterate_multiple_callback);
            set(this.handles.radiobutton_l1norm,'callback', @this.radiobutton_l1norm);
            set(this.handles.radiobutton_l2norm,'callback', @this.radiobutton_l2norm);
            set(this.handles.radiobutton_gaussian,'callback', @this.radiobutton_gaussian);
            set(this.handles.radiobutton_color,'callback', @this.radiobutton_color);
            set(this.handles.radiobutton_intensity,'callback', @this.radiobutton_intensity);
            
            %data = {'' ; ''; ''};
            %set(this.handles.uitable_H1,'Data',data);
            %set(this.handles.uitable_H1, 'RowName', {'', '', ''}, 'ColumnName', {'', '', ''});
            
            axes(this.handles.axes_image);
            image(this.current_frame,'Parent',this.handles.axes_image);
            clean_axes(this.handles.axes_image);
            
            this.distribution = L1Norm;
            
            this.feature = FeatureVector.Color_t;
            this.threshold = .1;
            
            this.init = false;
            
        end
        
        function pushbutton_open_callback(this, varargin)
            this.filename = uigetfile('*.mp4');
            if ~isequal(this.filename,0)
                this.videofile = VideoReader(this.filename);
                          
                if hasFrame(this.videofile)
                    this.current_frame = readFrame(this.videofile);
                end
                
                axes(this.handles.axes_image);
                image(this.current_frame,'Parent',this.handles.axes_image);
                clean_axes(this.handles.axes_image);
                
                
                this.frame_height = size(this.current_frame, 1);
                this.frame_width = size(this.current_frame, 2);
            end
             set(this.handles.radiobutton_color, 'Value',  1);
             this.feature = FeatureVector.Color_t;
             this.threshold = .1;
             
             set(this.handles.radiobutton_l1norm, 'Value',  1);
             this.distribution = L1Norm;
             
             this.init = false;
        end
        
        % View next frame
        function pushbutton_next_callback(this, varargin)
            
            if hasFrame(this.videofile)
                this.current_frame = readFrame(this.videofile);
            end
            
            if this.init == true
                this.current_frame_copy = this.current_frame;
                for it1 = 1:this.frame_height
                    for it2 = 1:this.frame_width
                        if this.Lin(it1, it2) == 1
                            this.current_frame_copy(it1, it2, :) = 255;
                        elseif this.Lout(it1, it2) == 1
                            this.current_frame_copy(it1, it2, :) = 0;
                        end
                    end
                end
                
                image(this.current_frame_copy, 'Parent', this.handles.axes_image);
                clean_axes(this.handles.axes_image);
            else
                image(this.current_frame, 'Parent', this.handles.axes_image);
            end
            
            
            clean_axes(this.handles.axes_image);
        end
        
        function pushbutton_prev_callback(this, varargin)
            this.videofile = VideoReader(this.filename);
            
            if hasFrame(this.videofile)
                this.current_frame = readFrame(this.videofile);
            end
            
            axes(this.handles.axes_image);
            image(this.current_frame,'Parent',this.handles.axes_image);
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
            
            line_width = 1;
            %Lin
            this.current_frame_copy(start_pos(2):start_pos(2)+line_width, start_pos(1):end_pos(1), :) = 255; %|o
            this.current_frame_copy(end_pos(2)-line_width:end_pos(2), start_pos(1):end_pos(1), :) = 255; %o|
            this.current_frame_copy(start_pos(2):end_pos(2), start_pos(1):start_pos(1)+line_width, :) = 255; %�
            this.current_frame_copy(start_pos(2):end_pos(2), end_pos(1)-line_width:end_pos(1), :) = 255; %_o
            
            %Lout
            this.current_frame_copy(start_pos(2)-line_width:start_pos(2), start_pos(1):end_pos(1), :) = 0; %|o
            this.current_frame_copy(end_pos(2):end_pos(2)+line_width, start_pos(1):end_pos(1), :) = 0; %o|
            this.current_frame_copy(start_pos(2):end_pos(2), start_pos(1)-line_width:start_pos(1), :) = 0; %�
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
        
        function radiobutton_color(this, varargin)
            this.feature = FeatureVector.Color_t;
            this.threshold = .1;
        end
        
        function radiobutton_intensity(this, varargin)
            if this.feature ~= FeatureVector.Intensity_t
                this.threshold = .13;
                this.feature = FeatureVector.Intensity_t;
                %Should read 3 or 4 seconds instead of all the file
                numFrames = 0;
                this.frame_average = uint32(this.current_frame);
                while hasFrame(this.videofile) && numFrames < 5000
                    this.current_frame = readFrame(this.videofile);
                    this.frame_average = this.frame_average + uint32(this.current_frame);
                    numFrames = numFrames + 1;
                end
                this.frame_average = uint8(this.frame_average/numFrames);
                axes(this.handles.axes_image);
                image(this.frame_average,'Parent',this.handles.axes_image);
                clean_axes(this.handles.axes_image);
            end
            pushbutton_prev_callback(this, varargin);
        end
        
        function pushbutton_iterate_callback(this, varargin)
            IterationStep(this);
            GaussianFilterStep(this);
            
            this.current_frame_copy = this.current_frame;
            for it1 = 1:this.frame_height
                for it2 = 1:this.frame_width
                    if this.Lin(it1, it2) == 1
                        this.current_frame_copy(it1, it2, :) = 255;
                    elseif this.Lout(it1, it2) == 1
                        this.current_frame_copy(it1, it2, :) = 0;
                    end
                end
            end
            
            image(this.current_frame_copy, 'Parent', this.handles.axes_image);
            clean_axes(this.handles.axes_image);
        end
        
        function pushbutton_iterate_multiple_callback(this, varargin)
            for it3 = 1:str2num(get(this.handles.edit_times, 'String'))
%                 if StoppingCondition(this)
%                     break
%                 end
                
                if this.feature == FeatureVector.Intensity_t
                    this.current_frame_copy = uint8(mean(abs(int8(this.current_frame) - int8(this.frame_average)), 3));
                    image(this.current_frame_copy, 'Parent', this.handles.axes_image);
                    clean_axes(this.handles.axes_image);
                    IterationStep(this, this.current_frame_copy);
                else
                    IterationStep(this, this.current_frame);
                end
                
                if this.feature == FeatureVector.Intensity_t
                    this.current_frame_copy = uint8(mean(abs(int8(this.current_frame) - int8(this.frame_average)), 3));
                else
                    this.current_frame_copy = this.current_frame;
                end
                for it1 = 1:this.frame_height
                    for it2 = 1:this.frame_width
                        if this.Lin(it1, it2) == 1
                            this.current_frame_copy(it1, it2, :) = 255;
                        elseif this.Lout(it1, it2) == 1
                            this.current_frame_copy(it1, it2, :) = 0;
                        end
                    end
                end
                
                image(this.current_frame_copy, 'Parent', this.handles.axes_image);
                clean_axes(this.handles.axes_image);
                
                pause(.01)
                
            end
            
            GaussianFilterStep(this);
            
            this.current_frame_copy = this.current_frame;
            for it1 = 1:this.frame_height
                for it2 = 1:this.frame_width
                    if this.Lin(it1, it2) == 1
                        this.current_frame_copy(it1, it2, :) = 255;
                    elseif this.Lout(it1, it2) == 1
                        this.current_frame_copy(it1, it2, :) = 0;
                    end
                end
            end
            
            image(this.current_frame_copy, 'Parent', this.handles.axes_image);
            clean_axes(this.handles.axes_image);
            pause(.01)
            
        end
    end
    methods (Static)
        InitVariables(this);
        SwitchIn(this, x, y, c);
        SwitchOut(this, x, y, c);
        IterationStep(this);
        GaussianFilterStep(this);
        StoppingCondition(this);
    end
end
