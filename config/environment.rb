# Load the Rails application.
require_relative 'application'

module ActiveSupport
  class ConfigurationFile # :nodoc:
    def parse(context: nil, **options)
      source = render(context)
      begin
        YAML.load(source, aliases: true, **options) || {}
      rescue ArgumentError
        YAML.load(source, **options) || {}
      end
    rescue Psych::SyntaxError => error
      raise "YAML syntax error occurred while parsing #{@content_path}. " \
            "Please note that YAML must be consistently indented using spaces. Tabs are not allowed. " \
            "Error: #{error.message}"
    end
  end
end

# Initialize the Rails application.
Rails.application.initialize!

ActiveRecord::SchemaDumper.ignore_tables = ['deprecated_preview_cards']
