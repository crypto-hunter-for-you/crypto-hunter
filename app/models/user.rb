class User < ApplicationRecord
  has_many :offer_histories, dependent: :destroy
  has_many :recommend_projects, dependent: :destroy
  has_many :user_like_projects, dependent: :destroy
  has_many :user_points, dependent: :destroy

  validates_uniqueness_of :address

  def fetch_history(offer_id)
    offer_histories.where(offer_id: offer_id).take
  end

  def fetch_history_status(offer_id)
    h = fetch_history(offer_id)
    if h&.taken?
      "INCOMPLETE"
    elsif h&.done?
      "COMPLETE"
    else
      "NOT STARTED"
    end
  end

  def point
    user_points.first_or_create
  end
end
