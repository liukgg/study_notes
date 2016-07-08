mongoid 索引删除和创建分析
===============================================================

分析
------------------------------------------
- create_indexes 会创建model中声明的索引
- remove_indexes 会移除除了主键索引以外的所有索引
- remove_undefined_indexes 会移除model中未定义而在mongodb数据库中已经存在的索引
- Model.index_specifications 可以查看 Model 中声明的所有索引
- Model.collection.indexes 可以查看 Model 对应的mongodb数据库表 中实际存在的索引

结论
-------------------------------------------

如果用 remove_indexes + create_indexes ，那么每次都会删掉所有索引，从头开始建立，这样代价比较大；

所以，我觉得用   remove_undefined_indexes + create_indexes   可能更好


文档
--------------------------------------------

https://mongoid.github.io/en/mongoid/docs/indexing.html

http://www.rubydoc.info/github/mongoid/mongoid/Mongoid/Tasks/Database#create_indexes-instance_method


源代码
-------------------------------------------

```ruby
# lib/mongoid/tasks/database.rb

# encoding: utf-8
module Mongoid
  module Tasks
    module Database
      extend self

      # Create indexes for each model given the provided globs and the class is
      # not embedded.
      #
      # @example Create all the indexes.
      #   Mongoid::Tasks::Database.create_indexes
      #
      # @return [ Array<Class> ] The indexed models.
      #
      # @since 2.1.0
      def create_indexes(models = ::Mongoid.models)
        models.each do |model|
          next if model.index_specifications.empty?
          if !model.embedded? || model.cyclic?
            model.create_indexes
            logger.info("MONGOID: Created indexes on #{model}:")
            model.index_specifications.each do |spec|
              logger.info("MONGOID: Index: #{spec.key}, Options: #{spec.options}")
            end
            model
          else
            logger.info("MONGOID: Index ignored on: #{model}, please define in the root model.")
            nil
          end
        end.compact
      end

      # Return the list of indexes by model that exist in the database but aren't
      # specified on the models.
      #
      # @example Return the list of unused indexes.
      #   Mongoid::Tasks::Database.undefined_indexes
      #
      # @return Hash{Class => Array(Hash)} The list of undefined indexes by model.
      def undefined_indexes(models = ::Mongoid.models)
        undefined_by_model = {}

        models.each do |model|
          unless model.embedded?
            begin
              model.collection.indexes.each do |index|
                # ignore default index
                unless index['name'] == '_id_'
                  key = index['key'].symbolize_keys
                  spec = model.index_specification(key, index['name'])
                  unless spec
                    # index not specified
                    undefined_by_model[model] ||= []
                    undefined_by_model[model] << index
                  end
                end
              end
            rescue Mongo::Error::OperationFailure; end
          end
        end

        undefined_by_model
      end

      # Remove indexes that exist in the database but aren't specified on the
      # models.
      #
      # @example Remove undefined indexes.
      #   Mongoid::Tasks::Database.remove_undefined_indexes
      #
      # @return [ Hash{Class => Array(Hash)}] The list of indexes that were removed by model.
      #
      # @since 4.0.0
      def remove_undefined_indexes(models = ::Mongoid.models)
        undefined_indexes(models).each do |model, indexes|
          indexes.each do |index|
            key = index['key'].symbolize_keys
            collection = model.collection
            collection.indexes.drop_one(key)
            logger.info(
              "MONGOID: Removed index '#{index['name']}' on collection " +
              "'#{collection.name}' in database '#{collection.database.name}'."
            )
          end
        end
      end

      # Remove indexes for each model given the provided globs and the class is
      # not embedded.
      #
      # @example Remove all the indexes.
      #   Mongoid::Tasks::Database.remove_indexes
      #
      # @return [ Array<Class> ] The un-indexed models.
      #
      def remove_indexes(models = ::Mongoid.models)
        models.each do |model|
          next if model.embedded?
          begin
            model.remove_indexes
          rescue Mongo::Error::OperationFailure
            next
          end
          model
        end.compact
      end

      private
      def logger
        Mongoid.logger
      end
    end
  end
end

```
