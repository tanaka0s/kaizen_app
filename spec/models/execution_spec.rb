require 'rails_helper'

RSpec.describe Execution, type: :model do
  before do
    user = FactoryBot.create(:user)
    proposal = FactoryBot.create(:proposal)
    @execution = FactoryBot.build(:execution, user_id: user.id, proposal_id: proposal.id)
    sleep 0.1
  end

  describe '改善提案実行の投稿' do
    context '投稿できる場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@execution).to be_valid
      end
    end
    context '投稿できない場合' do
      it 'userが紐付いていないと保存できない' do
        @execution.user = nil
        @execution.valid?
        expect(@execution.errors.full_messages).to include('User must exist')
      end
      it 'proposalが紐付いていないと保存できない' do
        @execution.proposal = nil
        @execution.valid?
        expect(@execution.errors.full_messages).to include('Proposal must exist')
      end
      it 'imageが空では投稿できない' do
        @execution.image = nil
        @execution.valid?
        expect(@execution.errors.full_messages).to include("Image can't be blank")
      end
      it 'whereが空では投稿できない' do
        @execution.where = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("Where can't be blank")
      end
      it 'whatが空では投稿できない' do
        @execution.what = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("What can't be blank")
      end
      it 'whyが空では投稿できない' do
        @execution.why = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("Why can't be blank")
      end
      it 'howが空では投稿できない' do
        @execution.how = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("How can't be blank")
      end
      it 'hourly_wageが空では投稿できない' do
        @execution.hourly_wage = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("Hourly wage can't be blank")
      end
      it 'hourly_wageが100001以上では投稿できない' do
        @execution.hourly_wage = '100001'
        @execution.valid?
        expect(@execution.errors.full_messages).to include('Hourly wage is out of setting range')
      end
      it 'after_secondsが空では投稿できない' do
        @execution.after_seconds = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("After seconds can't be blank")
      end
      it 'after_secondsが100001以上では投稿できない' do
        @execution.after_seconds = '100001'
        @execution.valid?
        expect(@execution.errors.full_messages).to include('After seconds is out of setting range')
      end
      it 'after_workersが空では投稿できない' do
        @execution.after_workers = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("After workers can't be blank")
      end
      it 'after_workersが100001以上では投稿できない' do
        @execution.after_workers = '100001'
        @execution.valid?
        expect(@execution.errors.full_messages).to include('After workers is out of setting range')
      end
      it 'after_daysが空では投稿できない' do
        @execution.after_days = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("After days can't be blank")
      end
      it 'after_daysが366以上では投稿できない' do
        @execution.after_days = '366'
        @execution.valid?
        expect(@execution.errors.full_messages).to include('After days is out of setting range')
      end
      it 'after_man_hoursが空では投稿できない' do
        @execution.after_man_hours = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("After man hours can't be blank")
      end
      it 'after_man_hoursが10桁以上では投稿できない' do
        @execution.after_man_hours = '1000000000'
        @execution.valid?
        expect(@execution.errors.full_messages).to include('After man hours is out of setting range')
      end
      it 'reduced_man_hoursが空では投稿できない' do
        @execution.reduced_man_hours = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("Reduced man hours can't be blank")
      end
      it 'reduced_man_hoursが10桁以上では投稿できない' do
        @execution.reduced_man_hours = '1000000000'
        @execution.valid?
        expect(@execution.errors.full_messages).to include('Reduced man hours is out of setting range')
      end
      it 'after_costsが空では投稿できない' do
        @execution.after_costs = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("After costs can't be blank")
      end
      it 'after_costsが2_147_483_648以上では投稿できない' do
        @execution.after_costs = '2147483648'
        @execution.valid?
        expect(@execution.errors.full_messages).to include('After costs is out of setting range')
      end
      it 'reduced_costsが空では投稿できない' do
        @execution.reduced_costs = ''
        @execution.valid?
        expect(@execution.errors.full_messages).to include("Reduced costs can't be blank")
      end
      it 'reduced_costsが2_147_483_648以上では投稿できない' do
        @execution.reduced_costs = '2147483648'
        @execution.valid?
        expect(@execution.errors.full_messages).to include('Reduced costs is out of setting range')
      end
    end
  end
end
