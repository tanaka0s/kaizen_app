require 'rails_helper'

RSpec.describe '実施済み改善提案の新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @proposal = FactoryBot.create(:proposal, user_id: @user.id)
    @estimation = FactoryBot.create(:estimation, proposal_id: @proposal.id)
    @execution = FactoryBot.build(:execution)
  end
  context '新規投稿ができるとき' do
    it 'ログインしたユーザーは実施済み改善提案の新規投稿ができる' do
      # ログインする
      sign_in(@user)
      # 実施済み改善提案投稿ページへのボタンがあることを確認する
      expect(
        all('.proposal')[0]
      ).to have_link '実施', href: new_proposal_execution_path(@proposal)
      # 実施ボタンをクリックすると投稿ページに移動する
      all('.action_btn')[2].click
      expect(current_path).to eq(new_proposal_execution_path(@proposal))
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image2.png')
      attach_file('execution[image]', image_path, make_visible: true)
      fill_in 'execution_where', with: @execution.where
      fill_in 'execution_what', with: @execution.what
      fill_in 'execution_why', with: @execution.why
      fill_in 'execution_how', with: @execution.how
      fill_in 'after_seconds', with: @execution.after_seconds
      fill_in 'after_workers', with: @execution.after_workers
      fill_in 'after_days', with: @execution.after_days
      # 送信するとExecutionモデルのレコードのカウントが1上がることを確認する
      expect  do
        click_on('投稿する')
      end.to change { Execution.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(executions_path)
      # 実施済み改善提案一覧ページには先ほど投稿した内容が反映されていることを確認する
      beforeManHours = (@proposal.before_seconds * @proposal.before_workers * @proposal.before_days / 3600).round(1)
      beforeCosts = (@proposal.before_seconds * @proposal.before_workers * @proposal.before_days / 3600).round(1) * @proposal.hourly_wage
      afterManHours = (@execution.after_seconds * @execution.after_workers * @execution.after_days / 3600).round(1)
      afterCosts = (@execution.after_seconds * @execution.after_workers * @execution.after_days / 3600).round(1) * @execution.hourly_wage
      expect(page).to have_selector("img[src$='test_image2.png']")
      expect(page).to have_content(@execution.where)
      expect(page).to have_content(@execution.what)
      expect(page).to have_content(@execution.why)
      expect(page).to have_content(@execution.how)
      expect(page).to have_content(@execution.after_seconds)
      expect(page).to have_content(@execution.after_workers)
      expect(page).to have_content(@execution.after_days)
      expect(page).to have_content(afterManHours)
      expect(page).to have_content(afterCosts)
      expect(page).to have_content(beforeManHours - afterManHours)
      expect(page).to have_content(beforeCosts - afterCosts)
    end
  end
  context '新規投稿ができないとき' do
    it '誤った情報では実施済み改善提案の新規投稿ができずに新規投稿ページへ戻る' do
      # ログインする
      sign_in(@user)
      # 実施済み改善提案投稿ページへのボタンがあることを確認する
      expect(
        all('.proposal')[0]
      ).to have_link '実施', href: new_proposal_execution_path(@proposal)
      # 実施ボタンをクリックすると投稿ページに移動する
      all('.action_btn')[2].click
      expect(current_path).to eq(new_proposal_execution_path(@proposal))
      # フォームに情報を入力する
      fill_in 'execution_where', with: ''
      fill_in 'execution_what', with: ''
      fill_in 'execution_why', with: ''
      fill_in 'execution_how', with: ''
      fill_in 'after_seconds', with: ''
      fill_in 'after_workers', with: ''
      fill_in 'after_days', with: ''
      # 送信するとDBに保存されていないことを確認する
      expect  do
        click_on('投稿する')
      end.not_to change { Execution.count }
      # 新規投稿ページに戻ることを確認する
      expect(current_path).to eq(proposal_executions_path(@proposal))
    end
  end
end
