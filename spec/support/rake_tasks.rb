# frozen_string_literal: true

class RakeTasks
  def self.run_rake_task(task_name)
    Rake::Task[task_name].invoke
  end
end
