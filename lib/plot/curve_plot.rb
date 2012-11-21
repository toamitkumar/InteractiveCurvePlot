class CurvePlot

  attr_accessor :delegate, :data, :categories, :graph

  def init
    if(super)
      @data = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
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

    
  end

  def add_padding
    @graph.paddingLeft = 90.0
    @graph.paddingTop = 50.0
    @graph.paddingRight = 20.0
    @graph.paddingBottom = 60.0
  end

end