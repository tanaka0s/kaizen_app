require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに遷移させる
      visit root_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)
      # Sign upボタンを押すと新規登録ページへ移動する
      click_on('Sign up')
      # ユーザー情報を入力する
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # Create Accountボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        click_on('Create Account')
      end.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに遷移させる
      visit root_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)
      # Sign upボタンを押すと新規登録ページへ移動する
      click_on('Sign up')
      # ユーザー情報を入力する
      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # Create Accountボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        click_on('Create Account')
      end.to change { User.count }.by(0)
      # サインインページへ戻されることを確認する
      expect(current_path).to eq(user_registration_path)
    end
  end
end

RSpec.describe 'ユーザーログイン機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
  end

  context 'ログインができるとき' do
    it 'ログインに成功し、トップページに遷移する' do
      # サインインページへ移動する
      visit new_user_session_path

      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)

      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password

      # ログインボタンをクリックする
      click_on('Log in')

      # トップページに遷移していることを確認する
      expect(current_path).to eq(root_path)
    end
  end

  context 'ログインができないとき' do
    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)

      # トップページに遷移させる
      visit root_path

      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)

      # 誤ったユーザー情報を入力する
      fill_in 'user_email', with: 'test'
      fill_in 'user_password', with: 'test'

      # ログインボタンをクリックする
      click_on('Log in')

      # サインインページに戻ってきていることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
