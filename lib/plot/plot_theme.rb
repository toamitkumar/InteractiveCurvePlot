class PlotTheme < CPTTheme

  def defaultName
    "SampleTheme"
  end

  def applyThemeToAxisSet(axisSet)
    title_text = CPTMutableTextStyle.textStyle
    title_text.color = CPTColor.blackColor
    title_text.fontSize = 18

    major_line_style = CPTMutableLineStyle.lineStyle
    # major_line_style.lineCap = kCGLineCapRound
    major_line_style.lineColor = CPTColor.blackColor
    major_line_style.lineWidth = 3.0

    minor_line_style = CPTMutableLineStyle.lineStyle
    minor_line_style.lineColor = CPTColor.blackColor
    minor_line_style.lineWidth = 3.0

    major_tick_style = CPTMutableLineStyle.lineStyle
    major_tick_style.lineWidth = 3.0
    major_tick_style.lineColor = CPTColor.blackColor
    
    minor_tick_style = CPTMutableLineStyle.lineStyle
    minor_tick_style.lineWidth = 3.0
    minor_tick_style.lineColor = CPTColor.blackColor

    major_grid_line_style = CPTMutableLineStyle.lineStyle
    major_grid_line_style.lineWidth = 1.0
    major_grid_line_style.lineColor = CPTColor.blackColor #(colorWithAlphaComponent:0.25)
    
    minor_grid_line_style = CPTMutableLineStyle.lineStyle
    minor_grid_line_style.lineWidth = 1.0
    minor_grid_line_style.lineColor = CPTColor.blackColor #(colorWithAlphaComponent:0.15)

p "1111111"

    x_label_text_style = CPTMutableTextStyle.textStyle
    x_label_text_style.color = CPTColor.blackColor
    x_label_text_style.fontSize = 16
    
    y_label_text_style = CPTMutableTextStyle.textStyle
    y_label_text_style.color = CPTColor.blackColor
    y_label_text_style.fontSize = 16

    minor_tick_white_text_style = CPTMutableTextStyle.alloc.init
    minor_tick_white_text_style.color = CPTColor.blackColor
    minor_tick_white_text_style.fontSize = 12.0

p "222222"

    x = axisSet.xAxis
    white_text_style = CPTMutableTextStyle.alloc.init
    white_text_style.color = CPTColor.blackColor
    white_text_style.fontSize = 14.0

    x.labelingPolicy = CPTAxisLabelingPolicyFixedInterval
    x.majorIntervalLength = CPTDecimalFromDouble(0.5)
    x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0)
    x.tickDirection = CPTSignNone
    x.minorTicksPerInterval = 4
    x.majorTickLineStyle = major_tick_style
    x.minorTickLineStyle = minor_tick_style
    x.axisLineStyle = major_line_style
    x.majorTickLength = 7.0
    x.minorTickLength = 5.0
    x.labelTextStyle = x_label_text_style 
    x.minorTickLabelTextStyle = white_text_style 
    x.titleTextStyle = title_text

p "33333"

    y = axisSet.yAxis
    y.labelingPolicy = CPTAxisLabelingPolicyFixedInterval
    y.majorIntervalLength = CPTDecimalFromDouble(0.5)
    y.minorTicksPerInterval = 4
    y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0)
    y.tickDirection = CPTSignNone
    y.majorTickLineStyle = major_tick_style
    y.minorTickLineStyle = minor_tick_style
    y.axisLineStyle = major_line_style
    y.majorTickLength = 15.0
    y.minorTickLength = 5.0
    y.majorGridLineStyle = major_grid_line_style
    y.minorGridLineStyle = minor_grid_line_style
    y.labelTextStyle = y_label_text_style
    y.minorTickLabelTextStyle = minor_tick_white_text_style 
    y.titleTextStyle = title_text
    y.titleOffset = 58.0

p "444444"

    @currency_formatter = NSNumberFormatter.alloc.init
    @currency_formatter.setNumberStyle(NSNumberFormatterCurrencyStyle)
    @currency_formatter.setGroupingSeparator(",")
    @currency_formatter.setGroupingSize(3)
    @currency_formatter.setMaximumFractionDigits(0)

    y.labelFormatter = @currency_formatter
  end

end