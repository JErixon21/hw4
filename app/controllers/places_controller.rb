class PlacesController < ApplicationController
  def index
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @places = Place.all # Always returns a relation, even if empty
    else
      flash["notice"] = "Please log in to see places."
      redirect_to "/login"
    end
  end

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.find_by({ "id" => params["id"] })
      if @place != nil
        @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @user["id"] })
      else
        redirect_to "/places"
      end
    else
      redirect_to "/login"
    end
  end

  def new
    @place = Place.new
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.new
      @place["name"] = params["name"]
      if @place.save
        redirect_to "/places"
      else
        render "new"
      end
    else
      redirect_to "/login"
    end
  end
end