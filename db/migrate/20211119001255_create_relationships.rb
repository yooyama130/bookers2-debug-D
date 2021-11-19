class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.followed_id :integer
      t.follower_id :integer
      t.timestamps
    end
  end
end
