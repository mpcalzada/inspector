class AddSecurityFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    ## Password expirable
    add_column :users, :password_changed_at, :datetime

    ## Session limitable
    add_column :users, :unique_session_id, :string, :limit => 30
    add_column :users, :last_activity_at, :datetime

    ## Expirable
    add_column :users, :expired_at, :datetime

    ## Concurrency
    add_column :users, :is_active, :boolean
  end
end
