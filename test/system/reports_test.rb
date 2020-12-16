# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  def setup
    login_as_jhon
  end

  test "visiting the index" do
    visit reports_url
    assert_selector "h1", text: "日報"
    assert_text '初めての日報'
  end

  test "creating a Report" do
    visit reports_url
    click_on "新規作成"
    fill_in "タイトル", with: "日報、二日目"
    fill_in "内容", with: "いきなり、壁に・・・"
    click_on "登録する"
    assert_text "登録しました"
    assert_text '日報、二日目'
    assert_text 'いきなり、壁に・・・'
  end

  test "showing a Report" do
    visit report_path(reports(:one_day_report))
    assert_text "初めての日報"
    assert_text "今日は、Rubyの学習を頑張った！"
  end

  test "updating a Report" do
    visit edit_report_path(reports(:one_day_report))
    fill_in "タイトル", with: "初めての日報を修正"
    click_on "更新する"
    assert_text "更新しました"
    assert_text "初めての日報を修正"
  end

  test "destroying a Report" do
    visit reports_url
    assert_text "初めての日報"
    page.accept_confirm do
      click_on "削除", match: :first
    end
    assert_text "削除しました"
    assert_no_text "初めての日報"
  end

  test "showing a Comment on report" do
    visit report_path(reports(:one_day_report))
    assert_text "今日は、Rubyの学習を頑張った！"
  end
end
