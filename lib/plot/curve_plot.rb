class CurvePlot

  attr_accessor :delegate, :data, :categories, :graph

  def init
    if(super)
      @data = (0..100).step(0.1).collect{|n| n}
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

    add_axis_set(@graph.axisSet.xAxis)
  end

  def add_padding
    @graph.paddingLeft = 90.0
    @graph.paddingTop = 50.0
    @graph.paddingRight = 20.0
    @graph.paddingBottom = 60.0
  end

  def add_plot_space
    plot_space = @graph.defaultPlotSpace
    y_plot_range = CPTPlotRange.alloc.init
    y_plot_range.location = CPTDecimalFromInt(0)
    y_plot_range.length = CPTDecimalFromInt(6)
    plot_space.yRange = y_plot_range
    x_plot_range = CPTPlotRange.alloc.init
    x_plot_range.location = CPTDecimalFromInt(0)
    x_plot_range.length = CPTDecimalFromInt(100)
    plot_space.xRange = x_plot_range
  end

  def add_axis_set(aixs, )

  end

end