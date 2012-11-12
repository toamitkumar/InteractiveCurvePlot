class CorePlotViewController < UIViewController
	
  attr_accessor :barHostingView, :costPerUnitLabel, :selectedProductLabel, :spendingPerYearLabel, :selectedYearLabel, :lineHostingView, :titleLabel

  def viewDidLoad
    super


    default_theme = PlotTheme.alloc.init
    bar_plot = BarPlot.alloc.init
    bar_plot.delegate = self
    bar_plot.renderInLayer(barHostingView, withTheme:default_theme)


  end

  def shouldAutorotateToInterfaceOrientation(toInterfaceOrientation)
    true
  end

end