class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :group_chats, dependent: :destroy

  has_one_attached :profile_image

  validates :name, presence: true
  validates :introduction, length: {maximum: 100}

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default.png')
      profile_image.attach(io: File.open(file_path), filename: 'default.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_fill:[width,height])
  end

  # ユーザーの認証が有効かを確認する場合に使用
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # 最新の投稿から表示する際に
  scope :latest, -> {order(created_at: :desc)}

  # ゲストユーザーでのログイン時に使用
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      # SecureRandomでランダムな文字列を生成してくれる
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  # ゲストユーザーか判定するメソッド
  def guest?
    name == 'ゲスト'
  end
end