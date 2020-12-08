# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:little_tree)

    login_as_jhon
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'Ruby入門'
    fill_in 'メモ', with: 'わかりやすい！'
    fill_in '著者', with: 'hogehoge'
    click_button '登録する'

    assert_text '登録しました'
    assert_text 'Ruby入門'
    assert_text 'わかりやすい！'
    assert_text 'hogehoge'
  end

  test 'updating a Book' do
    visit edit_book_path(books(:little_tree))

    fill_in 'メモ', with: 'UMLモデリング'
    fill_in 'タイトル', with: '読みやすい本です。'
    fill_in '著者', with: 'kodakoda'
    click_button '更新する'

    assert_text '更新しました'
    assert_text 'UMLモデリング'
    assert_text '読みやすい本です。'
    assert_text 'kodakoda'
  end

  test 'destroying a Book' do
    visit books_url(:little_tree)
    assert_text 'リトルトリー'

    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '削除しました'
    assert_no_text 'リトルトリー'
  end
end
