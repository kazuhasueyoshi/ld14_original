require "bundler/setup"
Bundler.require
require "sinatra/reloader" if development?
require "open-uri"
require "sinatra/json"
require "./models/models.rb"
require 'tempfile'

enable :sessions

before do
  Dotenv.load
  Cloudinary.config do |config|
    config.cloud_name = ENV["CLOUD_NAME"]
    config.api_key = ENV["CLOUDINARY_API_KEY"]
    config.api_secret = ENV["CLOUDINARY_API_SECRET"]
  end
end

get "/" do
  redirect "/login"
end

get "/signup" do
  erb :signup
end

get "/login" do
  erb :login
end

get "/signout" do
  session[:user] = nil
  redirect "/"
end

get "/setting" do
  @user = User.find(session[:user])
  if  @user.distinct_user == 1
    @univstudent = Univstudent.where(id: @user.univstudent_id).first
  else
    @student = Student.where(id: @user.student_id).first
  end
  erb :setting
end

get "/dmlist" do
  erb :dmlist
end

get "/chatroom/:id" do
  my_user = Participant.where(user_id: session[:user]).pluck(:chatroom_id)
  oppo_user = Participant.where(user_id: params[:id]).pluck(:chatroom_id)
  unless my_user.empty? && oppo_user.empty?
    @match_chatroom = my_user & oppo_user
    @match_chatroom = @match_chatroom[0]
  else
    @match_chatroom = nil
  end
  if @match_chatroom == nil
    chatroom = Chatroom.create()
    @match_chatroom = chatroom.id
    Participant.create({
      chatroom_id: chatroom.id,
      user_id: params[:id]
      })
    Participant.create({
      chatroom_id: chatroom.id,
      user_id: session[:user]
      })
    @messages = Message.where(chatroom_id: chatroom.id)
  else
    @messages = Message.where(chatroom_id: @match_chatroom)
  end
  @oppo_id = params[:id]
  erb :chatroom
end

get "/search" do
  @univstudents = Univstudent.where('name like ?', "%#{params[:keyword]}%")
  @user = User.find(session[:user])
  erb :search
end

get "/bord" do
  @contents = Content.all.order("id desc")
  @comments = Comment.all.order("id desc")
  erb :bord
end

post "/signup" do
  if params[:distinct_user] == 0
    student = Student.create()
    user = User.create(
      mail: params[:mail], 
      student_id: student.id,
      univstudent_id: nil,
      password: params[:password],
      password_confirmation: params[:password_confirmation], 
      distinct_user: params[:distinct_user]
      )
    if user.persisted?
      session[:user] = user.id
    end
  else
    univstudent = Univstudent.create()
    user = User.create({
      mail: params[:mail], 
      student_id: nil,
      univstudent_id: univstudent.id,
      password: params[:password],
      password_confirmation: params[:password_confirmation], 
      distinct_user: params[:distinct_user],
      })
    if user.persisted?
      session[:user] = user.id
    end
  end
  redirect '/setting'
end

post "/login" do
  user = User.find_by(mail: params[:mail])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/bord'
end

post "/setting" do
  @user = User.find(session[:user])
  if @user.distinct_user == 0
    @student = student.where(id: @user.student_id).first
    if params[:name] == ""
      params[:name] = @student.name
    end
    if params[:school_name] == ""
      params[:school_name] = @student.school_name
    end
    if params[:free_body] == ""
      params[:free_body] = @student.free_body
    end
    @student.update({
    name: params[:name],
    school_name: params[:school_name],
    free_body: params[:free_body],
  })
  else
    univstudent = Univstudent.where(id: @user.univstudent_id).first
    if params[:name] == "" && !(univstudent.name.nil?)
      params[:name] = univstudent.name
    end
    if params[:univ_name] == "" && !(univstudent.univ_name.nil?)
      params[:univ_name] = univstudent.univ_name
    end
    if params[:undergraduate_name] == "" && !(univstudent.undergraduate_name.nil?)
      params[:undergraduate_name] = univstudent.undergraduate_name
    end
    if params[:department_name] == "" && !(univstudent.department_name.nil?)
      params[:department_name] = univstudent.department_name
    end
    if params[:circle_name] == "" && !(univstudent.circle_name.nil?)
      params[:circle_name] = univstudent.circle_name
    end
    if params[:free_body] == "" && !(univstudent.free_body.nil?)
      params[:free_body] = univstudent.free_body
    end
    univstudent.update({
    name: params[:name],
    univ_name: params[:univ_name],
    undergraduate_name: params[:undergraduate_name],
    department_name: params[:department_name],
    circle_name: params[:circle_name],
    free_body: params[:free_body]
    })
  end
  redirect "/setting"
end


post "/newmessage/:chatroom_id/:oppo_id" do
  Message.create({
    chatroom_id: params[:chatroom_id],
    user_id: session[:user],
    body: params[:body]
  })
  root = "/chatroom/" + params[:oppo_id].to_s
  redirect root
end

post "/newcontent" do
  img_url = ""
  if params[:file]
    img = params[:file]
    tempfile = img[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    img_url = upload["url"]
  end

  Content.create({
    user_id: session[:user],
    title: params[:title],
    body: params[:body],
    img: img_url,
  })

  redirect "/bord"
end

post "/newcomment/:id" do
  Comment.create({
    user_id: session[:user],
    content_id: params[:id],
    body: params[:body]
  })
  redirect "/bord"
end


post "/good/:id" do
  content = Contribution.find(params[:id])
  good = content.good
  content.update({
    good: good + 1,
  })
  redirect "/"
end