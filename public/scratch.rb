

/ from project.erb
<div class="container">
  <button><a href="/">Home</a></button>
  <button><a href="/projects">View All Projects</a></button>
  <button><a href="/projects/new">Add New Project</a></button>
  <button><a href="/project_edit/<%= project.id()%>">Edit Project</a></button>
</div>

if title.length > 0
  project = Project.new({:title => title, :id => nil})
  project.save
end
