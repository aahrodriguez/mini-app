class AddAvatarToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :avatar, :integer
  end
end
