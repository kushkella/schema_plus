module SchemaPlusDefaultExpr
  module ActiveRecord
    module ConnectionAdapters

      module Sqlite3Adapter
        def self.prepended(base)
          SchemaMonkey.insert_module ::ActiveRecord::ConnectionAdapters::Column, SQLiteColumn
        end

        def default_expr_valid?(expr)
          true # arbitrary sql is okay
        end

        def sql_for_function(function)
          case function
          when :now
            "(DATETIME('now'))"
          end
        end
      end

      module SQLiteColumn

        def default_function
          @default_function ||= "(#{default})" if default =~ /DATETIME/
          super
        end
      end
    end
  end
end
