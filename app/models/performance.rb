class Performance
  def initialize(performance_hash)
    @performance_hash = performance_hash
  end

  def artist
    @artist ||= Artist.new(@performance_hash.fetch("artist"))
  end

  def billing
    @performance_hash.fetch("billing")
  end

  def is_headline?
    billing == "headline"
  end
end
