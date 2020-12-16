# frozen_string_literal: true

require "application_system_test_case"

class RelationshipsTest < ApplicationSystemTestCase
  def setup
    login_as_jhon
  end

  test "Follow user" do
    visit users_url
    click_on "bob@example.com"
    click_on "フォロー"
    assert_button "フォローを解除する"
  end

  test "Show followers" do
    jhon_follows_bob
    visit users_url
    assert_text "bob@example.com"
    click_on "john@example.com"
    click_on "フォロー中のユーザー"
    assert_text "bob@example.com"
  end

  test "Unfollow　user" do
    jhon_follows_bob
    visit users_url
    click_on "bob@example.com"
    click_on "フォローを解除する"
    assert_button "フォロー"
  end

  private
    def jhon_follows_bob
      jhon = users(:john)
      bob = users(:bob)
      jhon.relationships.create(follow_id: bob.id)
    end
end
