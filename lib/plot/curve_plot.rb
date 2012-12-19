class CurvePlot

  attr_accessor :delegate, :graph, :draggable_points, :drag_point_selected, :dragged_to_y_coordinate, :curves, :drag_start
  def init
    if(super)
      # @data = (0..10).to_a
      @curves = [
        {
          :name => "TV",
          :data => (0..10).to_a,
          :color => CPTColor.orangeColor,
          :static_point => 4,
          :draggable_point => 3,
          :fn => lambda {|p| 4 * p * p}
        },
        {
          :name => "Umbrella_TV",
          :data => (0..5).to_a,
          :color => CPTColor.greenColor,
          :static_point => 2,
          :draggable_point => 3,
          :fn => lambda {|p| 0.5 * p * p}
        }
      ]
      @draggable_points = {}
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
    create_and_add_static_point
    create_and_add_draggable_point
  end

  def zoom_x_by(percent)
    space = @graph.defaultPlotSpace
    new_x_range = space.xRange.mutableCopy
    p new_x_range.lengthDouble
    new_x_range.setLength(CPTDecimalFromDouble(new_x_range.lengthDouble - percent))
    p new_x_range.lengthDouble
    space.xRange  = new_x_range
  end


  def numberOfRecordsForPlot(plot)
    if(plot.identifier =~ /DraggablePoint/ or plot.identifier =~ /StaticPoint/)
      1
    else
      p plot.identifier
      curve = @curves.select{|c| ("Curve_#{c[:name]}" == plot.identifier)}.first
      curve[:data].size
    end
  end

  def numberForPlot(plot, field:field_enum, recordIndex:index)
    num = nil
    curve = @curves.select{|c| ("Curve_#{c[:name]}" == plot.identifier or "StaticPoint_#{c[:name]}" == plot.identifier or "DraggablePoint_#{c[:name]}" == plot.identifier)}.first

    case field_enum
    when CPTScatterPlotFieldY
      if(plot.identifier =~ /Curve/)
        num = index
      elsif(plot.identifier =~ /StaticPoint/)
        num = curve[:static_point]
      elsif(plot.identifier =~ /DraggablePoint/)
        if(@drag_start)
          num = @dragged_to_y_coordinate
        else
          num = curve[:draggable_point]
        end
      end
    when CPTScatterPlotFieldX
      if(plot.identifier =~ /Curve/)
        num = curve[:fn].call(index)
      elsif(plot.identifier =~ /StaticPoint/)
        num = curve[:fn].call(curve[:static_point])
      elsif(plot.identifier =~ /DraggablePoint/)
        if(@drag_start)
          num = curve[:fn].call(@dragged_to_y_coordinate)
        else
          num = curve[:fn].call(curve[:draggable_point])
        end
      end
    end
    num
  end

  # This method is called when user touch & drag on the plot space.
  def plotSpace(space, shouldHandlePointingDeviceDraggedEvent:event, atPoint:point)
    if(@drag_start and @drag_point_selected)
      point_in_plot_area = @graph.convertPoint(point, toLayer:@graph.plotAreaFrame.plotArea)

      # p point_in_plot_area

      # new_point = Pointer.new(NSDecimal.type, 2)
      # @graph.defaultPlotSpace.plotPoint(new_point, forPlotAreaViewPoint:point_in_plot_area)
      # NSDecimalRound(new_point, new_point, 0, NSRoundPlain)
      # x = NSDecimalNumber.decimalNumberWithDecimal(new_point[0])
      # y = NSDecimalNumber.decimalNumberWithDecimal(new_point[1])

      bounds_size = @graph.plotAreaFrame.plotArea.bounds.size

      x = point_in_plot_area.x / bounds_size.width
      x = x * @graph.defaultPlotSpace.xRange.lengthDouble
      x = x + @graph.defaultPlotSpace.xRange.locationDouble

      y = point_in_plot_area.y / bounds_size.height
      y = y * @graph.defaultPlotSpace.yRange.lengthDouble
      y = y + @graph.defaultPlotSpace.yRange.locationDouble

      # if(@drag_start)
        @dragged_to_y_coordinate = y
        @drag_point_selected.reloadData
      # end
    end

    true
  end

  def plotSpace(space, willChangePlotRangeTo:new_range, forCoordinate:coordinate)
    p "called willChangePlotRangeTo"

    (coordinate == CPTCoordinateY) ? space.yRange : space.xRange
  end

  def plotSpace(space, shouldHandlePointingDeviceDownEvent:event, atPoint:point)
    p "shouldHandlePointingDeviceDownEvent"
    @drag_start = true
    @drag_point_selected = nil
    false
  end

  def plotSpace(space, shouldHandlePointingDeviceUpEvent:event, atPoint:point)
    p "shouldHandlePointingDeviceUpEvent"
    @drag_start = false
    @drag_point_selected = nil
    false
  end

  def scatterPlot(plot, plotSymbolWasSelectedAtRecordIndex:index)
    p "plotSymbolWasSelectedAtRecordIndex -- #{index}"
    curve = @curves.select{|c| ("DraggablePoint_#{c[:name]}" == plot.identifier)}.first
    if(curve)
      @drag_start = true

      @drag_point_selected = @draggable_points["DraggablePoint_#{curve[:name]}"]
    end

    true
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
    @curves.each do |c|
      curve = CPTScatterPlot.alloc.init
      curve.identifier = "Curve_#{c[:name]}"
      # curve.interpolation = CPTScatterPlotInterpolationCurved
      curve_line_style = CPTMutableLineStyle.lineStyle
      curve_line_style.lineColor = c[:color]
      curve_line_style.lineWidth = 5.0
      
      curve.dataLineStyle = curve_line_style

      curve.dataSource = self
      curve.delegate = self
      @graph.addPlot(curve)
    end
  end

  def create_and_add_static_point
    @curves.each do |c|
      static_point = CPTScatterPlot.alloc.initWithFrame(CGRectNull)
      static_point.identifier = "StaticPoint_#{c[:name]}"

      static_point_symbol_line_style = CPTMutableLineStyle.lineStyle
      static_point_symbol_line_style.lineColor = c[:color]

      static_point_symbol = CPTPlotSymbol.ellipsePlotSymbol
      static_point_symbol.fill = CPTFill.fillWithColor(c[:color])
      static_point_symbol.lineStyle = static_point_symbol_line_style
      static_point_symbol.size = CGSizeMake(15.0, 15.0)
      
      static_point.plotSymbol = static_point_symbol
      
      static_point.dataSource = self
      # static_point.delegate = self
      @graph.addPlot(static_point)
    end
  end

  def create_and_add_draggable_point
    @curves.each do |c|
      draggable_point = CPTScatterPlot.alloc.initWithFrame(CGRectNull)
      draggable_point.identifier = "DraggablePoint_#{c[:name]}"

      draggable_point_symbol_line_style = CPTMutableLineStyle.lineStyle
      draggable_point_symbol_line_style.lineColor = CPTColor.grayColor

      draggable_point_symbol = CPTPlotSymbol.pentagonPlotSymbol
      draggable_point_symbol.fill = CPTFill.fillWithColor(CPTColor.grayColor)
      draggable_point_symbol.lineStyle = draggable_point_symbol_line_style
      draggable_point_symbol.size = CGSizeMake(17.0, 17.0)
      
      draggable_point.plotSymbol = draggable_point_symbol
      
      draggable_point.dataSource = self
      draggable_point.delegate = self
      @graph.addPlot(draggable_point)

      @draggable_points["DraggablePoint_#{c[:name]}"] = draggable_point
    end
  end

  def grid_line
    major_grid_line = CPTMutableLineStyle.lineStyle
    major_grid_line.lineWidth = 1.0
    major_grid_line.lineColor = CPTColor.lightGrayColor.colorWithAlphaComponent(0.25)
    major_grid_line
  end

end