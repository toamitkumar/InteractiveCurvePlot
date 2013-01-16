class Curve

  def self.for_brand(brand)
    [
      {
        :name => "TV",
        :data => (0..10).to_a,
        :color => CPTColor.orangeColor,
        :static_point => 4,
        :draggable_point => 3,
        :fn => lambda {|p| 4 * p * p}
      },
      {
        :name => "Umbrella_TV",
        :data => (0..5).to_a,
        :color => CPTColor.greenColor,
        :static_point => 2,
        :draggable_point => 3,
        :fn => lambda {|p| 0.5 * p * p}
      }
    ]
  end

end