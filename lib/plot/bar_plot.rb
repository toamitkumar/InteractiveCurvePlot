class BarPlot

  def renderInLayer(layerHostingView, withTheme:theme)
    bounds = layerHostingView.bounds

    # create and assign chart to the hosting view.
    graph = CPTXYGraph.alloc.initWithFrame(bounds)
    layerHostingView.hostedGraph = graph
    graph.applyTheme(theme)
    
    graph.plotAreaFrame.masksToBorder = false
    
    graph.paddingLeft = 90.0
    graph.paddingTop = 50.0
    graph.paddingRight = 20.0
    graph.paddingBottom = 60.0
    
    
    # chang the chart layer orders so the axis line is on top of the bar in the chart.
    chart_layers = [
      NSNumber.numberWithInt(CPTGraphLayerTypeAxisLines),  
      NSNumber.numberWithInt(CPTGraphLayerTypePlots),
      NSNumber.numberWithInt(CPTGraphLayerTypeMajorGridLines),
      NSNumber.numberWithInt(CPTGraphLayerTypeMajorGridLines),
      NSNumber.numberWithInt(CPTGraphLayerTypeMinorGridLines),
      NSNumber.numberWithInt(CPTGraphLayerTypeAxisLabels),
      NSNumber.numberWithInt(CPTGraphLayerTypeAxisTitles)
    ]
    graph.topDownLayerOrder = chart_layers
    
    
    # Add plot space for horizontal bar charts
    plotSpace = graph.defaultPlotSpace
    plotSpace.yRange = CPTPlotRange.plotRangeWithLocation(CPTDecimalFromInt(0), length:CPTDecimalFromInt(10000))
    plotSpace.xRange = CPTPlotRange.plotRangeWithLocation(CPTDecimalFromInt(0), length:CPTDecimalFromInt(6))
    
    # Setting X-Axis
    axisSet = graph.axisSet
    x = axisSet.xAxis
    x.labelingPolicy = CPTAxisLabelingPolicyNone
    x.title = "Product from diffrent company"
    x.titleOffset = 30.0
    x.majorTickLineStyle = nil
    x.minorTickLineStyle = nil
    x.majorIntervalLength = CPTDecimalFromString("1")
    x.orthogonalCoordinateDecimal = CPTDecimalFromString("0")
    x.labelExclusionRanges = NSArray.arrayWithObjects(CPTPlotRange.plotRangeWithLocation(CPTDecimalFromInt(6), length:CPTDecimalFromInt(1)))
    
    # Use custom x-axis label so it will display product A, B, C... instead of 1, 2, 3, 4
    labels = []

    sample_product.each do |product|
      label = CPTAxisLabel.alloc.initWithText(product, textStyle:x.labelTextStyle)
      label.tickLocation = CPTDecimalFromInt(idx)
      label.offset = 5.0
      labels << label
    end
    x.axisLabels = NSSet.setWithArray(labels)
    
    // Setting up y-axis
  CPTXYAxis *y = axisSet.yAxis
    y.majorIntervalLength = CPTDecimalFromInt(1000)
    y.minorTicksPerInterval = 0
    y.minorGridLineStyle = nil
    y.title = @"Cost Per Unit"
    y.labelExclusionRanges = [NSArray arrayWithObjects:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(0)], nil]
    
    barChart = [[CPTBarPlot alloc] init]
    barChart.fill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:0.22f green:0.55f blue:0.71f alpha:0.4f]]
    
    CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle]
  borderLineStyle.lineWidth = 2.f
    borderLineStyle.lineColor = [CPTColor colorWithComponentRed:0.22f green:0.55f blue:0.71f alpha:1.0f]

    
    barChart.lineStyle = borderLineStyle
    barChart.barWidth = CPTDecimalFromString(@"0.6")
    barChart.baseValue = CPTDecimalFromString(@"0")
    
    barChart.dataSource = self
    barChart.barCornerRadius = 2.0f
    barChart.identifier = kDefaultPlot
    barChart.delegate = self
    [graph addPlot:barChart toPlotSpace:plotSpace]
    
    //selected Plot
    selectedPlot = [[CPTBarPlot alloc] init]
    selectedPlot.fill = [CPTFill fillWithColor:[[CPTColor orangeColor] colorWithAlphaComponent:0.35f]]
    
    CPTMutableLineStyle *selectedBorderLineStyle = [CPTMutableLineStyle lineStyle]
  selectedBorderLineStyle.lineWidth = 3.0f
    selectedBorderLineStyle.lineColor = [CPTColor orangeColor]
    selectedBorderLineStyle.dashPattern = [NSArray arrayWithObjects:[NSNumber numberWithFloat:10.0f], [NSNumber numberWithFloat:8.0f], nil]
    
    selectedPlot.lineStyle = selectedBorderLineStyle
    selectedPlot.barWidth = CPTDecimalFromString(@"0.6")
    selectedPlot.baseValue = CPTDecimalFromString(@"0")
    
    selectedPlot.dataSource = self
    selectedPlot.barCornerRadius = 2.0f
    selectedPlot.identifier = kSelectedPlot
    selectedPlot.delegate = self
    [graph addPlot:selectedPlot toPlotSpace:plotSpace]
  end

end