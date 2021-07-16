# StocketMetric
class StocketMetric
  attr_accessor(:start, :duration, :name)

  def self.start(metric_name)
    @start = Time.now
    @name = metric_name
  end

  def self.end
    metric_end = Time.now
    @duration = (metric_end - @start) * 1000
    Rails.logger.info "[STOCKET-METRIC] #{@name} took #{format('%f', @duration)}ms"
  end
end
