class CurvePlotController < UIViewController

  attr_accessor :curve_hosting_view, :plot

  def viewDidLoad
    super

    theme = CPTTheme.themeNamed KCPTPlainWhiteTheme
    @plot = CurvePlot.alloc.init
    @plot.delegate = self
    @plot.render(curve_hosting_view, withTheme:theme)
  end

  def shouldAutorotateToInterfaceOrientation(toInterfaceOrientation)
    true
  end

  

end