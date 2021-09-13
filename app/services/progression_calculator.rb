# frozen_string_literal: true

# app/services/progression_calculator.rb
class ProgressionCalculator < ApplicationService
  attr_reader :closed, :tasks

  def initialize(closed_tasks, tasks)
    @closed = closed_tasks
    @tasks = tasks
  end

  def call
    return 0 if tasks.count.zero?

    ((closed.count.to_f / tasks.count) * 100).to_i
  end
end
