class CurvePlot

  attr_accessor :delegate, :data, :categories, :graph

  def init
    if(super)
      @data = (0..10).to_a#.step(0.1).collect{|n| n}
      @categories = []
    end

    self
  end

  def render(hosting_view, withTheme:theme)
    bounds = hosting_view.bounds

    # create and assign chart to the hosting view.
    @graph = CPTXYGraph.alloc.initWithFrame(bounds)
    hosting_view.hostedGraph = @graph

    @graph.applyTheme(theme)
    
    @graph.plotAreaFrame.masksToBorder = false
    add_padding

    # chang the chart layer orders so the axis line is on top of the line in the chart.
    @chart_layers = [NSNumber.numberWithInt(CPTGraphLayerTypeAxisLines), NSNumber.numberWithInt(CPTGraphLayerTypePlots), NSNumber.numberWithInt(CPTGraphLayerTypeMajorGridLines), NSNumber.numberWithInt(CPTGraphLayerTypeMinorGridLines), NSNumber.numberWithInt(CPTGraphLayerTypeAxisLabels), NSNumber.numberWithInt(CPTGraphLayerTypeAxisTitles)]
    @graph.topDownLayerOrder = @chart_layers

    add_plot_space

    add_x_axis_set
    add_y_axis_set
    create_and_add_plot
    create_and_add_dot
    create_and_add_draggable_dot
  end


  def numberOfRecordsForPlot(plot)
    if(plot.identifier == "Curve")
      @data.size
    elsif(plot.identifier == "StaticDot")
      1
    end
  end

  def numberForPlot(plot, field:field_enum, recordIndex:index)
    num = nil
    case field_enum
    when CPTScatterPlotFieldY
      if(plot.identifier == "Curve")
        num = index
      elsif(plot.identifier == "StaticDot")
        num = 4
      end
    when CPTScatterPlotFieldX
      if(plot.identifier == "Curve")
        num = 4 * index * index
      elsif(plot.identifier == "StaticDot")
        num = 64
      end
    end
    num
  end

  private

  def add_padding
    @graph.paddingLeft = 90.0
    @graph.paddingTop = 50.0
    @graph.paddingRight = 20.0
    @graph.paddingBottom = 60.0
  end

  def add_plot_space
    plot_space = @graph.defaultPlotSpace
    plot_space.yRange = plot_space_range(0, 6)
    plot_space.xRange = plot_space_range(0, 100)
  end

  def add_x_axis_set
    x = @graph.axisSet.xAxis
    x.title = "X Axis"
    x.labelingPolicy = CPTAxisLabelingPolicyNone
    x.majorGridLineStyle = nil
    x.majorIntervalLength = CPTDecimalFromString("10")
    # x.minorTicksPerInterval = nil

    x.orthogonalCoordinateDecimal = CPTDecimalFromString("0")
    x.timeOffset = 30.0
    x_label_exclusion_range = CPTPlotRange.alloc.init
    x_label_exclusion_range.location = CPTDecimalFromInt(0)
    x_label_exclusion_range.length = CPTDecimalFromInt(0)
    x.labelExclusionRanges = [x_label_exclusion_range]

    # labels = @sample_years.each_with_index.map do |product, index|
    #   label = CPTAxisLabel.alloc.initWithText(product, textStyle: x.labelTextStyle)
    #   label.tickLocation = CPTDecimalFromInt(index)
    #   label.offset = 5.0
    #   label
    # end
    # x.axisLabels = NSSet.setWithArray(labels)
  end

  def add_y_axis_set
    y = @graph.axisSet.yAxis
    y.majorGridLineStyle = nil
    y.majorIntervalLength = CPTDecimalFromString("10")
    y.minorTicksPerInterval = 1
    y.orthogonalCoordinateDecimal = CPTDecimalFromString("0")
    y.title = "Y Axis"
    y_label_exclusion_range = CPTPlotRange.alloc.init
    y_label_exclusion_range.location = CPTDecimalFromInt(0)
    y_label_exclusion_range.length = CPTDecimalFromInt(0)
    y.labelExclusionRanges = [y_label_exclusion_range]
  end

  def plot_space_range(location, length)
    plot_range = CPTPlotRange.alloc.init
    plot_range.location = CPTDecimalFromInt(location)
    plot_range.length = CPTDecimalFromInt(length)
    plot_range
  end

  def create_and_add_plot
    curve = CPTScatterPlot.alloc.init
    curve.identifier = "Curve"
    curve_line_style = CPTMutableLineStyle.lineStyle
    curve_line_style.lineColor = CPTColor.orangeColor
    curve_line_style.lineWidth = 5.0
    
    curve.dataLineStyle = curve_line_style

    curve.dataSource = self
    curve.delegate = self
    @graph.addPlot(curve)
  end

  def create_and_add_dot
    static_dot = CPTScatterPlot.alloc.init
    static_dot.identifier = "StaticDot"

    static_dot_symbol_line_style = CPTMutableLineStyle.lineStyle
    static_dot_symbol_line_style.lineColor = CPTColor.orangeColor

    static_dot_symbol = CPTPlotSymbol.ellipsePlotSymbol
    static_dot_symbol.fill = CPTFill.fillWithColor(CPTColor.orangeColor)
    static_dot_symbol.lineStyle = static_dot_symbol_line_style
    static_dot_symbol.size = CGSizeMake(15.0, 15.0)
    
    static_dot.plotSymbol = static_dot_symbol
    
    static_dot.dataSource = self
    static_dot.delegate = self
    @graph.addPlot(static_dot)
  end

  def create_and_add_draggable_dot

  end

end