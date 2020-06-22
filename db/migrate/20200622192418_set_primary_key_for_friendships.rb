class SetPrimaryKeyForFriendships < ActiveRecord::Migration[5.2]
  def change
    change_column_null :friendships, :user_id, false
    change_column_null :friendships, :friend_id, false
    execute('ALTER TABLE friendships ADD PRIMARY KEY (user_id);')
    execute('ALTER TABLE friendships ADD PRIMARY KEY (friend_id);')
  end
end
