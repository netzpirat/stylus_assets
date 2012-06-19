require 'spec_helper'

describe StylusAssets::StylusTemplate do

  let(:template) do
    StylusAssets::StylusTemplate.new('/Users/tester/projects/stylus_assets/styles/template.stylt', line=1, options={}) do
      <<-TMPL
  h1 { margin: 10px; }
  h2 { margin: 20px; }
      TMPL
    end
  end

  let(:scope) do
    double({ :logical_path => 'styles/template' })
  end

  before do
    StylusAssets::StylusTemplate.namespace = 'window.JSST'
    StylusAssets::StylusTemplate.name_filter = lambda { |n| n.sub /^(templates|styles|stylesheets)\//, '' }
  end

  describe "#evaluate" do
    context 'with defaults' do
      it 'uses the provided template name' do
        template.render(scope).should eql <<-TEMPLATE
(function() {
  window.JSST || (window.JSST = {});
  window.JSST['template'] = function(v, e) { return StylusAssets.render('template', \"  h1 { margin: 10px; }\\n  h2 { margin: 20px; }\\n\", v, e); };\n}).call(this);
        TEMPLATE
      end
    end

    context 'when changing the namespace' do
      before do
        StylusAssets::StylusTemplate.namespace = 'window.STYLES'
      end

      it 'uses the provided template name' do
        template.render(scope).should eql <<-TEMPLATE
(function() {
  window.STYLES || (window.STYLES = {});
  window.STYLES['template'] = function(v, e) { return StylusAssets.render('template', \"  h1 { margin: 10px; }\\n  h2 { margin: 20px; }\\n\", v, e); };\n}).call(this);
        TEMPLATE
      end
    end

    context 'when changing the name filter' do
      before do
        StylusAssets::StylusTemplate.name_filter = lambda { |n| n }
      end

      it 'uses the provided template name' do
        template.render(scope).should eql <<-TEMPLATE
(function() {
  window.JSST || (window.JSST = {});
  window.JSST['styles/template'] = function(v, e) { return StylusAssets.render('styles/template', \"  h1 { margin: 10px; }\\n  h2 { margin: 20px; }\\n\", v, e); };\n}).call(this);
        TEMPLATE
      end
    end
  end
end
