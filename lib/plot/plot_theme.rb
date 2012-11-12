class PlotTheme < CPTTheme

  def defaultName
    "SampleTheme"
  end

  026701007589

  def applyThemeToAxisSet(axisSet)
    title_text = CPTMutableTextStyle.textStyle
    title_text.color = CPTColor.blackColor
    title_text.fontSize = 18

    major_line_style = CPTMutableLineStyle.lineStyle
    major_line_style.lineCap = kCGLineCapRound
    major_line_style.lineColor = CPTColor.blackColor
    major_line_style.lineWidth = 3.0

    minor_line_style = CPTMutableLineStyle.lineStyle
    minor_line_style.lineColor = CPTColor blackColor
    minor_line_style.lineWidth = 3.0

    major_tick_style = CPTMutableLineStyle.lineStyle
    major_tick_style.lineWidth = 3.0
    major_tick_style.lineColor = CPTColor.blackColor
    
    minor_tick_style = CPTMutableLineStyle.lineStyle
    minor_tick_style.lineWidth = 3.0
    minor_tick_style.lineColor = CPTColor.blackColor

    major_grid_line_style = CPTMutableLineStyle.lineStyle
    major_grid_line_style.lineWidth = 1.0
    major_grid_line_style.lineColor = CPTColor.blackColor(colorWithAlphaComponent:0.25)
    
    minor_grid_line_style = CPTMutableLineStyle.lineStyle
    minor_grid_line_style.lineWidth = 1.0
    minor_grid_line_style.lineColor = CPTColor.blackColor(colorWithAlphaComponent:0.15)

    x_label_text_style = CPTMutableTextStyle.textStyle
    x_label_text_style.color = CPTColor.blackColor
    x_label_text_style.fontSize = 16
    
    y_label_text_style = CPTMutableTextStyle.textStyle
    y_label_text_style.color = CPTColor.blackColor
    y_label_text_style.fontSize = 16
    
    x = axisSet.xAxis
    white_text_style = CPTMutableTextStyle.alloc.init
    white_text_style.color = CPTColor.blackColor
    white_text_style.fontSize = 14.0

    minor_tick_white_text_style = CPTMutableTextStyle.alloc.init
    minor_tick_white_text_style.color = CPTColor.blackColor
    minor_tick_white_text_style.fontSize = 12.0

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
    
    currency_formatter = NSNumberFormatter.alloc.init
    currency_formatter.setNumberStyle(NSNumberFormatterCurrencyStyle)
    currency_formatter.setGroupingSeparator(",")
    currency_formatter.setGroupingSize(3)
    currency_formatter.setMaximumFractionDigits(0)

    y.labelFormatter = currency_formatter







    # CPTMutableTextStyle *titleText = CPTMutableTextStyle textStyle
    # titleText.color = CPTColor blackColor
    # titleText.fontSize = 18
    # titleText.fontName = @"Ingleby-BoldItalic"
    
    # CPTMutableLineStyle *majorLineStyle = CPTMutableLineStyle lineStyle
    # majorLineStyle.lineCap = kCGLineCapRound
    # majorLineStyle.lineColor = CPTColor blackColor
    # majorLineStyle.lineWidth = 3.0
    
    # CPTMutableLineStyle *minorLineStyle = CPTMutableLineStyle lineStyle
    # minorLineStyle.lineColor = CPTColor blackColor
    # minorLineStyle.lineWidth = 3.0
    
    # CPTMutableLineStyle *majorTickLineStyle = CPTMutableLineStyle lineStyle
    # majorTickLineStyle.lineWidth = 3.0f
    # majorTickLineStyle.lineColor = CPTColor blackColor
    
    # CPTMutableLineStyle *minorTickLineStyle = CPTMutableLineStyle lineStyle
    # minorTickLineStyle.lineWidth = 3.0f
    # minorTickLineStyle.lineColor = CPTColor blackColor
    
    # // Create grid line styles
    # CPTMutableLineStyle *majorGridLineStyle = CPTMutableLineStyle lineStyle
    # majorGridLineStyle.lineWidth = 1.0f
    # majorGridLineStyle.lineColor = CPTColor blackColor colorWithAlphaComponent:0.25
    
    # CPTMutableLineStyle *minorGridLineStyle = CPTMutableLineStyle lineStyle
    # minorGridLineStyle.lineWidth = 1.0f
    # minorGridLineStyle.lineColor = CPTColor blackColor colorWithAlphaComponent:0.15    
    # //minorGridLineStyle.dashPattern = NSArray arrayWithObjects:NSNumber numberWithFloat:5.0f, NSNumber numberWithFloat:5.0f, nil
    
  
    # CPTMutableTextStyle *xLabelTextStyle = CPTMutableTextStyle textStyle
    # xLabelTextStyle.color = CPTColor blackColor
    # xLabelTextStyle.fontSize = 16
    # xLabelTextStyle.fontName = @"Ingleby"
    
    # CPTMutableTextStyle *yLabelTextStyle = CPTMutableTextStyle textStyle
    # yLabelTextStyle.color = CPTColor blackColor
    # yLabelTextStyle.fontSize = 16
    # yLabelTextStyle.fontName = @"Ingleby"
    
    # CPTXYAxis *x = axisSet.xAxis
    # CPTMutableTextStyle *whiteTextStyle = CPTMutableTextStyle alloc init autorelease
    # whiteTextStyle.color = CPTColor blackColor
    # whiteTextStyle.fontSize = 14.0
    # CPTMutableTextStyle *minorTickWhiteTextStyle = CPTMutableTextStyle alloc init autorelease
    # minorTickWhiteTextStyle.color = CPTColor blackColor
    # minorTickWhiteTextStyle.fontSize = 12.0
    
    # x.labelingPolicy = CPTAxisLabelingPolicyFixedInterval
    # x.majorIntervalLength = CPTDecimalFromDouble(0.5)
    # x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0)
    # x.tickDirection = CPTSignNone
    # x.minorTicksPerInterval = 4
    # x.majorTickLineStyle = majorTickLineStyle
    # x.minorTickLineStyle = minorTickLineStyle
    # x.axisLineStyle = majorLineStyle
    # x.majorTickLength = 7.0
    # x.minorTickLength = 5.0
    # x.labelTextStyle = xLabelTextStyle 
    # x.minorTickLabelTextStyle = whiteTextStyle 
    # x.titleTextStyle = titleText
    
    # CPTXYAxis *y = axisSet.yAxis
    # y.labelingPolicy = CPTAxisLabelingPolicyFixedInterval
    # y.majorIntervalLength = CPTDecimalFromDouble(0.5)
    # y.minorTicksPerInterval = 4
    # y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0)
    # y.tickDirection = CPTSignNone
    # y.majorTickLineStyle = majorTickLineStyle
    # y.minorTickLineStyle = minorTickLineStyle
    # y.axisLineStyle = majorLineStyle
    # y.majorTickLength = 15.0
    # y.minorTickLength = 5.0
    # y.majorGridLineStyle = majorGridLineStyle
    # y.minorGridLineStyle = minorGridLineStyle
    # y.labelTextStyle = yLabelTextStyle
    # y.minorTickLabelTextStyle = minorTickWhiteTextStyle 
    # y.titleTextStyle = titleText
    # y.titleOffset = 58.0f
    
    # NSNumberFormatter *currencyFormatter = NSNumberFormatter alloc init
    # currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle
    # currencyFormatter setGroupingSeparator:@","
    # currencyFormatter setGroupingSize:3
    # currencyFormatter setMaximumFractionDigits:0

    # y.labelFormatter = currencyFormatter
  end

end