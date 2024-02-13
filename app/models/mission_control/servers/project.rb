module MissionControl::Servers
  class Project < ApplicationRecord
    has_many :services, dependent: :destroy
    has_many :requests, dependent: :destroy
    has_many :service_settings, dependent: :destroy
    has_many :public_projects, dependent: :destroy
    has_secure_token :token
  end
end
