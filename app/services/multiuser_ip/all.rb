class MultiuserIp::All
  def call
    Post.joins(:user)
      .select('posts.author_ip, array_agg(users.login) as logins')
      .having('COUNT(users.login) > 1')
      .group('posts.author_ip')
  end
end
