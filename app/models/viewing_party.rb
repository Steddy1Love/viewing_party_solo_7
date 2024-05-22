class ViewingParty < ApplicationRecord
  validate :duration_cannot_be_less_than_movie_time

  has_many :user_parties
  has_many :users, through: :user_parties

  def find_host
    users.where('user_parties.host = true').first
  end

  def duration_cannot_be_less_than_movie_time
    if duration.present? && movie_id.present? && duration < movie.runtime
      errors.add(:duration, "can't be shorter than movie runtime")
    end
  end

  def movie
    @movie ||=
      if movie_id.present?
        MovieFacade.new(id: movie_id).movie
      end
  end
end