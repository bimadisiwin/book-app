# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  def setup
    login_as_jhon
  end

  test "creating a Comment on book" do
    visit book_path(books(:little_tree))
    fill_in "comment[body]", with: "とても面白い本です。"
    click_on "登録する"
    assert_text "登録しました"
    assert_text "とても面白い本です。"
  end

  test "updating a Comment on book" do
    visit book_path(books(:little_tree))
    click_on "更新"
    
    fill_in "comment[body]", with: "本当に、面白い本でした！"
    click_on "更新する"
    assert_text "更新しました"
    assert_text "本当に、面白い本でした！"
  end

  test "destroying a Comment on book" do
    visit book_path(books(:little_tree))
    assert_text "面白そう！"
    page.accept_confirm do
      click_on "削除"
    end
    assert_text "削除しました"
    assert_no_text "面白そう！"
  end

  test "creating a Comment on report" do
    visit report_path(reports(:one_day_report))
    fill_in "comment[body]", with: "初めての日報、お疲れ様でした！"
    click_on "登録する"
    assert_text "登録しました"
    assert_text "初めての日報、お疲れ様でした！"
  end

  test "updating a Comment on report" do
    visit report_path(reports(:one_day_report))
    assert_text "お疲れ様です〜！"
    click_on "更新"
    fill_in "comment[body]", with: "明日も、がんばりましよう！"
    click_on "更新する"
    assert_text "更新しました"
    assert_text "明日も、がんばりましよう！"
  end

  test "destroying a Comment on report" do
    visit report_path(reports(:one_day_report))
    assert_text "お疲れ様です〜！"
    page.accept_confirm do
      click_on "削除"
    end
    assert_text "削除しました"
    assert_no_text "お疲れ様です〜！"
  end
end
