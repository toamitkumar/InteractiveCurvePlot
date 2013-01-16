class Brand < NanoStore::Model

  attr_accessor :levers

  attribute :name
  attribute :description

  # bag :levers

  def self.create(data)
    p "called"
    object = super

    object.levers = []
    object
  end

  def curves
    start = 0
    levers.collect do |lever|
      start += 1
      {
        :name => lever.name,
        :color => lever.color.to_color.to_cpt_color,
        :static_point => start,
        :draggable_point => start+1,
        :fn => lambda {|p| 0.5 * p * p},
        :data => (0..10).to_a
      }
    end
  end

end