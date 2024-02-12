module MissionControl::Servers
  class PublicProject < ApplicationRecord
    belongs_to :project
    has_secure_token :token, length: 128
  end
end
