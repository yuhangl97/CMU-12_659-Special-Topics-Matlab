classdef Water_Quality_Correlation_Analysis_GUI_Model_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        GridLayout                matlab.ui.container.GridLayout
        LeftPanel                 matlab.ui.container.Panel
        UIAxes3                   matlab.ui.control.UIAxes
        UITable                   matlab.ui.control.Table
        CenterPanel               matlab.ui.container.Panel
        UIAxes                    matlab.ui.control.UIAxes
        UIAxes2                   matlab.ui.control.UIAxes
        RightPanel                matlab.ui.container.Panel
        TrendAnalysisButton       matlab.ui.control.Button
        EnvironmentDropDownLabel  matlab.ui.control.Label
        EnvironmentDropDown       matlab.ui.control.DropDown
        PCAAnalysisButton         matlab.ui.control.Button
        RDAAnalysisButton         matlab.ui.control.Button
        PredictionAnalysisButton  matlab.ui.control.Button
        LoadCustomEnvironmentalFactorButton  matlab.ui.control.Button
        LoadCustomBiologicalFactorButton  matlab.ui.control.Button
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end

    
    properties (Access = private)
        % initial environmental related data
        envData = []
        envLabel = {};
        % initial biological related data
        bioData = [];
        bioLabel = {};
        
        semi = ['-^','-s','-*','-o','-+','-.','-x','-d','-v','->','-<','-p','-h','-^','-s','-*','-o','-+','-.','-x','-d','-v'];
    end
    
    methods (Access = private)
        
        function results = updateEnvironmentalData(app, fname)
            % For default file, read corresponding file
            if strcmp(fname,'Environmental factor of urban landscape water body supplemented by surface water.xlsx')
                data_0 = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx');
            else
                try
                    data = xlsread(fname);
                catch ME
                    % If problem reading file, display error message
                    uialert(app.UIFigure, ME.message, 'File Error');
                    return;
                end            
            end 
            app.envData = data_0
            [num,txt,raw] = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C1:X1');
            app.envLablel = txt;
        end
        
        function results = updateBiologicalData(app, fname)
            % For default file, read corresponding file
            if strcmp(fname,'Pathogen index of urban landscape water body supplemented by surface water.xlsx')
                data = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx');
            else
                try
                    data = xlsread(fname);
                catch ME
                    % If problem reading file, display error message
                    uialert(app.UIFigure, ME.message, 'File Error');
                    return;
                end            
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            [num,txt,raw] = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C1:X1');
            app.envLabel = txt;
            app.envData = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx');
            [num,txt,raw] = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx','C1:J1')
            app.bioLabel  = txt;
            app.bioData = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx')
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {480, 480, 480};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {480, 480};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {255, '1x', 219};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end

        % Button pushed function: 
        % LoadCustomEnvironmentalFactorButton
        function LoadCustomEnvironmentalFactorButtonPushed(app, event)
            % Display uigetfile dialog
            filterspec = {'*.xlsx; *.csv; *.txt; *.xls','All txt Files'};
            [f, p] = uigetfile(filterspec);
            
            % Make sure user didn't cancel uigetfile dialog
            if (ischar(p))
               fname = [p f];
               updateEnvironmentalData(app, fname);
            end
        end

        % Button pushed function: LoadCustomBiologicalFactorButton
        function LoadCustomBiologicalFactorButtonPushed(app, event)
            % Display uigetfile dialog
            filterspec = {'*.xlsx; *.csv; *.txt; *.xls','All txt Files'};
            [f, p] = uigetfile(filterspec);
            
            % Make sure user didn't cancel uigetfile dialog
            if (ischar(p))
               fname = [p f];
               updateBiologicalData(app, fname);
            end
        end

        % Button pushed function: PCAAnalysisButton
        function PCAAnalysisButtonPushed(app, event)
            pca = f_pca(app.envData, 1, 2);
            f_pcaPlot(pca, [], app.envLabel, 0.05);
            pca = f_pca(X, 1, 2);
            pca = f_pca(y, 1, 2);
            s = {'A1' 'B2' 'A3' 'B4' 'A5' 'B6'};
            f_pcaPlot1(pca,['a'], ylabels, 0.2, 'tex');
            f_pcaPlot1(pca, s, ylabels, 0.2, 'tex');
        end

        % Value changed function: EnvironmentDropDown
        function EnvironmentDropDownValueChanged(app, event)
            [num,txt,raw] = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C1:X1');
            app.envLabel = txt;
            [num,txt,raw] = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx','C1:J1')
            app.bioLabel  = txt;
            value = app.EnvironmentDropDown.Value;
            switch value
                case 'Yueya River'
                    app.envData = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C2:X13');
                    app.bioData = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx', 'C2:J13');
                case 'Lianhua River'
                    app.envData = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C14:X25');
                    app.bioData = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx', 'C14:J25');
                case 'Changhong River'
                    app.envData = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C26:X37');
                    app.bioData = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx', 'C26:J37');
                case 'All Data'
                    app.envData = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx');
                    app.bioData = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx')
            end
        end

        % Button pushed function: TrendAnalysisButton
        function TrendAnalysisButtonPushed(app, event)
            value = app.EnvironmentDropDown.Value;
            switch value
                case 'Yueya River'
                    app.envData = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C2:X13');
                    app.bioData = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx', 'C2:J13');
                case 'Lianhua River'
                    app.envData = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C14:X25');
                    app.bioData = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx', 'C14:J25');
                case 'Changhong River'
                    app.envData = xlsread('Environmental factor of urban landscape water body supplemented by surface water.xlsx', 'C26:X37');
                    app.bioData = xlsread('Pathogen index of urban landscape water body supplemented by surface water.xlsx', 'C26:J37');
            end
            
            % draw the environmental data
            x = 1:12
            for j= 1:22
                plot(app.UIAxes, x, app.envData(1:12,j), app.semi(2*j-1:2*j));
                hold(app.UIAxes, 'on')
            end
            legend(app.UIAxes, app.envLabel, 'FontSize', 6)
            % Turn on the grid
            grid(app.UIAxes, 'on')
            app.UIAxes.XTick = [1 2 3 4 5 6 7 8 9 10 11 12];
            % Add title and axis labels
            title(app.UIAxes, 'Environmental Factor of Water')
            xlabel(app.UIAxes, 'Month')
            ylabel(app.UIAxes, 'Numerical Value')
            hold(app.UIAxes, 'off')
            
            % draw the biological data
            for j= 1:8
                plot(app.UIAxes2, x, app.envData(1:12,j), app.semi(2*j-1:2*j));
                hold(app.UIAxes2, 'on');
            end
            legend(app.UIAxes2, app.bioLabel, 'FontSize', 6)
            % Turn on the grid
            grid(app.UIAxes2, 'on')
            app.UIAxes2.XTick = [1 2 3 4 5 6 7 8 9 10 11 12];
            % Add title and axis labels
            title(app.UIAxes2, 'Biological Factor of Water')
            xlabel(app.UIAxes2, 'Month')
            ylabel(app.UIAxes2, 'Numerical Value')
            hold(app.UIAxes2, 'off')
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 860 480];
            app.UIFigure.Name = 'UI Figure';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {255, '1x', 219};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.LeftPanel);
            title(app.UIAxes3, 'Title')
            xlabel(app.UIAxes3, 'X')
            ylabel(app.UIAxes3, 'Y')
            app.UIAxes3.PlotBoxAspectRatio = [1.58914728682171 1 1];
            app.UIAxes3.TitleFontWeight = 'bold';
            app.UIAxes3.Position = [1 1 254 185];

            % Create UITable
            app.UITable = uitable(app.LeftPanel);
            app.UITable.ColumnName = {'Column 1'; 'Column 2'; 'Column 3'; 'Column 4'};
            app.UITable.RowName = {};
            app.UITable.Position = [0 190 254 289];

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.CenterPanel);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.PlotBoxAspectRatio = [1.83163265306122 1 1];
            app.UIAxes.TitleFontWeight = 'bold';
            app.UIAxes.Position = [7 243 374 231];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.CenterPanel);
            title(app.UIAxes2, 'Title')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            app.UIAxes2.PlotBoxAspectRatio = [1.81564245810056 1 1];
            app.UIAxes2.TitleFontWeight = 'bold';
            app.UIAxes2.Position = [7 9 374 235];

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create TrendAnalysisButton
            app.TrendAnalysisButton = uibutton(app.RightPanel, 'push');
            app.TrendAnalysisButton.ButtonPushedFcn = createCallbackFcn(app, @TrendAnalysisButtonPushed, true);
            app.TrendAnalysisButton.Position = [52 382 117 22];
            app.TrendAnalysisButton.Text = 'Trend Analysis';

            % Create EnvironmentDropDownLabel
            app.EnvironmentDropDownLabel = uilabel(app.RightPanel);
            app.EnvironmentDropDownLabel.HorizontalAlignment = 'right';
            app.EnvironmentDropDownLabel.Position = [18 168 73 22];
            app.EnvironmentDropDownLabel.Text = 'Environment';

            % Create EnvironmentDropDown
            app.EnvironmentDropDown = uidropdown(app.RightPanel);
            app.EnvironmentDropDown.Items = {'All Data', 'Yueya River', 'Lianhua River', 'Changhong River'};
            app.EnvironmentDropDown.ValueChangedFcn = createCallbackFcn(app, @EnvironmentDropDownValueChanged, true);
            app.EnvironmentDropDown.Position = [106 168 100 22];
            app.EnvironmentDropDown.Value = 'All Data';

            % Create PCAAnalysisButton
            app.PCAAnalysisButton = uibutton(app.RightPanel, 'push');
            app.PCAAnalysisButton.ButtonPushedFcn = createCallbackFcn(app, @PCAAnalysisButtonPushed, true);
            app.PCAAnalysisButton.Position = [52 334 117 22];
            app.PCAAnalysisButton.Text = 'PCA Analysis';

            % Create RDAAnalysisButton
            app.RDAAnalysisButton = uibutton(app.RightPanel, 'push');
            app.RDAAnalysisButton.Position = [52 283 117 22];
            app.RDAAnalysisButton.Text = 'RDA Analysis';

            % Create PredictionAnalysisButton
            app.PredictionAnalysisButton = uibutton(app.RightPanel, 'push');
            app.PredictionAnalysisButton.Position = [52 230 117 22];
            app.PredictionAnalysisButton.Text = 'Prediction Analysis';

            % Create LoadCustomEnvironmentalFactorButton
            app.LoadCustomEnvironmentalFactorButton = uibutton(app.RightPanel, 'push');
            app.LoadCustomEnvironmentalFactorButton.ButtonPushedFcn = createCallbackFcn(app, @LoadCustomEnvironmentalFactorButtonPushed, true);
            app.LoadCustomEnvironmentalFactorButton.Position = [7 105 207 22];
            app.LoadCustomEnvironmentalFactorButton.Text = 'Load Custom Environmental Factor';

            % Create LoadCustomBiologicalFactorButton
            app.LoadCustomBiologicalFactorButton = uibutton(app.RightPanel, 'push');
            app.LoadCustomBiologicalFactorButton.ButtonPushedFcn = createCallbackFcn(app, @LoadCustomBiologicalFactorButtonPushed, true);
            app.LoadCustomBiologicalFactorButton.Position = [7 57 206 22];
            app.LoadCustomBiologicalFactorButton.Text = 'Load Custom Biological Factor';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Water_Quality_Correlation_Analysis_GUI_Model_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end