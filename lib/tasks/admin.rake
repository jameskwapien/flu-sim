#lib/tasks/admin.rake
desc "Changes all existing User records to have admin value of false"
task admin: :environment do
  @users = User.all
  @users.each do |user|
    user.update_attribute :admin, false
  end
end
