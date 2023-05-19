class SearchController < ApplicationController
  before_action :authenticate_user!
  def index
    @search_entries =
      SearchEntry.where(
        "name LIKE ?",
        "%#{params[:query]}%",
      ) if params[:query]
  end
end
