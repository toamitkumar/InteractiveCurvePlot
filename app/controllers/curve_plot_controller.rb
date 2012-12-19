class CurvePlotController < UIViewController

  attr_accessor :curve_hosting_view, :plot, :horizontal_zoom, :legend

  def viewDidLoad
    super

    theme = CPTTheme.themeNamed KCPTPlainWhiteTheme
    @plot = CurvePlot.alloc.init
    @plot.delegate = self
    @plot.renderInLayer(@curve_hosting_view, withTheme:theme)
    @horizontal_zoom.value = 0

    p @curve_hosting_view.layer.zPosition
    # self.view.bringSubviewToFront(@curve_hosting_view)

    @legend = LegendView.alloc.initWithFrame(CGRectMake(703, 182, 301, 424))
    @legend.backgroundColor = UIColor.whiteColor
    @legend.add([])

    # button = UIButton.alloc.initWithFrame([[703, 182], [200, 100]])
    # self.view.addSubview(button)

    self.view.addSubview(@legend)

    p @legend
  end

  def shouldAutorotateToInterfaceOrientation(toInterfaceOrientation)
    true
  end

  
  def zoom_x(sender)
    @horizontal_zoom.value = sender.value
    p @horizontal_zoom.value
    
    @plot.zoom_x_by(sender.value)
  end


end