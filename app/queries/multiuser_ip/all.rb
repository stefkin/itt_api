class MultiuserIp::All
  QUERY = <<-SQL
    WITH multiusers AS (
      SELECT author_ip, array_agg(DISTINCT user_id) as array_user_ids
      FROM posts
      GROUP BY author_ip
    ) SELECT author_ip, array_agg(login) as logins
      FROM multiusers INNER JOIN users
      ON users.id = any(multiusers.array_user_ids)
      GROUP BY author_ip
      HAVING COUNT(login) > 1;
  SQL

  def call
    ActiveRecord::Base.connection.exec_query(QUERY).map { |row|
      row.merge('logins' => marshalize_pg_array(row['logins']))
    }
  end

  private

  def marshalize_pg_array(serialized_array)
    serialized_array[1..-2].split(',')
  end
end
