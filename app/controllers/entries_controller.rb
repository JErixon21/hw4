class EntriesController < ApplicationController
  def new
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.find_by({ "id" => params["place_id"] })
      if @place != nil
        @entry = Entry.new
      else
        flash["notice"] = "Place not found."
        redirect_to "/places"
      end
    else
      flash["notice"] = "Please log in to add an entry."
      redirect_to "/login"
    end
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.find_by({ "id" => params["place_id"] })
      if @place != nil
        @entry = Entry.new
        @entry["title"] = params["title"]
        @entry["description"] = params["description"]
        @entry["occurred_on"] = params["occurred_on"]
        @entry["place_id"] = params["place_id"]
        @entry["user_id"] = @user["id"]
        if @entry.save
          flash["notice"] = "Entry created successfully."
          redirect_to "/places/#{@entry["place_id"]}"
        else
          flash["notice"] = "Entry failed: Please fill in all required fields."
          render "new"
        end
      else
        flash["notice"] = "Place not found."
        redirect_to "/places"
      end
    else
      flash["notice"] = "Please log in to add an entry."
      redirect_to "/login"
    end
  end
end