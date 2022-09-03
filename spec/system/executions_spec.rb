require 'rails_helper'

RSpec.describe '実施済み改善提案の新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @proposal = FactoryBot.create(:proposal, user_id: @user.id)
    @estimation = FactoryBot.create(:estimation, proposal_id: @proposal.id)
    @execution = FactoryBot.build(:execution, proposal_id: @proposal.id, user_id: @user.id)
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
      expect(page).to have_content(@execution.hourly_wage)
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

RSpec.describe '実施済み改善提案の編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @proposal1 = FactoryBot.create(:proposal, user_id: @user1.id)
    @estimation1 = FactoryBot.create(:estimation, proposal_id: @proposal1.id)
    @user2 = FactoryBot.create(:user)
    @proposal2 = FactoryBot.create(:proposal, user_id: @user2.id)
    @estimation2 = FactoryBot.create(:estimation, proposal_id: @proposal2.id)
    @execution1 = FactoryBot.create(:execution, proposal_id: @proposal1.id, user_id: @user1.id)
    @execution2 = FactoryBot.create(:execution, proposal_id: @proposal2.id, user_id: @user2.id)
  end
  context '投稿内容の編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した実施済み改善提案を編集できる' do
      # 実施済み改善提案1を投稿したユーザーでログインする
      sign_in(@user1)
      # 実施済み改善提案一覧ページへ遷移する
      all('.order')[2].click
      expect(current_path).to eq(executions_path)
      # 実施済み改善提案1のタイトル部分をクリックしてアコーディオンを開く
      all('.execution_title_btn')[1].click
      sleep 0.5
      # 実施済み改善提案1に編集ページへのリンクがあることを確認する
      expect(
        all('.proposal')[1]
      ).to have_link '編集', href: edit_execution_path(@execution1)
      # 編集ボタンをクリックすると改善提案1の編集ページへ遷移する
      all('.action_btn')[1].click
      expect(current_path).to eq(edit_execution_path(@execution1))
      # すでに投稿済みの内容が画像以外フォームに入っていることを確認する
      expect(
        find('#execution_where').value
      ).to eq(@execution1.where)
      expect(
        find('#execution_what').value
      ).to eq(@execution1.what)
      expect(
        find('#execution_why').value
      ).to eq(@execution1.why)
      expect(
        find('#execution_how').value
      ).to eq(@execution1.how)
      expect(
        find('#after_seconds').value.to_i
      ).to eq(@execution1.after_seconds)
      expect(
        find('#after_workers').value.to_i
      ).to eq(@execution1.after_workers)
      expect(
        find('#after_days').value.to_i
      ).to eq(@execution1.after_days)
      expect(
        find('#after_man_hours', visible: false).value.to_i
      ).to eq(@execution1.after_man_hours)
      expect(
        find('#hourly_wage', visible: false).value.to_i
      ).to eq(@execution1.hourly_wage)
      expect(
        find('#after_costs', visible: false).value.to_i
      ).to eq(@execution1.after_costs)
      expect(
        find('#reduced_man_hours', visible: false).value.to_i
      ).to eq(@execution1.reduced_man_hours)
      expect(
        find('#reduced_costs', visible: false).value.to_i
      ).to eq(@execution1.reduced_costs)
      # 投稿内容を編集する
      image_path = Rails.root.join('public/images/test_image2.png')
      attach_file('execution[image]', image_path, make_visible: true)
      fill_in 'execution_where', with: "#{@execution1.where}+編集したテキスト"
      fill_in 'execution_what', with: "#{@execution1.what}+編集したテキスト"
      fill_in 'execution_why', with: "#{@execution1.why}+編集したテキスト"
      fill_in 'execution_how', with: "#{@execution1.how}+編集したテキスト"
      fill_in 'after_seconds', with: @execution1.after_seconds + 1
      fill_in 'after_workers', with: @execution1.after_workers + 1
      fill_in 'after_days', with: @execution1.after_days + 1
      # 編集してもExecutionモデルのレコードのカウントは変わらないことを確認する
      expect  do
        click_on('投稿する')
      end.not_to change { Execution.count }
      # トップページに遷移することを確認する
      expect(current_path).to eq(executions_path)
      # 実施済み改善提案一覧ページには先ほど投稿した内容が反映されていることを確認する
      beforeManHours = (@proposal1.before_seconds * @proposal1.before_workers * @proposal1.before_days / 3600).round(1)
      beforeCosts = (@proposal1.before_seconds * @proposal1.before_workers * @proposal1.before_days / 3600).round(1) * @proposal1.hourly_wage
      afterManHours = ((@execution1.after_seconds + 1) * (@execution1.after_workers + 1) * (@execution1.after_days + 1) / 3600).round(1)
      afterCosts = ((@execution1.after_seconds + 1) * (@execution1.after_workers + 1) * (@execution1.after_days + 1) / 3600).round(1) * @execution1.hourly_wage
      expect(page).to have_selector("img[src$='test_image2.png']")
      expect(page).to have_content("#{@execution1.where}+編集したテキスト")
      expect(page).to have_content("#{@execution1.what}+編集したテキスト")
      expect(page).to have_content("#{@execution1.why}+編集したテキスト")
      expect(page).to have_content("#{@execution1.how}+編集したテキスト")
      expect(page).to have_content(@execution1.after_seconds + 1)
      expect(page).to have_content(@execution1.after_workers + 1)
      expect(page).to have_content(@execution1.after_days + 1)
      expect(page).to have_content(afterManHours)
      expect(page).to have_content(afterCosts)
      expect(page).to have_content(beforeManHours - afterManHours)
      expect(page).to have_content(beforeCosts - afterCosts)
    end
  end
  context '投稿内容を編集できないとき' do
    it 'ログインしたユーザーは自分以外が投稿した実施済み改善提案の編集画面には遷移できない' do
      # 実施済み改善提案1を投稿したユーザーでログインする
      sign_in(@user1)
      # 実施済み改善提案一覧ページへ遷移する
      all('.order')[2].click
      expect(current_path).to eq(executions_path)
      # 実施済み改善提案2に「編集」へのリンクがないことを確認する
      expect(
        all('.proposal')[0]
      ).to have_no_link '編集', href: edit_execution_path(@execution2)
    end
  end
