class CreateLogininfos < ActiveRecord::Migration
  def change
    create_table :logininfos do |t|
      t.string :url
      t.string :urldesc
      t.string :account
      t.string :password
      t.integer :user_id
      t.text :form

      t.timestamps
    end
  end
end
