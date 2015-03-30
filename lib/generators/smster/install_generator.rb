require 'rails/generators'
module Smster
  class InstallGenerator < Rails::Generators::Base
    desc "Add migration"
    include Rails::Generators::Migration
    source_root File.expand_path('../install/templates', __FILE__)

    def copy_migrations
      copy_migration "create_smsters"
    end

    def self.next_migration_number(path)
      unless @prev_migration_nr
        @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      else
        @prev_migration_nr += 1
      end
      @prev_migration_nr.to_s
    end

    protected
      def copy_migration(filename)
        if self.class.migration_exists?("db/migrate", "#{filename}")
          say_status("skipped", "Migration #{filename}.rb already exists")
        else
          migration_template "#{filename}.rb", "db/migrate/#{filename}.rb"
        end
      end
  end
end
