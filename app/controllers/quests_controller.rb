class QuestsController < ApplicationController

  include UsersHelper
  include BuildHashHelper


  def index
    # also route for active_quests
    @quests = Quest.user_accepted_quests(current_user)
  end

  def active_quests
    @quests = Quest.user_accepted_quests(current_user)
    render partial: "quests/display_quests"
  end

  def available_quests
    @quests = Quest.user_available_quests(current_user)
    render partial: "quests/available_quests"
  end

  def completed_quests
    @quests = Quest.user_completed_quests(current_user)
    render partial: "quests/display_quests"
  end

  def created_quests
    @quests = Quest.user_created_quests(current_user)
    render partial: "quests/display_quests"
  end

  def sort_quests
    @quests = Quest.user_available_quests(current_user)
    @quests.sort! { |a,b| a.xp <=> b.xp }
    render partial: "quests/display_quests"
  end

  def edit_quests
    render partial: "quests/display_quests"
  end


  def create_quests
    @user_quest = UserQuest.new
    @quest = Quest.new
    render partial: "create_quests"
  end


# API METHODS


  def all
    @user_quest = UserQuest.new
    @quests = Quest.all.select { |quest| quest.checkpoints.length >= 1  }
    @hash = build_quests_hash(@quests)
    render json: @hash
  end

  def user_accepted_quests_loc
    @quests = Quest.user_accepted_quests(current_user)
    @hash = build_hash(@quests)
    render json: @hash
  end

  def user_created_quests_loc
    @quests = Quest.user_created_quests(current_user)
    @hash = build_hash(@quests)
    render json: @hash
  end

  def user_completed_quests_loc
    @quests = Quest.user_completed_quests(current_user)
    @hash = build_hash(@quests)
    render json: @hash
  end


  def accept_form
    @user_quest = UserQuest.new
    @quest = Quest.find(params[:quest_id])
    render partial: "quests/accept_form", layout: false
  end



  def accept
    @user_quest = UserQuest.new(user_quest_params)
    quest_id = params[:user_quest][:quest_id]
    user_id = session[:user_id]
    if @user_quest.save
      quest = Quest.find(quest_id)
      quest.checkpoints.each do |checkpoint|
        UserCheckpoint.create(user_id: user_id, checkpoint_id: checkpoint.id)
      end
      flash[:notice] = "Quest successfully accepted"
      render partial: "quests/accepted", layout: false
    else
      flash[:notice] = "Please try again"
      render partial: "quests/rejected", layout: false
    end

  end


  def create
    @checkpoint = Checkpoint.new
    @quest = Quest.new(quest_params)
    if @quest.save
      render partial: 'quests/quest_loc'
    else
      flash[:notice] = "Please try again"
      render partial: 'quests/rejected'
    end

  end

  def set_location
    params[:location] = params[:checkpoint][:locations]
    @location = Location.new(location_params)
    @location.save

    params[:checkpoint][:location_id] = @location.id

    @checkpoint = Checkpoint.new(checkpoint_params)
    if @checkpoint.save
      render json: search_venues
    else
      flash[:notice] = "Please try again"
      redirect_to quests_path
    end

  end

  def search_venues
    query = @location.name
    ll = [@location.latitude, @location.longitude].join(',')
    api = Fsqr.new(session[:token])
    @venues = api.search(query, ll, @location.id)
  end

  def commit_location
    @location = Location.find(params[:venue][:location_id])
    @location.update(venue_params)
    redirect_to quests_path
  end

  private


  def checkpoint_params
    params.require(:checkpoint).permit(:instructions, :quest_id, :location_id)
  end

  def user_quest_params
    params[:user_quest][:user_id] = current_user.id #hard code to 1 for local
    params.require(:user_quest).permit(:user_id, :quest_id, :completed)
  end

  def quest_params
    params[:quest][:creator_id] = current_user.id #hard code to 1 for local
    params.require(:quest).permit(:creator_id, :title, :description, :user_limit, :category, :end_date)
  end

  def location_params
    params.require(:location).permit(:name, :street, :city, :state, :zip)
  end

  def venue_params
    params.require(:venue).permit(:name, :venue_type, :second_type, :latitude, :longitude, :foursquare_id, :street, :city, :state, :zip, :country)
  end

end
