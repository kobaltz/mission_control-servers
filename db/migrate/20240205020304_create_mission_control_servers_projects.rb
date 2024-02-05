class CreateMissionControlServersProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :mission_control_servers_projects do |t|
      t.string :title
      t.string :token

      t.timestamps
    end
  end
end
