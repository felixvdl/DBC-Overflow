# Question Routes

get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/new' do
  erb :'questions/new'
end

post '/questions' do
  @question = Question.new(title: params[:title], content: params[:content], user: current_user)
  if @question.save
    redirect '/questions'
  else
    @errors = @question.errors.full_messages
    erb :'questions/new'
  end
end

get '/questions/:id' do
  @answers = Question.find(params[:id]).answers
  @question = Question.find(params[:id])
  erb :'questions/show'
end

get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  erb :'questions/edit'
end

put '/questions/:id' do
  @question = Question.find(params[:id])
  redirect '/' unless authorized?(@question.user)
  @question.update_attributes(params[:question])
  redirect "/questions/#{params[:id]}"
end

delete "/questions/:id" do
  @question = Question.find(params[:id])
  redirect '/' unless authorized?(@question.user)
  @question.destroy
  redirect '/questions'
end
