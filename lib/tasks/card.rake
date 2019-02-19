task :card => :environment do
  users = User.where('status = :s AND DAY(birth_date) = :d AND MONTH(birth_date) = :m', :s => User::STATUS_ACTIVE, :d => Time.now.day,:m => Time.now.month)
  users.each do |u|
    puts u.full_name
    BirthdayCardMailer.birthday_card(u).deliver
  end
end
