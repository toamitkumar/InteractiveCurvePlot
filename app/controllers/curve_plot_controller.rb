class CurvePlotController < UIViewController

  attr_accessor :curve_hosting_view, :plot, :horizontal_zoom, :legend_view, :vertical_zoom

  attr_reader :horizontal_zoom_value, :vertical_zoom_value

  def viewDidLoad
    super

    theme = CPTTheme.themeNamed KCPTPlainWhiteTheme
    @plot = CurvePlot.alloc.init
    @plot.delegate = self
    @plot.renderInLayer(@curve_hosting_view, withTheme:theme, andCurves:curves)
    @horizontal_zoom.value = @horizontal_zoom_value = 0
    @curve_hosting_view.round_corners(8)

    @legend_view.add(lever_names)
    @legend_view.round_corners(8)
    self.view.addSubview(@legend)

    trans = CGAffineTransformMakeRotation(Math::PI * 0.5)
    @vertical_zoom.value = @vertical_zoom_value = 1
    @vertical_zoom.transform = trans
    @vertical_zoom.setFrame([[16, 200], [23, 500]])
  end

  def shouldAutorotateToInterfaceOrientation(toInterfaceOrientation)
    true
  end

  
  def zoom_x(sender)
    return if(@horizontal_zoom_value == sender.value)

    @horizontal_zoom.value = sender.value

    (@horizontal_zoom_value < sender.value) ? @plot.zoom_in_x_by(sender.value) : @plot.zoom_out_x_by(sender.value)

    @horizontal_zoom_value = @horizontal_zoom.value
  end

  def zoom_y(sender)
    p sender
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