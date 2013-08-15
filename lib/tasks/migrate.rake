task migration: :environment do
  db = SQLite3::Database.new "backup.sqlite3"
  db.execute("SELECT * FROM users") do |row|
    User.create!(email: row[1],
                encrypted_password: row[2],
                remember_created_at: row[5],
                sign_in_count: row[6],
                current_sign_in_at: row[7],
                last_sign_in_at: row[8],
                current_sign_in_ip: row[9],
                last_sign_in_ip: row[10])
  end
  db.execute("SELECT * FROM posts") do |row|
    day = nil
    db.execute("SELECT date from days WHERE id=#{row[5]} LIMIT 1") do |row|
      day = row.first
    end
    Post.create!(title: row[1],
                body: row[2],
                date: day,
                created_at: row[3],
                updated_at: row[4])
  end
  db.execute("SELECT * FROM days") do |row|
    Day.create!(date: row[1],
               summary: row[2],
               metadatas: YAML.load(row[3]),
               impact: row[6],
               created_at: row[4],
               updated_at: row[5])
  end
end
