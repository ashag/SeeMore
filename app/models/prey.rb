class Prey < ActiveRecord::Base
  validates name, presence: :true
  validates :email, presence: :true, uniqueness: true, format: { with: /\w+@\w+\.\w{3}/i }
end
