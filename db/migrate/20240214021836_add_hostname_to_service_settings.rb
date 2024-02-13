class AddHostnameToServiceSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :mission_control_servers_service_settings, :request_hostname, :string
  end
end
