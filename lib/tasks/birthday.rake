task :birthday => :environment do
  users = User.where('status = :s AND DAY(birth_date) = :d AND MONTH(birth_date) = :m', :s => User::STATUS_ACTIVE, :d => Time.now.day,:m => Time.now.month)
  post_type = PostType.where(:name => 'birthday').first
  
  users.each do |u|
    p = Post.new
    p.user_id = u.id
    p.group_id = 0
    p.post_type_id = post_type.id
    p.content = I18n.t(:happy_birthday, :name => u.display_name)
    p.status = Post::ACTIVE
    p.limited = 0
    p.save
  end
end
