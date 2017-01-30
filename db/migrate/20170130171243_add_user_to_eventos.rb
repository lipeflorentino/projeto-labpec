class AddUserToEventos < ActiveRecord::Migration[5.0]
  def change
    add_reference :eventos, :user, foreign_key: true, index: true
  end
end
