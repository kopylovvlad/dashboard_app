# frozen_string_literal: true

# RoR abstract class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
