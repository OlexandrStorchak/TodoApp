require 'rails_helper'
RSpec.describe Tasks::TasksFetchService do
  let(:user) { create :user, :user }
  let(:admin) { create :user, :admin }
  let(:user_task) { create_list :task, 10, user_id: user.id }

  let(:show_all_users_tasks_admin) { Tasks::TasksFetchService.new(admin, { all_users_tasks: 'show' }).call }
  let(:all_tasks_by_user_admin) { Tasks::TasksFetchService.new(admin, { user_id: user.id }).call }

  let(:tasks_blank_params) { Tasks::TasksFetchService.new(user, {}).call }
  let(:show_all_users_tasks) { Tasks::TasksFetchService.new(user, { all_users_tasks: 'show' }).call }
  let(:all_tasks_by_user) { Tasks::TasksFetchService.new(user, { user_id: user.id }).call }
  let(:sort_tasks_by_status) { Tasks::TasksFetchService.new(user, { sort_status: 'desc' }).call }
  let(:filter_tasks_by_status) { Tasks::TasksFetchService.new(user, { status: 'todo' }).call }

  describe '#call' do
    context '#all_tasks response hash' do
      it { expect(tasks_blank_params).to include(:tasks) }
    end
    context '#show_all_users_tasks_admin response hash with msg' do
      it { expect(show_all_users_tasks_admin).to include(:tasks, :msg) }
    end
  end

  describe '#call' do
    context '#all_users_tasks for admin' do
      it { expect(show_all_users_tasks_admin[:msg]).to eq('All users tasks') }
    end
    context '#all_tasks_by_user for admin' do
      it { expect(all_tasks_by_user_admin[:msg]).to eq("Tasks by user : #{user.email}") }
    end
  end

  describe '#call' do
    context '#all_tasks for user' do
      it { expect(tasks_blank_params[:tasks].class).to be_a_kind_of(Task.class) }
    end
    context '#all_users_tasks for user' do
      it { expect(show_all_users_tasks[:msg]).not_to eq('All users tasks') }
    end
    context '#all_tasks_by_user for user' do
      it { expect(all_tasks_by_user[:msg]).not_to eq("Tasks by user : #{user.email}") }
    end
    context '#sort_tasks_by_status for user' do
      it { expect(sort_tasks_by_status[:msg]).to eq('Sort by status') }
    end
    context '#filter_tasks_by_status for user' do
      it { expect(filter_tasks_by_status[:msg]).to eq('Filtered by "Todo" status') }
    end
  end

  describe '#call' do
    context 'compare results' do
      it { expect(tasks_blank_params[:tasks]).to eq(user_task) }
    end
  end
end
