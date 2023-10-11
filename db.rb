class DB
  DATABASES = {
    'payments': 1,
    'refunds': 2,
  }.freeze

  def initialize(db)
    @db = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'].to_i, db: DATABASES[db])
  end

  def list
    collection = {}
    @db.keys.each do |key|
      collection.store(key, @db.get(key))
    end

    collection
  end

  def has(key)
    @db.exists(key)
  end

  def get(key)
    @db.get(key)
  end

  def set(key, value)
    @db.set(key, serialize(value))
  end

  def delete(key)
    @db.unlink(key)
  end

  private

  def serialize(object)
    object.to_json
  end

  def unserialize(object)
    JSON.parse(object, symbolize_names: true)
  end

end
