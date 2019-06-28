class AddUserColumnToTodos < ActiveRecord::Migration[5.2]
  def change
    add_reference :todos, :user, index: true
  end
end
