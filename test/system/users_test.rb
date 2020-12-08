
# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'index users' do
    login_as_jhon
    visit books_url
    click_link 'ユーザー一覧'
    assert_text 'ユーザー一覧'
    assert_text 'john@example.com'
    assert_text 'bob@example.com'
  end

  test "creating a User" do
    visit new_user_registration_url
    fill_in "Eメール", with: "dave@example.com"
    fill_in "パスワード", with: "password"
    fill_in "パスワード（確認用）", with: "password"
    click_button "アカウント登録"
    assert_text "アカウント登録が完了しました。"
    click_on "あなたのプロフィール"
    assert_text "dave@example.com"
  end

  test "GitHubアカウントでログイン" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => "github",
      :uid => "1234",
    })
    visit new_user_session_url
    click_on "GitHubでログイン"
    assert_text "Github アカウントによる認証に成功しました。"
  end

  test 'show user' do
    login_as_jhon
    visit users_path
    click_link users(:john).email.to_s
    assert_text 'john@example.com'
  end

  test "updating a User" do
    login_as_jhon
    click_on "あなたのプロフィール"
    click_on "更新"
    fill_in "Eメール", with: "alice_updated@example.com"
    fill_in "パスワード", with: "password_updated"
    fill_in "パスワード（確認用）", with: "password_updated"
    fill_in "現在のパスワード", with: "password"
    click_on "更新"
    assert_text "アカウント情報を変更しました。"
    click_on "あなたのプロフィール"
    assert_no_text "john@example.com"
    assert_text "alice_updated@example.com"
  end

  test "log out" do
    login_as_jhon
    click_link 'ユーザー一覧'
    assert_text 'john@example.com'
    click_on "ログアウト"
    assert_no_text 'john@example.com'
    assert_text "ログアウトしました。"
  end

  test "destroying a User acount" do
    login_as_jhon
    click_on "あなたのプロフィール"
    click_on "更新"
    fill_in "現在のパスワード", with: "password"
    page.accept_confirm do
      click_on "アカウント削除"
    end

    assert_text "アカウントを削除しました。"
  end

end
