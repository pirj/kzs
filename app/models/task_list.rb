class TaskList < ActiveRecord::Base
  attr_accessible :statement_id, :tasks_attributes, :deadline
  belongs_to :statement
  belongs_to :document
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true
  
  scope :completed, -> { where(completed: true) }   
  
  after_save :update_statement
  
  def progress
    # TODO может стоит посмотреть на cache_counter
    # иначе наша БД вскоре начнет страдать
    total = 100 / self.tasks.count
    progress = total * self.tasks.completed.count
    progress
  end
  
  def with_completed_tasks
    # TODO if точно не нужен
    # tasks.count == tasks.completed.count
    # сам по себе вернет true или false
    # + вынести и закешить

    if self.tasks.count == self.tasks.completed.count
      true
    else
      false
    end
  end
  
  def update_statement
    #TODO этого достаточно:
    #if statement && completed
    #  statement.update_attributes(with_completed_tasks: true)
    #end

    if self.completed
      if self.statement
        statement = self.statement
        statement.with_completed_task_list = true
        statement.save!
      end
    end
  end
  
  def with_empty_tasks
    #TODO скорее всего это необходимо для построения формы
    #списка задач, но в модель редко выносят таие вещи,
    #обычно они находятся в контроллере, где происходит
    #создание объекта: см. StatementsController#183
    1.times {tasks.build}
    self
  end
    
end
