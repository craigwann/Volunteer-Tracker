class Project
  attr_reader(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(another_proj)
    self.title.==(another_proj.title).&(self.id().==(another_proj.id()))
  end












end
