class Volunteer
  attr_reader(:name, :project_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    # @id = attributes.fetch(:id)
  end

  def ==(another_name)
    self.name().==(another_name.name()).&(self.project_id().==(another_name.project_id()))

  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i()
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end










end