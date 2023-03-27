class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :group_users, dependent: :destroy
  has_many :group_chats, dependent: :destroy

  has_one_attached :profile_image

  validates :name, presence: true

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default.png')
      profile_image.attach(io: File.open(file_path), filename: 'default.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_fill:[width,height])
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  # ゲストユーザーでのログイン時に使用
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      # SecureRandomでランダムな文字列を生成してくれる
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end
end