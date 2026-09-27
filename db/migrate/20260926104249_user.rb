class User < ActiveRecord::Migration[8.1]
  def change
    create_table :Users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
