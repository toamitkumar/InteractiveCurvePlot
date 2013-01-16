class LegendView < UIView

  attr_accessor :legends, :accordion

  def add(legends)

    @accordion = Accordion.alloc.initWithFrame([[5, 5], [self.frame.size.width-10, self.frame.size.height-10]])

    self.addSubview(@accordion)

    legends.each do |legend|
      add_view(legend)
    end

    @accordion.set_selected_index(-1)

    @accordion.setNeedsLayout
  end

  def add_view(header_name)
    header = UIButton.alloc.initWithFrame(CGRectMake(0, 0, 0, 30))
    header.setTitle(header_name, forState:UIControlStateNormal)
    header.setTitleColor(UIColor.darkGrayColor, forState:UIControlStateNormal)
    header.backgroundColor = UIColor.whiteColor
    header.round_corners
    header.show_border("#dedfe1".to_color, 1)

    view = UIView.alloc.initWithFrame(CGRectMake(0, 0, 0, 100))
    view.backgroundColor = UIColor.lightGrayColor
    view.round_corners
    view.show_border("#dedfe1".to_color, 1)

    @accordion.add_header(header, withView:view)
  end

end