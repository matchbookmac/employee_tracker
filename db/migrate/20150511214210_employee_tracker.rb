class EmployeeTracker < ActiveRecord::Migration
  def change
    create_table(:divisions) do |d|
      d.column(:name, :string)

      d.timestamps()
    end

    create_table(:employees) do |e|
      e.column(:name, :string)
      e.column(:division_id, :int)

      e.timestamps()
    end
  end
end
