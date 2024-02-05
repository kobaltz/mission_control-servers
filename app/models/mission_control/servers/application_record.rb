module MissionControl
  module Servers
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
