# frozen_string_literal: true

# app/services/progression_calculator.rb
class ProgressionCalculator < ApplicationService
  attr_reader :closed, :tasks

  def initialize(user)
    @closed = user.tasks.closed
    @tasks = user.tasks
  end

  def call
    return 0 if tasks.count.zero?

    ((closed.count.to_f / tasks.count) * 100).to_i
  end
end
