module Raven
  class Breadcrumb
    def initialize
      @type = nil
      @typestamp = Time.new
      @level = nil
      @message = nil
      @category = nil
      @data = {}
    end
  end
end

module Raven
  class BreadcrumbBuffer
    def self.current
      Thread.current[:sentry_breadcrumbs] ||= new
    end

    def self.clear!
      Thread.current[:sentry_breadcrumbs] = nil
    end

    def initialize(size=100)
      @pos = 0
      @size = size
      @buffer = Array.new(size)
    end

    def record(crumb=nil)
      if block_given?
        crumb = Breadcrumb.new
        yield(crumb)
      end
      @buffer[@pos] = crumb;
      @pos = (@pos + 1) % @size;
    end
  end
end

