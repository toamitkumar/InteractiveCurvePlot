class CurvePlotController < UIViewController

  attr_accessor :curve_hosting_view, :plot, :horizontal_zoom, :legend_view, :vertical_zoom

  def viewDidLoad
    super

    theme = CPTTheme.themeNamed KCPTPlainWhiteTheme
    @plot = CurvePlot.alloc.init
    @plot.delegate = self
    @plot.renderInLayer(@curve_hosting_view, withTheme:theme, andCurves:curves)
    @horizontal_zoom.value = 0
    @curve_hosting_view.round_corners(8)

    @legend_view.add(lever_names)
    @legend_view.round_corners(8)
    self.view.addSubview(@legend)

    trans = CGAffineTransformMakeRotation(Math::PI * 0.5)
    # @vertical_zoom.value = 0
    # @vertical_zoom.transform = trans
  end

  def shouldAutorotateToInterfaceOrientation(toInterfaceOrientation)
    true
  end

  
  def zoom_x(sender)
    @horizontal_zoom.value = sender.value    
    @plot.zoom_x_by(sender.value)
  end

  def curves
    @brands = App.delegate.instance_variable_get(:@brands)

    @brands[0].curves
  end

  def lever_names
    @brands = App.delegate.instance_variable_get(:@brands)

    @brands[0].levers.collect(&:name)
  end

end