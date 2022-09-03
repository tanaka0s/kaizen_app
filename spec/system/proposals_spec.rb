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
      # 送信するとProposalモデルとEstimationモデルのレコードのカウントが1上がることを確認する
      expect  do
        click_on('投稿する')
      end.to change { Proposal.count & Estimation.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容があることを確認する
      beforeManHours = (@proposal_estimation.before_seconds * @proposal_estimation.before_workers * @proposal_estimation.before_days / 3600).round(1)
      beforeCosts = (@proposal_estimation.before_seconds * @proposal_estimation.before_workers * @proposal_estimation.before_days / 3600).round(1) * @proposal_estimation.hourly_wage
      afterManHours = (@proposal_estimation.after_seconds * @proposal_estimation.after_workers * @proposal_estimation.after_days / 3600).round(1)
      afterCosts = (@proposal_estimation.after_seconds * @proposal_estimation.after_workers * @proposal_estimation.after_days / 3600).round(1) * @proposal_estimation.hourly_wage
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@proposal_estimation.title)
      expect(page).to have_content(@proposal_estimation.where)
      expect(page).to have_content(@proposal_estimation.what)
      expect(page).to have_content(@proposal_estimation.why)
      expect(page).to have_content(@proposal_estimation.how)
      expect(page).to have_content(@proposal_estimation.before_seconds)
      expect(page).to have_content(@proposal_estimation.before_workers)
      expect(page).to have_content(@proposal_estimation.before_days)
      expect(page).to have_content(beforeManHours)
      expect(page).to have_content(@proposal_estimation.hourly_wage)
      expect(page).to have_content(beforeCosts)
      expect(page).to have_content(@proposal_estimation.after_seconds)
      expect(page).to have_content(@proposal_estimation.after_workers)
      expect(page).to have_content(@proposal_estimation.after_days)
      expect(page).to have_content(afterManHours)
      expect(page).to have_content(afterCosts)
      expect(page).to have_content(beforeManHours - afterManHours)
      expect(page).to have_content(beforeCosts - afterCosts)
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

