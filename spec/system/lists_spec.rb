# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
let!(:book) { create(:book,title:'hoge',body:'body') }
describe 'トップ画面(root_path)のテスト' do
  before do 
    visit root_path
  end
  context '表示の確認' do
      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: books_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
end