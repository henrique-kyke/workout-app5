class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name

  self.per_page = 10

  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"

  def full_name
    [first_name, last_name].join(" ")
  end

  def self.search_by_name(name)
    names_array = name.split(" ")

    if names_array.size == 1
      where("first_name LIKE ? or last_name LIKE ?",
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
      where("first_name LIKE ? or first_name LIKE ? or last_name LIKE ? or last_name LIKE ?",
        "%#{names_array[0]}%", "%#{names_array[1]}%", "%#{names_array[0]}%", "%#{names_array[1]}%").order(:first_name)
    end
  end

  def follows_or_same?(user)
    friendships.map(&:friend).include?(user) || self == user
  end
end
