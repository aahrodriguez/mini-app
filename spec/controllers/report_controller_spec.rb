require 'rails_helper'

RSpec.describe ReportController, type: :controller do
  context "GET #index" do
    it "should render to index page" do
      get :index
      expect(response).to render_template(:index)
    end

    it "should be empty" do
      get :index
      expect(assigns(:tasks)).to be_empty
      expect(assigns(:comments)).to be_empty
    end

    it "should have 1 item each" do
      user = User.create(email: "test@test.com", password: 123123)
      task = Task.create(description: "Description Test", title: "Title test", user_id: user.id)
      Comment.create(body: "Body Test", task_id: task.id, user_id: user.id)
      get :index
      expect(assigns(:tasks)).to_not be_empty
      expect(assigns(:comments)).to_not be_empty
    end
  end

  context "GET user_complete" do
    it "should let a current_user see his own report" do
      login_with create( :user )
      get :user_complete
      expect( response ).to render_template( :user_complete )
    end

    it "Task complete" do
      user = User.create(email: "test@test.com", password: 123123)
      task = Task.create(description: "Description Test2", title: "Title test2", user_id: user.id, status: 'incomplete')
      expect(task.status.to_i).to_not eq 1
    end

    it "Comments sorted alphabetically" do
      user = User.create(email: "test@test.com", password: 123123)
      task = Task.create(description: "Description Test", title: "Title test", user_id: user.id)
      Comment.create(body: "CCC Body Test", task_id: task.id, user_id: user.id)
      Comment.create(body: "Body Test", task_id: task.id, user_id: user.id)
       Comment.create(body: "Any body started with A", task_id: task.id, user_id: user.id)
       expect(Comment.all.order(:body).first.body).to eq "Any body started with A"
    end
  end
end
