class AddMissingMissionControlServerIndexes < ActiveRecord::Migration[7.1]
  def change
    remove_index :mission_control_servers_services, :hostname
    add_index :mission_control_servers_services, [:hostname, :created_at]
    add_index :mission_control_servers_requests, [:hostname, :created_at]
  end
end
