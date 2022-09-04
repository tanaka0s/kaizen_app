require 'rails_helper'
describe ProposalsController, type: :request do
  before do
    @user = FactoryBot.create(:user)
    @proposal = FactoryBot.create(:proposal, user_id: @user.id)
    @estimation = FactoryBot.create(:estimation, proposal_id: @proposal.id)
    sign_in @user
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案を投稿したユーザー名が存在する' do
      get root_path
      expect(response.body).to include(@proposal.user.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の画像が存在する' do
      get root_path
      expect(response.body).to include('test_image.png')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案のタイトルが存在する' do
      get root_path
      expect(response.body).to include(@proposal.title)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案のwhereが存在する' do
      get root_path
      expect(response.body).to include(@proposal.where)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案のwhatが存在する' do
      get root_path
      expect(response.body).to include(@proposal.what)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案のwhyが存在する' do
      get root_path
      expect(response.body).to include(@proposal.why)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案のhowが存在する' do
      get root_path
      expect(response.body).to include(@proposal.how)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前作業時間が存在する' do
      get root_path
      expect(response.body).to include(@proposal.before_seconds.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前作業人数が存在する' do
      get root_path
      expect(response.body).to include(@proposal.before_workers.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前年間使用日数が存在する' do
      get root_path
      expect(response.body).to include(@proposal.before_days.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前年間作業工数が存在する' do
      get root_path
      expect(response.body).to include(@proposal.before_man_hours.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前時給が存在する' do
      get root_path
      expect(response.body).to include(@proposal.hourly_wage.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前作業コストが存在する' do
      get root_path
      expect(response.body).to include(@proposal.before_costs.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業時間が存在する' do
      get root_path
      expect(response.body).to include(@proposal.estimation.after_seconds.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業人数が存在する' do
      get root_path
      expect(response.body).to include(@proposal.estimation.after_workers.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業日数が存在する' do
      get root_path
      expect(response.body).to include(@proposal.estimation.after_days.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業工数が存在する' do
      get root_path
      expect(response.body).to include(@proposal.estimation.after_man_hours.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後時給が存在する' do
      get root_path
      expect(response.body).to include(@proposal.estimation.hourly_wage.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業コストが存在する' do
      get root_path
      expect(response.body).to include(@proposal.estimation.after_costs.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の削減工数が存在する' do
      get root_path
      expect(response.body).to include(@proposal.estimation.reduced_man_hours.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの改善提案の削減コストが存在する' do
      get root_path
      expect(response.body).to include(@proposal.estimation.reduced_costs.to_s)
    end
  end

  describe 'GET #new' do
    it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
      get new_proposal_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        post proposals_path, params: { proposal_estimation: FactoryBot.attributes_for(:proposal_estimation) }
        expect(response.status).to eq 302
      end
      it '投稿ができる' do
        expect do
          post proposals_path, params: { proposal_estimation: FactoryBot.attributes_for(:proposal_estimation) }
        end.to change(Proposal, :count).by(1) and change(Estimation, :count).by(1)
      end
    end
    context 'パラメータが不正な場合' do
      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        post proposals_path, params: { proposal_estimation: FactoryBot.attributes_for(:proposal_estimation, title: nil) }
        expect(response.status).to eq 200
      end
      it '投稿ができない' do
        expect do
          post proposals_path, params: { proposal_estimation: FactoryBot.attributes_for(:proposal_estimation, title: nil) }
        end.to_not change(Proposal, :count) and change(Estimation, :count)
      end
    end
  end

  describe 'GET #edit' do
    it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
      get edit_proposal_path(@proposal)
      expect(response.status).to eq 200
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案のタイトルが存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.title)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案のwhereが存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.where)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案のwhatが存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.what)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案のwhyが存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.why)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案のhowが存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.how)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前作業時間が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.before_seconds.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前作業人数が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.before_workers.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前年間使用日数が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.before_days.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前年間作業工数が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.before_man_hours.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前時給が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.hourly_wage.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善前作業コストが存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.before_costs.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業時間が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.estimation.after_seconds.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業人数が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.estimation.after_workers.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業日数が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.estimation.after_days.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業工数が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.estimation.after_man_hours.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後時給が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.estimation.hourly_wage.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の改善後作業コストが存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.estimation.after_costs.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の削減工数が存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.estimation.reduced_man_hours.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの改善提案の削減コストが存在する' do
      get edit_proposal_path(@proposal)
      expect(response.body).to include(@proposal.estimation.reduced_costs.to_s)
    end
  end

  describe 'PUT #update' do
    context 'パラメータが妥当な場合' do
      it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
        put proposal_path(@proposal),
            params: { proposal_estimation: FactoryBot.attributes_for(:proposal_estimation, title: '編集したタイトル') }
        expect(response.status).to eq 302
      end
      it '更新ができる' do
        put proposal_path(@proposal),
            params: { proposal_estimation: FactoryBot.attributes_for(:proposal_estimation, title: '編集したタイトル') }
        expect(@proposal.reload.title).to eq('編集したタイトル')
      end
    end
    context 'パラメータが不正な場合' do
      it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
        put proposal_path(@proposal), params: { proposal_estimation: FactoryBot.attributes_for(:proposal_estimation, title: nil) }
        expect(response.status).to eq 200
      end
      it '更新ができない' do
        put proposal_path(@proposal), params: { proposal_estimation: FactoryBot.attributes_for(:proposal_estimation, title: nil) }
        expect(@proposal.reload.title).to eq(@proposal.title)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
      delete proposal_path(@proposal)
      expect(response.status).to eq 302
    end
    it '投稿されている改善提案が削除されること' do
      expect do
        delete proposal_path(@proposal)
      end.to change(Proposal, :count).by(-1) and change(Estimation, :count).by(-1)
    end
  end
end
