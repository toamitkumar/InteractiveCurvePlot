class CurvePlot

  attr_accessor :delegate, :data, :categories, :graph, :draggable_dot, :drag_dot_selected, :dragged_to_x_coordinate

  def init
    if(super)
      @data = (0..5).to_a#.step(0.1).collect{|n| n}
      @categories = []
    end

    self
  end

  def renderInLayer(hosting_view, withTheme:theme)
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
    create_and_add_static_dot
    create_and_add_draggable_dot
  end


  def numberOfRecordsForPlot(plot)
    if(plot.identifier == "Curve")
      @data.size
    elsif(%w(DraggableDot StaticDot).include?(plot.identifier))
      1
    end
  end

  def numberForPlot(plot, field:field_enum, recordIndex:index)
    num = nil
    case field_enum
    when CPTScatterPlotFieldY
      if(plot.identifier == "Curve")
        num = index
        p "Curve Y - #{num}"
      elsif(plot.identifier == "StaticDot")
        num = 4
        p "Static Y - #{num}"
      elsif(plot.identifier == "DraggableDot")
        num = 3
        p "Draggable Y - #{num}"
      end
    when CPTScatterPlotFieldX
      if(plot.identifier == "Curve")
        num = 4 * index * index
        p "Curve X - #{num}"
      elsif(plot.identifier == "StaticDot")
        num = 64
        p "Static X - #{num}"
      elsif(plot.identifier == "DraggableDot")
        if(@drag_dot_selected)
          num = 4 * @dragged_to_x_coordinate * @dragged_to_x_coordinate
        else
          num = 36
        end
        p "Draggable X - #{num}"
      end
    end
    num
  end

  # This method is called when user touch & drag on the plot space.
  def plotSpace(space, shouldHandlePointingDeviceDraggedEvent:event, atPoint:point)
    point_in_plot_area = @graph.convertPoint(point, toLayer:@graph.plotAreaFrame.plotArea)

    p point
    p point.x
    p point.y

    new_point = Pointer.new(NSDecimal.type, 2)
    @graph.defaultPlotSpace.plotPoint(new_point, forPlotAreaViewPoint:point_in_plot_area)
    NSDecimalRound(new_point, new_point, 0, NSRoundPlain)
    p new_point[0]
    p new_point[1]
    p NSDecimalNumber.decimalNumberWithDecimal(new_point[0]).intValue
    p NSDecimalNumber.decimalNumberWithDecimal(new_point[1]).intValue
    x = NSDecimalNumber.decimalNumberWithDecimal(new_point[0]).intValue

    p x

    if(@drag_dot_selected)
      @dragged_to_x_coordinate = x
      @draggable_dot.reloadData
    end

    true
  end

  def plotSpace(space, willChangePlotRangeTo:new_range, forCoordinate:coordinate)
    p "called willChangePlotRangeTo"

    (coordinate == CPTCoordinateY) ? space.yRange : space.xRange
  end

  def plotSpace(space, shouldHandlePointingDeviceDownEvent:event, atPoint:point)
    @drag_dot_selected = true
    true
  end

  def plotSpace(space, shouldHandlePointingDeviceUpEvent:event, atPoint:point)
    @drag_dot_selected = false
    true
  end

  def scatterPlot(plot, plotSymbolWasSelectedAtRecordIndex:index)
    p "plotSymbolWasSelectedAtRecordIndex -- #{index}"
    if(plot.identifier == "DraggableDot")
      @drag_dot_selected = true
    end
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
    plot_space.allowsUserInteraction = true
    plot_space.delegate = self
  end

  def add_x_axis_set
    x = @graph.axisSet.xAxis

    x.title = "X Axis"
    x.labelingPolicy = CPTAxisLabelingPolicyNone
    x.majorGridLineStyle = grid_line
    x.majorIntervalLength = CPTDecimalFromString("10")
    # x.minorTicksPerInterval = nil

    x.orthogonalCoordinateDecimal = CPTDecimalFromString("0")
    # x.timeOffset = 30.0
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

    y.majorGridLineStyle = grid_line
    y.majorIntervalLength = CPTDecimalFromString("1")
    y.minorTicksPerInterval = 0.5
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

  def create_and_add_static_dot
    static_dot = CPTScatterPlot.alloc.initWithFrame(CGRectNull)
    static_dot.identifier = "StaticDot"

    static_dot_symbol_line_style = CPTMutableLineStyle.lineStyle
    static_dot_symbol_line_style.lineColor = CPTColor.orangeColor

    static_dot_symbol = CPTPlotSymbol.ellipsePlotSymbol
    static_dot_symbol.fill = CPTFill.fillWithColor(CPTColor.orangeColor)
    static_dot_symbol.lineStyle = static_dot_symbol_line_style
    static_dot_symbol.size = CGSizeMake(15.0, 15.0)
    
    static_dot.plotSymbol = static_dot_symbol
    
    static_dot.dataSource = self
    # static_dot.delegate = self
    @graph.addPlot(static_dot)
  end

  def create_and_add_draggable_dot
    @draggable_dot = CPTScatterPlot.alloc.initWithFrame(CGRectNull)
    @draggable_dot.identifier = "DraggableDot"

    draggable_dot_symbol_line_style = CPTMutableLineStyle.lineStyle
    draggable_dot_symbol_line_style.lineColor = CPTColor.grayColor

    draggable_dot_symbol = CPTPlotSymbol.pentagonPlotSymbol
    draggable_dot_symbol.fill = CPTFill.fillWithColor(CPTColor.grayColor)
    draggable_dot_symbol.lineStyle = draggable_dot_symbol_line_style
    draggable_dot_symbol.size = CGSizeMake(17.0, 17.0)
    
    @draggable_dot.plotSymbol = draggable_dot_symbol
    
    @draggable_dot.dataSource = self
    @draggable_dot.delegate = self
    @graph.addPlot(@draggable_dot)
  end

  def grid_line
    major_grid_line = CPTMutableLineStyle.lineStyle
    major_grid_line.lineWidth = 1.0
    major_grid_line.lineColor = CPTColor.lightGrayColor.colorWithAlphaComponent(0.25)
    major_grid_line
  end

end