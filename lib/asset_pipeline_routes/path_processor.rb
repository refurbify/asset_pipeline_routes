# encoding: UTF-8
require 'active_support/core_ext/object/blank'
module AssetPipelineRoutes
  class PathProcessor
    REGEX = %r{
      (?<=[^[[:word:]]])r(?<re>
        \(
          (?:
            (?> [^()]+ )
            |
            \g<re>
          )*
        \)
      )
    }x

    def self.r
      @r ||= Routes.new(Rails.application.routes.routes)
    end

    def self.r= new_r
      @r = new_r
    end

    def self.call input
      new_data = input[:data].to_s.gsub REGEX do |match|
        str = match[2..-2]
        parts = str.split(',').map(&:strip).reject(&:blank?)
        return match if parts.empty?
        route = parts.shift.to_sym
        if r.respond_to?(route)
          r.send route, *parts
        else
          match
        end
      end
      { data: new_data }
    end
  end
end
