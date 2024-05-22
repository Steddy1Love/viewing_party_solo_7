class SimilarController < ApplicationController
  def index
    @facade = MovieFacade.new(id: params[:movie_id])
  end
end