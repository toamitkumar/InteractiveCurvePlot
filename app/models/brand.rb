class Brand < NanoStore::Model

  attribute :name
  attribute :description

  bag :levers

  def curves
    start = 0
    levers.collect do |lever|
      start += 1
      {
        :name => lever.name,
        :color => lever.color.to_cpt_color,
        :static_point => start,
        :draggable_point => start+1,
        :fn => lambda {|p| (start+1) * p * p},
        :data => (0..10).to_a
      }
    end
  end

end