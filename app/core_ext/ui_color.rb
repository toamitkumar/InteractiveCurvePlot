class UIColor
  def to_cpt_color
    CPTColor.alloc.initWithColor(self.CGColor)
  end
end