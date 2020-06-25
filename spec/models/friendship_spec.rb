RSpec.describe Friendship, type: :model do
  it 'should not save without user' do
    friendship = Friendship.new(friend_id: 1)
    expect(friendship).to_not be_valid
  end

  it 'should not save without friend' do
    friendship = Friendship.new(user_id: 1)
    expect(friendship).to_not be_valid
  end
  context 'with all validations passed' do
    before(:all) do
      @user1 = User.new(name: 'Potato', email: 'tat@ato.com', password: 'lalala', id: 20)
      @user2 = User.new(name: 'Tomato', email: 'pat@ato.com', password: 'lalala', id: 21)
      @user1.save!
      @user2.save!
      @friendship = Friendship.new(user_id: @user1.id, friend_id: @user2.id)
    end

    after(:all) do
      @user1.destroy!
      @user2.destroy!
    end

    it 'should save with all validations provided' do
      expect(@friendship).to be_valid
    end

    it 'should return user1 as User' do
      expect(@friendship.user_id).to eq @user1.id
    end

    it 'should return user2 as Friend' do
      expect(@friendship.friend_id).to eq @user2.id
    end
  end
end
