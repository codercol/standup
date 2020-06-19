# -*- encoding: utf-8 -*-
# stub: immutable-struct 2.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "immutable-struct".freeze
  s.version = "2.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Stitch Fix Engineering".freeze, "Dave Copeland".freeze, "Simeon Willbanks".freeze]
  s.date = "2019-04-18"
  s.description = "Easily create value objects without the pain of Ruby's Struct (or its setters)".freeze
  s.email = ["opensource@stitchfix.com".freeze, "davetron5000@gmail.com".freeze, "simeon@simeons.net".freeze]
  s.homepage = "https://github.com/stitchfix/immutable-struct".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Easily create value objects without the pain of Ruby's Struct (or its setters)".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
  end
end
