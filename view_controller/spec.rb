class Spec
  attr_accessor :id,
                :description,
                :state,
                :file_location

  def initialize(id: nil, description: nil, state: :untested, file_location: nil)
    self.id = id
    self.description = description
    self.state = state
    self.file_location = file_location
  end

  def file
    file_location.match("^(.*):")[1]
  end
end
