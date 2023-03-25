class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    @line.partition(': ').last.strip
  end

  def log_level
    @line.split('[').last.split(']').first.downcase
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