RSpec.describe '改善提案の編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @proposal1 = FactoryBot.create(:proposal, user_id: @user1.id)
    @estimation1 = FactoryBot.create(:estimation, proposal_id: @proposal1.id)
    @user2 = FactoryBot.create(:user)
    @proposal2 = FactoryBot.create(:proposal, user_id: @user2.id)
    @estimation2 = FactoryBot.create(:estimation, proposal_id: @proposal2.id)
  end
  context '投稿内容の編集ができるとき' do
    it 'ログインしたユーザーは自身が投稿した改善提案を編集できる' do
      # 改善提案1を投稿したユーザーでログインする
      sign_in(@user1)
      # 改善提案1のタイトル部分をクリックしてアコーディオンを開く
      all('.title_btn')[1].click
      sleep 0.5
      # 改善提案1に編集ページへのリンクがあることを確認する
      expect(
        all('.proposal')[1]
      ).to have_link '編集', href: edit_proposal_path(@proposal1)
      # 編集ボタンをクリックすると改善提案1の編集ページへ遷移する
      all('.action_btn')[2].click
      expect(current_path).to eq(edit_proposal_path(@proposal1))
      # すでに投稿済みの内容が画像以外フォームに入っていることを確認する
      expect(
        find('#proposal_estimation_title').value
      ).to eq(@proposal1.title)
      expect(
        find('#proposal_estimation_where').value
      ).to eq(@proposal1.where)
      expect(
        find('#proposal_estimation_what').value
      ).to eq(@proposal1.what)
      expect(
        find('#proposal_estimation_why').value
      ).to eq(@proposal1.why)
      expect(
        find('#proposal_estimation_how').value
      ).to eq(@proposal1.how)
      expect(
        find('#before_seconds').value.to_i
      ).to eq(@proposal1.before_seconds)
      expect(
        find('#before_workers').value.to_i
      ).to eq(@proposal1.before_workers)
      expect(
        find('#before_days').value.to_i
      ).to eq(@proposal1.before_days)
      expect(
        find('#before_man_hours', visible: false).value.to_i
      ).to eq(@proposal1.before_man_hours)
      expect(
        find('#hourly_wage').value.to_i
      ).to eq(@proposal1.hourly_wage)
      expect(
        find('#before_costs', visible: false).value.to_i
      ).to eq(@proposal1.before_costs)
      expect(
        find('#after_workers').value.to_i
      ).to eq(@proposal1.estimation.after_workers)
      expect(
        find('#after_days').value.to_i
      ).to eq(@proposal1.estimation.after_days)
      expect(
        find('#after_man_hours', visible: false).value.to_i
      ).to eq(@proposal1.estimation.after_man_hours)
      expect(
        find('#after_costs', visible: false).value.to_i
      ).to eq(@proposal1.estimation.after_costs)
      expect(
        find('#reduced_man_hours', visible: false).value.to_i
      ).to eq(@proposal1.estimation.reduced_man_hours)
      expect(
        find('#reduced_costs', visible: false).value.to_i
      ).to eq(@proposal1.estimation.reduced_costs)
      # 投稿内容を編集する
      image_path = Rails.root.join('public/images/test_image2.png')
      attach_file('proposal_estimation[image]', image_path, make_visible: true)
      fill_in 'proposal_estimation_title', with: "#{@proposal1.title}+編集したテキスト"
      fill_in 'proposal_estimation_where', with: "#{@proposal1.where}+編集したテキスト"
      fill_in 'proposal_estimation_what', with: "#{@proposal1.what}+編集したテキスト"
      fill_in 'proposal_estimation_why', with: "#{@proposal1.why}+編集したテキスト"
      fill_in 'proposal_estimation_how', with: "#{@proposal1.how}+編集したテキスト"
      fill_in 'before_seconds', with: @proposal1.before_seconds + 1
      fill_in 'before_workers', with: @proposal1.before_workers + 1
      fill_in 'before_days', with: @proposal1.before_days + 1
      fill_in 'hourly_wage', with: @proposal1.hourly_wage + 100
      fill_in 'after_seconds', with: @proposal1.estimation.after_seconds + 1
      fill_in 'after_workers', with: @proposal1.estimation.after_workers + 1
      fill_in 'after_days', with: @proposal1.estimation.after_days + 1
      # 編集してもProposalモデルとEstimationモデルのレコードのカウントは変わらないことを確認する
      expect  do
        click_on('投稿する')
      end.not_to change { Proposal.count & Estimation.count }
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど変更した内容が存在することを確認する
      beforeManHours = ((@proposal1.before_seconds + 1) * (@proposal1.before_workers + 1) * (@proposal1.before_days + 1) / 3600).round(1)
      beforeCosts = ((@proposal1.before_seconds + 1) * (@proposal1.before_workers + 1) * (@proposal1.before_days + 1) / 3600).round(1) * (@proposal1.hourly_wage + 100)
      afterManHours = ((@proposal1.estimation.after_seconds + 1) * (@proposal1.estimation.after_workers + 1) * (@proposal1.estimation.after_days + 1) / 3600).round(1)
      afterCosts = ((@proposal1.estimation.after_seconds + 1) * (@proposal1.estimation.after_workers + 1) * (@proposal1.estimation.after_days + 1) / 3600).round(1) * (@proposal1.hourly_wage + 100)
      expect(page).to have_selector("img[src$='test_image2.png']")
      expect(page).to have_content("#{@proposal1.title}+編集したテキスト")
      expect(page).to have_content("#{@proposal1.where}+編集したテキスト")
      expect(page).to have_content("#{@proposal1.what}+編集したテキスト")
      expect(page).to have_content("#{@proposal1.why}+編集したテキスト")
      expect(page).to have_content("#{@proposal1.how}+編集したテキスト")
      expect(page).to have_content(@proposal1.before_seconds + 1)
      expect(page).to have_content(@proposal1.before_workers + 1)
      expect(page).to have_content(@proposal1.before_days + 1)
      expect(page).to have_content(beforeManHours)
      expect(page).to have_content(@proposal1.hourly_wage + 100)
      expect(page).to have_content(beforeCosts)
      expect(page).to have_content(@proposal1.estimation.after_seconds + 1)
      expect(page).to have_content(@proposal1.estimation.after_workers + 1)
      expect(page).to have_content(@proposal1.estimation.after_days + 1)
      expect(page).to have_content(afterManHours)
      expect(page).to have_content(@proposal1.estimation.hourly_wage + 100)
      expect(page).to have_content(afterCosts)
      expect(page).to have_content(beforeManHours - afterManHours)
      expect(page).to have_content(beforeCosts - afterCosts)
    end
  end
  context '投稿内容を編集できないとき' do
    it 'ログインしたユーザーは自分以外が投稿した改善提案の編集画面には遷移できない' do
      # 改善提案1を投稿したユーザーでログインする
      sign_in(@user1)
      # 改善提案2に「編集」へのリンクがないことを確認する
      expect(
        all('.proposal')[0]
      ).to have_no_link '編集', href: edit_proposal_path(@proposal2)
    end
  end
end

RSpec.describe '改善提案の削除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @proposal1 = FactoryBot.create(:proposal, user_id: @user1.id)
    @estimation1 = FactoryBot.create(:estimation, proposal_id: @proposal1.id)
    @user2 = FactoryBot.create(:user)
    @proposal2 = FactoryBot.create(:proposal, user_id: @user2.id)
    @estimation2 = FactoryBot.create(:estimation, proposal_id: @proposal2.id)
  end
  context '投稿を削除ができるとき' do
    it 'ログインしたユーザーは自身が投稿した改善提案の削除ができる' do
      # 改善提案1を投稿したユーザーでログインする
      sign_in(@user1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # 改善提案1のタイトル部分をクリックしてアコーディオンを開く
      all('.title_btn')[1].click
      sleep 0.5
      # 改善提案1に「削除」へのリンクがあることを確認する
      expect(
        all('.proposal')[1]
      ).to have_link '削除', href: proposal_path(@proposal1)
      # 削除ボタンをクリックするとProposalモデルとEstimationモデルのレコードの数が1減ることを確認する
      expect do
        all('.action_btn')[1].click
      end.to change { Proposal.count & Estimation.count }.by(-1)
      # 削除実行後もトップページにいることを確認する
      expect(current_path).to eq(root_path)
      # トップページに改善提案1の内容が存在しないことを確認する
      expect(page).to have_no_content(@proposal1)
    end
  end
  context '投稿の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した改善提案の削除ができない' do
      # 改善提案1を投稿したユーザーでログインする
      sign_in(@user1)
      # 改善提案2に「削除」へのリンクがないことを確認する
      expect(
        all('.proposal')[0]
      ).to have_no_link '削除', href: proposal_path(@proposal2)
    end
  end
end
