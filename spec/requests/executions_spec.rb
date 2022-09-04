require 'rails_helper'

describe ExecutionsController, type: :request do
  before do
    @user = FactoryBot.create(:user)
    @proposal = FactoryBot.create(:proposal, user_id: @user.id)
    @estimation = FactoryBot.create(:estimation, proposal_id: @proposal.id)
    @execution = FactoryBot.create(:execution, proposal_id: @proposal.id, user_id: @user.id)
    sign_in @user
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get executions_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案を投稿したユーザー名が存在する' do
      get executions_path
      expect(response.body).to include(@execution.user.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の画像が存在する' do
      get executions_path
      expect(response.body).to include('test_image.png')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案のwhereが存在する' do
      get executions_path
      expect(response.body).to include(@execution.where)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案のwhatが存在する' do
      get executions_path
      expect(response.body).to include(@execution.what)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案のwhyが存在する' do
      get executions_path
      expect(response.body).to include(@execution.why)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案のhowが存在する' do
      get executions_path
      expect(response.body).to include(@execution.how)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業時間が存在する' do
      get executions_path
      expect(response.body).to include(@execution.after_seconds.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業人数が存在する' do
      get executions_path
      expect(response.body).to include(@execution.after_workers.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業日数が存在する' do
      get executions_path
      expect(response.body).to include(@execution.after_days.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業工数が存在する' do
      get executions_path
      expect(response.body).to include(@execution.after_man_hours.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後時給が存在する' do
      get executions_path
      expect(response.body).to include(@execution.hourly_wage.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業コストが存在する' do
      get executions_path
      expect(response.body).to include(@execution.after_costs.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の削減工数が存在する' do
      get executions_path
      expect(response.body).to include(@execution.reduced_man_hours.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の削減コストが存在する' do
      get executions_path
      expect(response.body).to include(@execution.reduced_costs.to_s)
    end
  end

  describe 'GET #new' do
    it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
      get new_proposal_execution_path(@proposal)
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        post proposal_executions_path(@proposal), params: { execution: FactoryBot.attributes_for(:execution) }
        expect(response.status).to eq 302
      end
      it '投稿ができる' do
        expect do
          post proposal_executions_path(@proposal), params: { execution: FactoryBot.attributes_for(:execution) }
        end.to change(Execution, :count).by(1)
      end
    end
    context 'パラメータが不正な場合' do
      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        post proposal_executions_path(@proposal), params: { execution: FactoryBot.attributes_for(:execution, where: nil) }
        expect(response.status).to eq 200
      end
      it '投稿ができない' do
        expect do
          post proposal_executions_path(@proposal), params: { execution: FactoryBot.attributes_for(:execution, where: nil) }
        end.to_not change(Execution, :count)
      end
    end
  end

  describe 'GET #edit' do
    it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
      get edit_execution_path(@execution)
      expect(response.status).to eq 200
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の画像が存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include('test_image.png')
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案のwhereが存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.where)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案のwhatが存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.what)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案のwhyが存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.why)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案のhowが存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.how)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業時間が存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.after_seconds.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業人数が存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.after_workers.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業日数が存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.after_days.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業工数が存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.after_man_hours.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後時給が存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.hourly_wage.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の改善後作業コストが存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.after_costs.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の削減工数が存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.reduced_man_hours.to_s)
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの実施済み改善提案の削減コストが存在する' do
      get edit_execution_path(@execution)
      expect(response.body).to include(@execution.reduced_costs.to_s)
    end
  end

  describe 'PUT #update' do
    context 'パラメータが妥当な場合' do
      it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
        put execution_path(@execution),
            params: { execution: FactoryBot.attributes_for(:execution, where: '編集したテキスト') }
        expect(response.status).to eq 302
      end
      it '更新ができる' do
        put execution_path(@execution),
            params: { execution: FactoryBot.attributes_for(:execution, where: '編集したテキスト') }
        expect(@execution.reload.where).to eq('編集したテキスト')
      end
    end
    context 'パラメータが不正な場合' do
      it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
        put execution_path(@execution), params: { execution: FactoryBot.attributes_for(:execution, where: nil) }
        expect(response.status).to eq 200
      end
      it '更新ができない' do
        put execution_path(@execution), params: { execution: FactoryBot.attributes_for(:execution, where: nil) }
        expect(@execution.reload.where).to eq(@execution.where)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
      delete execution_path(@execution)
      expect(response.status).to eq 302
    end
    it '投稿されている改善提案が削除されること' do
      expect do
        delete execution_path(@execution)
      end.to change(Execution, :count).by(-1) and change(Proposal, :count).by(-1) and change(Estimation, :count).by(-1)
    end
  end
end
