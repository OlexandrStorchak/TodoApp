require 'rails_helper'
RSpec.describe Tasks::TasksFetchService do
  describe 'TasksFetchService' do
    let(:user) { create :user, :user }
    let(:admin) { create :user, :admin }
    let(:user_task) { create_list :task, 10, user_id: user.id }
    let(:admin_task) { create_list :task, 10, user_id: admin.id }
    it '#all_tasks' do
      result = Tasks::TasksFetchService.new(user, {}).call
      expect(result[:tasks].class).to be_a_kind_of(Task.class)
    end
    it '#all_users_tasks for admin' do
      result = Tasks::TasksFetchService.new(admin, { all_users_tasks: 'show' }).call
      expect(result[:msg]).to eq('All users tasks')
    end
    it '#all_users_tasks for non adnim' do
      result = Tasks::TasksFetchService.new(user, { all_users_tasks: 'show' }).call
      expect(result[:msg].class).not_to eq('All users tasks')
    end
    it '#all_tasks_by_user for admin' do
      result = Tasks::TasksFetchService.new(admin, { user_id: user.id }).call
      expect(result[:msg]).to eq("Tasks by user : #{user.email}")
    end
    it '#all_tasks_by_user for non admin' do
      result = Tasks::TasksFetchService.new(user, { user_id: user.id }).call
      expect(result[:msg]).not_to eq("Tasks by user : #{user.email}")
    end
    it '#sort_tasks_by_status' do
      result = Tasks::TasksFetchService.new(user, { sort_status: 'desc' }).call
      expect(result[:msg]).to eq('Sort by status')
    end
    it '#filter_tasks_by_status' do
      result = Tasks::TasksFetchService.new(user, { status: 'todo' }).call
      expect(result[:msg]).to eq('Filtered by "Todo" status')
    end
    it 'compare result tasks list with expected user' do
      result = Tasks::TasksFetchService.new(user, {}).call
      expect(result[:tasks]).to eq(user_task)
    end
    it 'compare result tasks list with expected admin' do
      result = Tasks::TasksFetchService.new(admin, {}).call
      expect(result[:tasks]).to eq(admin_task)
    end
  end
end
