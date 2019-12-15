classdef yuhangl_Exercise4_app < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        ThePowerofAppDesignerUIFigure  matlab.ui.Figure
        SurfButton                     matlab.ui.control.Button
        MeshButton                     matlab.ui.control.Button
        ContourButton                  matlab.ui.control.Button
        SelectdataDropDownLabel        matlab.ui.control.Label
        SelectdataDropDown             matlab.ui.control.DropDown
        UIAxes                         matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        current_data = peaks(35); % Description
        current_title = 'Peaks data in '
        current_title1 = 'a Surf plot'
    end
    
    methods (Access = private)
        function resetBackground(app) % Reset the background of all buttons
            title1 = strcat(app.current_title, app.current_title1)
            title(app.UIAxes, title1)
            app.ContourButton.BackgroundColor='yellow' % Set yellow as default background
            app.MeshButton.BackgroundColor='yellow' % Set yellow as default background
            app.SurfButton.BackgroundColor='yellow' % Set yellow as default background
        end
        
        function generateSinc(app) % Generates the matrix for sinc
            [x,y]=meshgrid(-8:.5:8);
            r=sqrt(x.^2+y.^2)+eps;
            app.current_data=sin(r)./r;
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.current_data=peaks(35);
            surf(app.UIAxes,app.current_data)
            app.ContourButton.BackgroundColor='yellow' % Set yellow as default background
            app.MeshButton.BackgroundColor='yellow' % Set yellow as default background
            app.SurfButton.BackgroundColor='red' % Set red as background when choosen
        end

        % Value changed function: SelectdataDropDown
        function SelectdataDropDownValueChanged(app, event)
            value = app.SelectdataDropDown.Value;
            switch value
                case 'Peaks'
                    resetBackground(app); % Reset the background of all buttons when change data
                    app.current_data=peaks(35); % Matlab example function
                    app.current_title='Peaks data in '
                case 'Membrane'    
                    app.current_data=membrane;  % Matlab logo
                    resetBackground(app); % Reset the background of all buttons when change data
                    app.current_title='Membrane data in '
                case 'Sinc'                     % matrix of values for sinc
                    resetBackground(app); % Reset the background of all buttons when change data
                    generateSinc(app); % Call corresponding function to generate the matrix for sinc
                    app.current_title='Sinc data in '
            end
        end

        % Button pushed function: MeshButton
        function MeshButtonPushed(app, event)
            resetBackground(app); % Reset the background of all buttons when change data
            app.MeshButton.BackgroundColor='red' % Set the background of the choosen button as red
            mesh(app.UIAxes,app.current_data) % plot the corresponding figure
            value = app.SelectdataDropDown.Value
            % Change the title of the axes
            app.current_title1 = ' a Mesh plot'
            title1 = strcat(app.current_title, app.current_title1)
            title(app.UIAxes, title1)
        end

        % Button pushed function: SurfButton
        function SurfButtonPushed(app, event)
            resetBackground(app); % Reset the background of all buttons when change data
            app.SurfButton.BackgroundColor='red' % Set the background of the choosen button as red
            surf(app.UIAxes,app.current_data) % plot the corresponding figure
            value = app.SelectdataDropDown.Value
            % Change the title of the axes
            app.current_title1 = ' a Surf plot'
            title1 = strcat(app.current_title, app.current_title1)
            title(app.UIAxes, title1)
        end

        % Button pushed function: ContourButton
        function ContourButtonPushed(app, event)
            resetBackground(app); % Reset the background of all buttons when change data
            app.ContourButton.BackgroundColor='red' % Set the background of the choosen button as red
            contour(app.UIAxes,app.current_data) % plot the corresponding figure
            value = app.SelectdataDropDown.Value
            % Change the title of the axes
            app.current_title1 = ' a Contour plot'
            title1 = strcat(app.current_title, app.current_title1)
            title(app.UIAxes, title1)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create ThePowerofAppDesignerUIFigure and hide until all components are created
            app.ThePowerofAppDesignerUIFigure = uifigure('Visible', 'off');
            app.ThePowerofAppDesignerUIFigure.Color = [0.4667 0.6745 0.1882];
            app.ThePowerofAppDesignerUIFigure.Position = [100 100 640 480];
            app.ThePowerofAppDesignerUIFigure.Name = 'The Power of App Designer';

            % Create SurfButton
            app.SurfButton = uibutton(app.ThePowerofAppDesignerUIFigure, 'push');
            app.SurfButton.ButtonPushedFcn = createCallbackFcn(app, @SurfButtonPushed, true);
            app.SurfButton.Position = [500 351 100 22];
            app.SurfButton.Text = 'Surf';

            % Create MeshButton
            app.MeshButton = uibutton(app.ThePowerofAppDesignerUIFigure, 'push');
            app.MeshButton.ButtonPushedFcn = createCallbackFcn(app, @MeshButtonPushed, true);
            app.MeshButton.Position = [500 262 100 22];
            app.MeshButton.Text = 'Mesh';

            % Create ContourButton
            app.ContourButton = uibutton(app.ThePowerofAppDesignerUIFigure, 'push');
            app.ContourButton.ButtonPushedFcn = createCallbackFcn(app, @ContourButtonPushed, true);
            app.ContourButton.Position = [500 172 100 22];
            app.ContourButton.Text = 'Contour';

            % Create SelectdataDropDownLabel
            app.SelectdataDropDownLabel = uilabel(app.ThePowerofAppDesignerUIFigure);
            app.SelectdataDropDownLabel.HorizontalAlignment = 'right';
            app.SelectdataDropDownLabel.Position = [443 82 66 22];
            app.SelectdataDropDownLabel.Text = 'Select data';

            % Create SelectdataDropDown
            app.SelectdataDropDown = uidropdown(app.ThePowerofAppDesignerUIFigure);
            app.SelectdataDropDown.Items = {'Peaks', 'Membrane', 'Sinc'};
            app.SelectdataDropDown.ValueChangedFcn = createCallbackFcn(app, @SelectdataDropDownValueChanged, true);
            app.SelectdataDropDown.Position = [524 82 100 22];
            app.SelectdataDropDown.Value = 'Peaks';

            % Create UIAxes
            app.UIAxes = uiaxes(app.ThePowerofAppDesignerUIFigure);
            title(app.UIAxes, 'Peaks data in a Surf plot')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.PlotBoxAspectRatio = [1.65315315315315 1 1];
            app.UIAxes.TitleFontWeight = 'bold';
            app.UIAxes.Position = [28 134 416 278];

            % Show the figure after all components are created
            app.ThePowerofAppDesignerUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = yuhangl_Exercise4_app

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.ThePowerofAppDesignerUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.ThePowerofAppDesignerUIFigure)
        end
    end
end