end

RSpec.describe '実施済み改善提案の削除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @proposal1 = FactoryBot.create(:proposal, user_id: @user1.id)
    @estimation1 = FactoryBot.create(:estimation, proposal_id: @proposal1.id)
    @user2 = FactoryBot.create(:user)
    @proposal2 = FactoryBot.create(:proposal, user_id: @user2.id)
    @estimation2 = FactoryBot.create(:estimation, proposal_id: @proposal2.id)
    @execution1 = FactoryBot.create(:execution, proposal_id: @proposal1.id, user_id: @user1.id)
    @execution2 = FactoryBot.create(:execution, proposal_id: @proposal2.id, user_id: @user2.id)
  end
  context '投稿の削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した実施済み改善提案の削除ができる' do
      # 改善提案1を投稿したユーザーでログインする
      sign_in(@user1)
      # 実施済み改善提案一覧ページへ遷移する
      all('.order')[2].click
      expect(current_path).to eq(executions_path)
      # 実施済み改善提案1のタイトル部分をクリックしてアコーディオンを開く
      all('.execution_title_btn')[1].click
      sleep 0.5
      # 改善提案1に「削除」へのリンクがあることを確認する
      expect(
        all('.proposal')[1]
      ).to have_link '削除', href: execution_path(@execution1)
      # 削除ボタンをクリックするとExecutionモデルとそれに紐づくProposalモデル及びEstimationモデルのレコードの数が1減ることを確認する
      expect do
        all('.action_btn')[0].click
      end.to change { Execution.count & Proposal.count & Estimation.count }.by(-1)
      # 削除実行後も実施済み改善提案一覧ページにいることを確認する
      expect(current_path).to eq(executions_path)
      # 実施済み改善提案一覧ページに改善提案1の内容が存在しないことを確認する
      expect(page).to have_no_content(@execution1)
    end
  end
  context '投稿の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した実施済み改善提案の削除ができない' do
      # 改善提案1を投稿したユーザーでログインする
      sign_in(@user1)
      # 実施済み改善提案一覧ページへ遷移する
      all('.order')[2].click
      expect(current_path).to eq(executions_path)
      # 改善提案2に「削除」へのリンクがないことを確認する
      expect(
        all('.proposal')[0]
      ).to have_no_link '削除', href: execution_path(@execution2)
    end
  end
end
