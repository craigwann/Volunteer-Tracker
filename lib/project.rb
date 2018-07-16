class Project
  attr_reader(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(another_proj)
    self.title.==(another_proj.title).&(self.id().==(another_proj.id()))
  end

  def save
    if title.length > 0
      result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.find(id)
   found_projects = nil
   Project.all().each() do |project|
     if project.id().==(id)
       found_projects = project
     end
   end
   found_projects
 end

 def volunteers
   proj_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id};")
   volunteers = []
   proj_volunteers.each do |volunteer|
     id = volunteer.fetch('id').to_i
     name = volunteer.fetch('name')
     project_id = volunteer.fetch('project_id').to_i
     volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
   end
   volunteers
 end

 def update(attributes)
   @title = attributes.fetch(:title, @title)
   @id = self.id
   if @title.length > 0
     DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
   end
 end

 def delete
     DB.exec("DELETE FROM projects WHERE id = #{self.id};")
 end




end
