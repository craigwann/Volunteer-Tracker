require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get("/") do
  @projects = Project.all()
  erb(:index)
end

post("/") do
  title = params.fetch('title')
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all
  erb(:index)
end

get('/project/:id') do
  project_id = params.fetch('id').to_i
  @project = Project.find(project_id)
  erb(:project)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

delete('/project_delete') do
  project_id = params.fetch('project_id').to_i
  project = Project.find(project_id)
  project.delete
  @projects = Project.all
  erb(:index)
end

get("/projects/new") do
  erb(:project_form)
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
  erb(:volunteer_success)
end
