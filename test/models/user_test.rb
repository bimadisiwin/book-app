require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @john = users(:john)
    @bob = users(:bob)
  end

  test 'allows you to follow users.' do
    assert_not @john.following?(@bob)
    assert_difference('Relationship.count', +1) do
      @john.follow(@bob)
    end
    assert @john.following?(@bob)
  end

  test 'allows users to unfollow.' do
    assert_not @john.following?(@bob)
    @john.follow(@bob)
    assert_difference('Relationship.count', -1) do
      @john.unfollow(@bob)
    end
    assert_not @john.following?(@bob)
  end

  test '#create_unique_string' do
    uuid1 = User.create_unique_string
    uuid2 = User.create_unique_string

    assert_equal(36, uuid1.length)
    assert_equal(36, uuid2.length)
    assert_not_equal(uuid1, uuid2)
  end

  test "If a user is registered with github_oauth, return that user" do
    auth_hash = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "1234",
      info: { email: "mockuser@example.com" }
    })
    user = User.create!( email: "mockuser@example.com", password: "password", provider: "github", uid: "1234")
    assert_equal user, User.find_for_github_oauth(auth_hash)
  end
end
