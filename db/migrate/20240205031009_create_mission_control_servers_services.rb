class CreateMissionControlServersServices < ActiveRecord::Migration[7.1]
  def change
    create_table :mission_control_servers_services do |t|
      t.belongs_to :project, null: false, foreign_key: { to_table: :mission_control_servers_projects }
      t.string :hostname
      t.decimal :cpu, precision: 8, scale: 2
      t.decimal :mem_used, precision: 8, scale: 2
      t.decimal :mem_free, precision: 8, scale: 2
      t.decimal :disk_free, precision: 8, scale: 2

      t.timestamps
    end
  end
end
