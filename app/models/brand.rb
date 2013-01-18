class Brand < NanoStore::Model

  attr_accessor :levers

  attribute :name
  attribute :description

  # bag :levers

  def self.create(data)
    object = super

    object.levers = []
    object
  end

  def curves
    start = 0
    levers.collect do |lever|
      start += 1
      func = case start
      when 1
        lambda {|p| 0.5 * p * p}
      when 2
        lambda {|p| 5 * p * p}
      when 3
        lambda {|p| 3.0 * p * p}
      when 4
        lambda {|p| 7 * p * p}
      when 5
        lambda {|p| p * p}
      when 6
        lambda {|p| 0.1 * p * p}
      when 7
        lambda {|p| 1}
      when 8
        lambda {|p| 10.5 * p * p}
      end
      {
        :name => lever.name,
        :color => lever.color.to_color.to_cpt_color,
        :static_point => 1,
        :draggable_point => 2,
        :fn => func,
        :data => (0..10).to_a
      }
    end
  end

end