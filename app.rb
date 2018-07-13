require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get("/") do
  erb(:index)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get("/projects/new") do
  erb(:project_form)
end

post("/projects") do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  erb(:project_success)
end

# get("/lists/:id") do
#   @list = List.find(params.fetch("id").to_i())
#   erb(:list)
# end
#
# post("/tasks") do
#   description = params.fetch("description")
#   list_id = params.fetch("list_id").to_i()
#   @list = List.find(list_id)
#   @task = Task.new({:description => description, :list_id => list_id})
#   @task.save()
#   erb(:task_success)
# end
