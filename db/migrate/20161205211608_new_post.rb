class NewPost < ActiveRecord::Migration[5.0]
  def change
  	create_table :posts do |t|
	t.string :message, :limit => 150
	t.integer :user_id
	t.datetime :timecreated
	end
  end
end
