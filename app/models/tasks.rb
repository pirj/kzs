module Tasks

  def self.table_name_prefix
    'tasks_'
  end

  def self.use_relative_model_naming?
    true
  end

  def self._railtie
    true
  end

end
