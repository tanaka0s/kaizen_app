require 'rails_helper'

RSpec.describe ProposalEstimation, type: :model do
  before do
    user = FactoryBot.create(:user)
    @proposal_estimation = FactoryBot.build(:proposal_estimation, user_id: user.id)
  end

  describe '改善提案の新規投稿' do
    context '新規投稿できる場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@proposal_estimation).to be_valid
      end
    end
    context '新規投稿できない場合' do
      it 'user_idが空では保存できない' do
        @proposal_estimation.user_id = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("User can't be blank")
      end
      it 'imageが空では投稿できない' do
        @proposal_estimation.image = nil
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Image can't be blank")
      end
      it 'titleが空では投稿できない' do
        @proposal_estimation.title = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Title can't be blank")
      end
      it 'whereが空では投稿できない' do
        @proposal_estimation.where = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Where can't be blank")
      end
      it 'whatが空では投稿できない' do
        @proposal_estimation.what = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("What can't be blank")
      end
      it 'whyが空では投稿できない' do
        @proposal_estimation.why = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Why can't be blank")
      end
      it 'howが空では投稿できない' do
        @proposal_estimation.how = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("How can't be blank")
      end
      it 'before_secondsが空では投稿できない' do
        @proposal_estimation.before_seconds = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Before seconds can't be blank")
      end
      it 'before_secondsが100001以上では投稿できない' do
        @proposal_estimation.before_seconds = '100001'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('Before seconds is out of setting range')
      end
      it 'before_workersが空では投稿できない' do
        @proposal_estimation.before_workers = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Before workers can't be blank")
      end
      it 'before_workersが100001以上では投稿できない' do
        @proposal_estimation.before_workers = '100001'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('Before workers is out of setting range')
      end
      it 'hourly_wageが空では投稿できない' do
        @proposal_estimation.hourly_wage = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Hourly wage can't be blank")
      end
      it 'hourly_wageが100001以上では投稿できない' do
        @proposal_estimation.hourly_wage = '100001'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('Hourly wage is out of setting range')
      end
      it 'after_secondsが空では投稿できない' do
        @proposal_estimation.after_seconds = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("After seconds can't be blank")
      end
      it 'after_secondsが100001以上では投稿できない' do
        @proposal_estimation.after_seconds = '100001'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('After seconds is out of setting range')
      end
      it 'after_workersが空では投稿できない' do
        @proposal_estimation.after_workers = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("After workers can't be blank")
      end
      it 'after_workersが100001以上では投稿できない' do
        @proposal_estimation.after_workers = '100001'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('After workers is out of setting range')
      end
      it 'before_costsが空では投稿できない' do
        @proposal_estimation.before_costs = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Before costs can't be blank")
      end
      it 'before_costsが2_147_483_648以上では投稿できない' do
        @proposal_estimation.before_costs = '2147483648'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('Before costs is out of setting range')
      end
      it 'after_costsが空では投稿できない' do
        @proposal_estimation.after_costs = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("After costs can't be blank")
      end
      it 'after_costsが2_147_483_648以上では投稿できない' do
        @proposal_estimation.after_costs = '2147483648'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('After costs is out of setting range')
      end
      it 'reduced_costsが空では投稿できない' do
        @proposal_estimation.reduced_costs = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Reduced costs can't be blank")
      end
      it 'reduced_costsが2_147_483_648以上では投稿できない' do
        @proposal_estimation.reduced_costs = '2147483648'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('Reduced costs is out of setting range')
      end
      it 'before_man_hoursが空では投稿できない' do
        @proposal_estimation.before_man_hours = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Before man hours can't be blank")
      end
      it 'before_man_hoursが10桁以上では投稿できない' do
        @proposal_estimation.before_man_hours = '1000000000'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('Before man hours is out of setting range')
      end
      it 'after_man_hoursが空では投稿できない' do
        @proposal_estimation.after_man_hours = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("After man hours can't be blank")
      end
      it 'after_man_hoursが10桁以上では投稿できない' do
        @proposal_estimation.after_man_hours = '1000000000'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('After man hours is out of setting range')
      end
      it 'reduced_man_hoursが空では投稿できない' do
        @proposal_estimation.reduced_man_hours = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Reduced man hours can't be blank")
      end
      it 'reduced_man_hoursが10桁以上では投稿できない' do
        @proposal_estimation.reduced_man_hours = '1000000000'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('Reduced man hours is out of setting range')
      end
      it 'before_daysが空では投稿できない' do
        @proposal_estimation.before_days = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("Before days can't be blank")
      end
      it 'before_daysが366以上では投稿できない' do
        @proposal_estimation.before_days = '366'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('Before days is out of setting range')
      end
      it 'after_daysが空では投稿できない' do
        @proposal_estimation.after_days = ''
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include("After days can't be blank")
      end
      it 'after_daysが366以上では投稿できない' do
        @proposal_estimation.after_days = '366'
        @proposal_estimation.valid?
        expect(@proposal_estimation.errors.full_messages).to include('After days is out of setting range')
      end
    end
  end
end
