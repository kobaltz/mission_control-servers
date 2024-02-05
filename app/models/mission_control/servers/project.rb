module MissionControl::Servers
  class Project < ApplicationRecord
    has_many :services, dependent: :destroy
    has_secure_token :token
  end
end
