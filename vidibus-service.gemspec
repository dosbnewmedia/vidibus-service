# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vidibus-service}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andre Pankratz"]
  s.date = %q{2011-05-04}
  s.description = %q{Description...}
  s.email = %q{andre@vidibus.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".bundle/config",
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app/models/service.rb",
    "config/locales/en.yml",
    "config/routes.rb",
    "lib/vidibus-service.rb",
    "lib/vidibus/service.rb",
    "lib/vidibus/service/client.rb",
    "lib/vidibus/service/connector_app.rb",
    "lib/vidibus/service/controller_validations.rb",
    "lib/vidibus/service/mongoid.rb",
    "spec/spec_helper.rb",
    "spec/vidibus/service/client_spec.rb",
    "spec/vidibus/service/connector_app_spec.rb",
    "spec/vidibus/service/controller_validations_spec.rb",
    "spec/vidibus/service/mongoid_spec.rb",
    "spec/vidibus/service_spec.rb",
    "vidibus-service.gemspec"
  ]
  s.homepage = %q{http://github.com/vidibus/vidibus-service}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Provides tools for Vidibus services}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/vidibus/service/client_spec.rb",
    "spec/vidibus/service/connector_app_spec.rb",
    "spec/vidibus/service/controller_validations_spec.rb",
    "spec/vidibus/service/mongoid_spec.rb",
    "spec/vidibus/service_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, ["~> 2.0.0"])
      s.add_runtime_dependency(%q<vidibus-core_extensions>, [">= 0"])
      s.add_runtime_dependency(%q<vidibus-secure>, [">= 0"])
      s.add_runtime_dependency(%q<vidibus-uuid>, [">= 0"])
      s.add_runtime_dependency(%q<vidibus-validate_uri>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0.0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
      s.add_development_dependency(%q<relevance-rcov>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<mongoid>, ["~> 2.0.0"])
      s.add_dependency(%q<vidibus-core_extensions>, [">= 0"])
      s.add_dependency(%q<vidibus-secure>, [">= 0"])
      s.add_dependency(%q<vidibus-uuid>, [">= 0"])
      s.add_dependency(%q<vidibus-validate_uri>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.0.0"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<relevance-rcov>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongoid>, ["~> 2.0.0"])
    s.add_dependency(%q<vidibus-core_extensions>, [">= 0"])
    s.add_dependency(%q<vidibus-secure>, [">= 0"])
    s.add_dependency(%q<vidibus-uuid>, [">= 0"])
    s.add_dependency(%q<vidibus-validate_uri>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.0.0"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<relevance-rcov>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end

