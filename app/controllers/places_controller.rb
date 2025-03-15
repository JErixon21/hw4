class PlacesController < ApplicationController
  # ... other actions ...

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.find_by({ "id" => params["id"] })
      if @place != nil
        @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @user["id"] }) # Only user's entries
      else
        redirect_to "/places"
      end
    else
      redirect_to "/login"
    end
  end

  # ... other actions ...
end