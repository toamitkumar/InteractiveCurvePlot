class CurvePlotController < UIViewController

  attr_accessor :curve_hosting_view, :plot, :horizontal_zoom, :legend_view

  def viewDidLoad
    super

    theme = CPTTheme.themeNamed KCPTPlainWhiteTheme
    @plot = CurvePlot.alloc.init
    @plot.delegate = self
    @plot.renderInLayer(@curve_hosting_view, withTheme:theme)
    @horizontal_zoom.value = 0

    @legend_view.add(["TV", "Umbrella TV", "OOH", "Display", "Facebook", "Umbrella Viral FB", "Positive Social GRP"])
    self.view.addSubview(@legend)
  end

  def shouldAutorotateToInterfaceOrientation(toInterfaceOrientation)
    true
  end

  
  def zoom_x(sender)
    @horizontal_zoom.value = sender.value    
    @plot.zoom_x_by(sender.value)
  end

end