require 'rails_helper'

RSpec.describe "SignIns", type: :system do
  before do
    visit new_user_session_path
  end
  context '表示の確認' do
      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: user_posts_path
      end
  end
end
