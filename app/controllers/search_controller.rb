class SearchController < ApplicationController
  def index
    @search_entries =
      SearchEntry.where(
        "name LIKE ?",
        "%#{params[:query]}%",
      ) if params[:query]
  end
end
