module PostsHelper
  def post_date(date)
    if "#{date.year}#{date.month}#{date.day}" == "#{Time.now.year}#{Time.now.month}#{Time.now.day}"
      r_date = date.strftime "%l:%M %p"
    elsif "#{date.year}#{date.month}#{date.day}" == "#{Time.now.year}#{Time.now.month}#{Time.now.day - 1}"
      r_date = "#{t :yesterday} #{date.strftime "%l:%M %p"}"
    else
      r_date = l date, :format => :short
    end
  end
end
