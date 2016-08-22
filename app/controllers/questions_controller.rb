class QuestionsController < ApplicationController
  # before_action takes in an arguement for a method (ideally private) that gets executed just before the action and it's still within the request/response cycle
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :destroy, :update, :new]
  before_action :authorize, only: [:destroy, :update, :delete ]

  QUESTIONS_PER_PAGE = 10

  # GET /questions/new
  def new

    # we need to instantiate a new Question object because it will help us build
    # a form to create a question easily
    # @question = Question.new title: "abc"
    @question = Question.new

    # render :new
    # render "/questions/new"
  end

  def create
    # question_params  = params.require(:question).permit([:title, :body])
    @question        = Question.new question_params
    @question.user   = current_user
    if @question.save
      # render json: params
      # render :show

      # all the methods below will work to redirect the user:
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})

      # flash[:notice] = "Question created successfully"
      redirect_to question_path(@question), notice: "Question created successfully"
      # redirect_to @question

    else
      flash[:alert] = "Please fix errors below before saving"
      render :new
    end
  end

  def show
    # @question = Question.find params[:id]
    @answer = Answer.new      # we want to create a new answer
  end

  def index
    @questions = Question.order(created_at: :desc).
                          page(params[:page]).
                          per(QUESTIONS_PER_PAGE)
  end

  def edit
    # @question = Question.find params[:id]
  end

  def update
    # @question = Question.find params[:id]
    if @question.update question_params # params.require(:question).permit([:title, :body])
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    # question = Question.find params[:id]
    @question.destroy
    redirect_to questions_path
  end

  private

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    # {
    #   "utf8": "â",
    #   "authenticity_token": "...",
    #   "question": {
    #     "title": "asd fasdff",
    #     "body": "asdf asd f"
    #   },
    #   "commit": "Create Question",
    #   "controller": "questions",
    #   "action": "create"
    # }

    # we're using the `strong parameters` feature of Rails here to only allow
    # mass-assigning the attributes that we want to allow the user to set
    params.require(:question).permit([:title, :body])
  end

  def authorize!
     redirect_to root_path, alert: "access defined" unless can? :manage, @question
   end








end
