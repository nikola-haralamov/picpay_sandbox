class DB
  DATABASES = {
    accounts: 0,
    payments: 1,
    refunds: 2,
  }.freeze

  def initialize(db)
    @db = Redis.new(
      host: ENV['REDIS_HOST'].to_s,
      port: ENV['REDIS_PORT'].to_i,
      db:DATABASES[db.to_sym],
    )
  end

  def list
    collection = {}
    @db.keys.each do |key|
      collection.store(key, @db.get(key))
    end

    collection
  end

  def has(key)
    @db.exists?(key)
  end

  def get(key)
    collection = @db.get(key)

    unserialize(collection) unless collection.nil?
  end

  def create(key, value)
    @db.set(key, serialize(value), nx: true)
  end

  def update(key, value)
    @db.set(key, serialize(value), xx: true)
  end

  def persist(key)
    @db.persist(key)
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
