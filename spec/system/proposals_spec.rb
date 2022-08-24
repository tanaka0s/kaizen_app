require 'rails_helper'

RSpec.describe '改善提案の新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @proposal_estimation = FactoryBot.build(:proposal_estimation)
  end

  context '新規投稿投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_proposal_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('proposal_estimation[image]', image_path, make_visible: true)
      fill_in 'proposal_estimation_title', with: @proposal_estimation.title
      fill_in 'proposal_estimation_where', with: @proposal_estimation.where
      fill_in 'proposal_estimation_what', with: @proposal_estimation.what
      fill_in 'proposal_estimation_why', with: @proposal_estimation.why
      fill_in 'proposal_estimation_how', with: @proposal_estimation.how
      fill_in 'before_seconds', with: @proposal_estimation.before_seconds
      fill_in 'before_workers', with: @proposal_estimation.before_workers
      fill_in 'before_days', with: @proposal_estimation.before_days
      fill_in 'hourly_wage', with: @proposal_estimation.hourly_wage
      fill_in 'after_seconds', with: @proposal_estimation.after_seconds
      fill_in 'after_workers', with: @proposal_estimation.after_workers
      fill_in 'after_days', with: @proposal_estimation.after_days
      # 送信するとProposalモデルとEstimationモデルのカウントが1上がることを確認する
      expect  do
        click_on('投稿する')
      end.to change { Proposal.count & Estimation.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容の改善提案のタイトルがあることを確認する
      expect(page).to have_content(@proposal_estimation.title)
    end
  end
  context '新規投稿ができないとき' do
    it '誤った情報では新規投稿ができずに新規投稿ページへ戻る' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_proposal_path
      # フォームに情報を入力する
      fill_in 'proposal_estimation_title', with: ''
      fill_in 'proposal_estimation_where', with: ''
      fill_in 'proposal_estimation_what', with: ''
      fill_in 'proposal_estimation_why', with: ''
      fill_in 'proposal_estimation_how', with: ''
      fill_in 'before_seconds', with: ''
      fill_in 'before_workers', with: ''
      fill_in 'before_days', with: ''
      fill_in 'hourly_wage', with: ''
      fill_in 'after_seconds', with: ''
      fill_in 'after_workers', with: ''
      fill_in 'after_days', with: ''
      # 送信するとDBに保存されていないことを確認する
      expect  do
        click_on('投稿する')
      end.not_to change { Proposal.count & Estimation.count }
      # 新規投稿ページに戻ることを確認する
      expect(current_path).to eq(proposals_path)
    end
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('投稿する')
    end
  end
end
