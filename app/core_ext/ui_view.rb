class UIView

  def round_corners(radius=5)
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  end
  
  def show_border(color, width=1)
    layer.borderWidth = width
    layer.borderColor = color.CGColor
  end
  
end