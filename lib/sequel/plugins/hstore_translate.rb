require 'sequel/plugins/hstore_translate/version'
require 'sequel/model'

module Sequel
  module Plugins
    module HstoreTranslate
      SUFFIX = '_translations'.freeze

      def self.apply(model, opts = [])
        model.instance_eval do
          @translated_attrs = Array[opts].flatten
        end
      end

      module ClassMethods
        Sequel::Plugins.inherited_instance_variables(self, :@translated_attrs => nil)

        def translates
          @translated_attrs
        end

        def translates?
          included_modules.include?(InstanceMethods)
        end
      end

      module InstanceMethods
        def translated_attrs
          self.class.translates
        end
        alias translated_attribute_names translated_attrs

        def self.included(model)
          # define getters and setters
          model.translates.each do |attr|
            model.class_eval do
              I18n.available_locales.each do |locale|
                define_method("#{attr}_#{locale}") do
                  send("#{attr}#{SUFFIX}").with_indifferent_access[locale.to_s]
                end
                define_method("#{attr}_#{locale}=") do |arg|
                  val = send("#{attr}#{SUFFIX}")
                        .with_indifferent_access
                        .merge(locale.to_s => arg)
                  send("#{attr}#{SUFFIX}=", val)
                end
              end
              define_method(attr.to_s) do
                send("#{attr}_#{I18n.locale}")
              end
              define_method("#{attr}=") do |arg|
                send("#{attr}_#{I18n.locale}=", arg)
              end
            end
          end
        end
      end
    end
  end
end
