class CreateMissionControlServersRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :mission_control_servers_requests do |t|
      t.belongs_to :project, null: false, foreign_key: { to_table: :mission_control_servers_projects }
      t.string :hostname
      t.integer :sum_2xx, default: 0
      t.integer :sum_3xx, default: 0
      t.integer :sum_4xx, default: 0
      t.integer :sum_5xx, default: 0
      t.integer :unknown, default: 0

      t.timestamps
    end
  end
end
