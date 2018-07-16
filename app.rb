require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get("/") do
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

post("/") do
  title = params.fetch('title')
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all
  @volunteers = Volunteer.all()
  erb(:index)
end

get('/projects/:id') do
  project_id = params.fetch('id').to_i
  @project = Project.find(project_id)
  erb(:project)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get('/volunteers/:id') do
  volunteer_id = params.fetch('id').to_i
  @volunteer = Volunteer.find(volunteer_id)
  erb(:volunteer)
end

patch('/volunteers/:id') do
  volunteer_id = params.fetch('id').to_i
  name = params.fetch('name')
  @volunteer = Volunteer.find(volunteer_id)
  @volunteer.update({:name => name})
  erb(:volunteer)
end

delete('/project_delete') do
  project_id = params.fetch('project_id').to_i
  project = Project.find(project_id)
  project.delete
  @projects = Project.all
  @volunteers = Volunteer.all()
  erb(:index)
end

delete('/volunteer_delete') do
  id = params.fetch('id').to_i
  volunteer = Volunteer.find(id)
  volunteer.delete
  @projects = Project.all
  @volunteers = Volunteer.all()
  erb(:index)
end

get("/project_edit/:id") do
  project_id = params.fetch('id').to_i
  @project = Project.find(project_id)
  erb(:project_edit)
end

post("/projects") do
  title = params.fetch("title")
  @project = Project.new({:title => title, :id => nil})
  @project.save()
  erb(:project_success)
end

patch("/project/:id") do
  project_id = params.fetch('id').to_i
  title = params.fetch('title')
  @project = Project.find(project_id)
  @project.update({:title => title})
  erb(:project)
end

post("/volunteers") do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i()
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :project_id => project_id, :id =>nil})
  @volunteer.save()
  erb(:project)
end
