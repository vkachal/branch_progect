class BranchApp

  class << self

    def register_page_object(klass)
      # class name to method name:
      method_name = klass.name.scan(/[A-Z][a-z]+/).map(&:downcase).join('_').to_sym
      return if self.method_defined?(method_name)
      # define_method if it wasn't defined yet:
      define_method(method_name) do
        klass.new
      end
    end

  end

end
