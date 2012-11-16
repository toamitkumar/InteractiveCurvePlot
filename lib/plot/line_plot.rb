class LinePlot

  attr_accessor :delegate, :sample_data, :sample_years, :selected_coordination, :line_plot, :touch_plot

  def init
    if(super)
      @sample_date = [6000, 3000, 4500, 2000, 3400, 2100, 1000]
      @sample_years = ["2010", "2011", "2012", "2013", "2014", "2015", "2016"]
    end

    self
  end

  def renderInLayer(layer_hosting_view, withTheme:theme)
    bounds = layerHostingView.bounds

    # create and assign chart to the hosting view.
    graph = CPTXYGraph.alloc.initWithFrame(bounds)
    layerHostingView.hostedGraph = graph
    # graph.applyTheme(CPTTheme.themeNamed KCPTDarkGradientTheme)
    # self.theme = CPTTheme.themeNamed KCPTDarkGradientTheme
    graph.applyTheme(theme)
    
    graph.plotAreaFrame.masksToBorder = false
    
    graph.paddingLeft = 90.0
    graph.paddingTop = 50.0
    graph.paddingRight = 20.0
    graph.paddingBottom = 60.0
    
    
    # chang the chart layer orders so the axis line is on top of the bar in the chart.
    @chart_layers = [NSNumber.numberWithInt(CPTGraphLayerTypePlots), NSNumber.numberWithInt(CPTGraphLayerTypeMajorGridLines), NSNumber.numberWithInt(CPTGraphLayerTypeMinorGridLines), NSNumber.numberWithInt(CPTGraphLayerTypeAxisLines), NSNumber.numberWithInt(CPTGraphLayerTypeAxisLabels), NSNumber.numberWithInt(CPTGraphLayerTypeAxisTitles)]
    graph.topDownLayerOrder = @chart_layers
    
    
    # Add plot space for horizontal bar charts
    plot_space = graph.defaultPlotSpace
    plot_space.delegate = self
    plot_space.allowUserInteraction = true
    y_plot_range = CPTPlotRange.alloc.init
    y_plot_range.location = CPTDecimalFromInt(0)
    y_plot_range.length = CPTDecimalFromInt(10000)
    plot_space.yRange = y_plot_range # CPTPlotRange.plotRangeWithLocation(CPTDecimalFromInt(0), length:CPTDecimalFromInt(10000))
    x_plot_range = CPTPlotRange.alloc.init
    x_plot_range.location = CPTDecimalFromInt(0)
    x_plot_range.length = CPTDecimalFromInt(6)
    plot_space.xRange = x_plot_range

    major_x_grid_line_style = CPTMutableLineStyle.lineStyle
    major_x_grid_line_style.lineWidth = 1.0
    major_x_grid_line_style.lineColor = CPTColor.grayColor.colorWithAlphaComponent(0.25)

    axisSet = graph.axisSet
    x = axisSet.xAxis
    x.labelingPolicy = CPTAxisLabelingPolicyNone
    x.majorGridLineStyle = major_x_grid_line_style
    x.majorIntervalLength = CPTDecimalFromString("1")
    x.minorTicksPerInterval = 1

    x.orthogonalCoordinateDecimal = CPTDecimalFromString("0")
    x.title = "Years"
    x.timeOffset = 30.0
    x_label_exclusion_range = CPTPlotRange.alloc.init
    x_label_exclusion_range.location = CPTDecimalFromInt(0)
    x_label_exclusion_range.length = CPTDecimalFromInt(0)
    x.labelExclusionRanges = [x_label_exclusion_range]

    labels = @sample_years.each_with_index.map do |product, index|
      label = CPTAxisLabel.alloc.initWithText(product, textStyle: x.labelTextStyle)
      label.tickLocation = CPTDecimalFromInt(index)
      label.offset = 5.0
      label
    end
    x.axisLabels = NSSet.setWithArray(labels)

    # Setting up y-axis
    major_y_grid_line_style = CPTMutableLineStyle.lineStyle
    major_y_grid_line_style.lineWidth = 1.0
    major_y_grid_line_style.dashPattern =  [5.0, 5.0]
    major_y_grid_line_style.lineColor = CPTColor.lightGrayColor.colorWithAlphaComponent(0.25)
    
    
    y = axisSet.yAxis
    y.majorGridLineStyle = major_y_grid_line_style
    y.majorIntervalLength = CPTDecimalFromString("1000")
    y.minorTicksPerInterval = 1
    y.orthogonalCoordinateDecimal = CPTDecimalFromString("0")
    y.title = "Consumer Spending"
    y_label_exclusion_range = CPTPlotRange.alloc.init
    y_label_exclusion_range.location = CPTDecimalFromInt(0)
    y_label_exclusion_range.length = CPTDecimalFromInt(0)
    y.labelExclusionRanges = [y_label_exclusion_range]

    # Create a high plot area
    high_plot = CPTScatterPlot.alloc.init
    high_plot.identifier = "HighPlot"
    
    high_line_style = high_plot.dataLineStyle.mutableCopy
    high_line_style.lineWidth = 2
    high_line_style.lineColor = CPTColor.colorWithComponentRed(0.50, green:0.67, blue:0.65, alpha:1.0)
    high_plot.dataLineStyle = high_line_style
    high_plot.dataSource = self
  
    area_fill = CPTFill.fillWithColor(CPTColor.colorWithComponentRed(0.50, green:0.67, blue:0.65, alpha:0.4))
    high_plot.areaFill = areaFill
    high_plot.areaBaseValue = CPTDecimalFromString("0")
    graph.addPlot(high_plot)

    @selected_coordination = 2

    @touch_plot = CPTScatterPlot.alloc.initWithFrame(CGRectNull)
    @touch_plot.identifier = "LinePlot"
    @touch_plot.dataSource = self
    @touch_plot.delegate = self
    applyTouchPlotColor
    graph.addPlot(@touch_plot)
  end

  # Assign different color to the touchable line symbol.
  def applyTouchPlotColor
    touch_plot_color = CPTColor.orangeColor

    savings_plot_line_style = CPTMutableLineStyle.lineStyle
    savings_plot_line_style.lineColor = touch_plot_color
    
    touch_plot_symbol = CPTPlotSymbol.ellipsePlotSymbol
    touch_plot_symbol.fill = CPTFill.fillWithColor(touch_plot_color)
    touch_plot_symbol.lineStyle = savings_plot_line_style
    touch_plot_symbol.size = CGSizeMake(15.0, 15.0)
    
    
    touchPlot.plotSymbol = touch_plot_symbol;
    
    touch_line_style = CPTMutableLineStyle.lineStyle
    touch_line_style.lineColor = CPTColor.orangeColor
    touch_line_style.lineWidth = 5.0
    
    @touch_plot.dataLineStyle = touch_line_style
  end

  # Highlight the touch plot when the user holding tap on the line symbol.
  def applyHighLightPlotColor(plot)
    selected_plot_color = CPTColor.redColor
    
    symbol_line_style = CPTMutableLineStyle.lineStyle
    symbol_line_style.lineColor = selected_plot_color
    
    plot_symbol = CPTPlotSymbol.ellipsePlotSymbol
    plot_symbol.fill = CPTFill.fillWithColor(selected_plot_color)
    plot_symbol.lineStyle = symbol_line_style
    plot_symbol.size = CGSizeMake(15.0, 15.0)
    
    plot.plotSymbol = plot_symbol;
    
    CPTMutableLineStyle *selectedLineStyle = [CPTMutableLineStyle lineStyle];
    selectedLineStyle.lineColor = [CPTColor yellowColor];
    selectedLineStyle.lineWidth = 5.0f;
    
    plot.dataLineStyle = selectedLineStyle;
  end


end