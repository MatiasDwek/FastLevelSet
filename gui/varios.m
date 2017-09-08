            
            
            % set function to call on mouse click
            set(hfig, 'WindowButtonDownFcn', @clicker);
            
            function clicker(hfig, ~)
                
                %                 ginput(1);
                
                get(hfig, 'selectiontype');
                % 'normal' for left moue button
                % 'alt' for right mouse button
                % 'extend' for middle mouse button
                % 'open' on double click
                
                get(this.handles.axes_image, 'currentpoint')
                % Current mouse location, in pixels from the lower left.
                % When the units of the figure are 'normalized', the
                % coordinates will be [0 0] inb lower left, and [1 1] in
                % the upper right.
                
                %                 axesHandle  = get(this.handles.axes_image,'Parent');
                %                 coordinates = get(axesHandle,'CurrentPoint');
                %                 coordinates = coordinates(1,1:2)
                
            end