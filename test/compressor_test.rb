require 'htmlcompressor/compressor'
require 'minitest/autorun'
require 'closure-compiler'

module HtmlCompressor

  class TestCompressor < MiniTest::Unit::TestCase

    def test_enabled
      source = read_resource("testEnabled.html")
      result = read_resource("testEnabledResult.html")

      compressor = Compressor.new(:enabled => false)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_spaces_inside_tags
      source = read_resource("testRemoveSpacesInsideTags.html")
      result = read_resource("testRemoveSpacesInsideTagsResult.html")

      compressor = Compressor.new(:remove_multi_spaces => false)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_comments
      source = read_resource("testRemoveComments.html")
      result = read_resource("testRemoveCommentsResult.html")

      compressor = Compressor.new(:remove_comments => true, :remove_intertag_spaces => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_quotes
      source = read_resource("testRemoveQuotes.html")
      result = read_resource("testRemoveQuotesResult.html")

      compressor = Compressor.new(:remove_quotes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_multi_spaces
      source = read_resource("testRemoveMultiSpaces.html")
      result = read_resource("testRemoveMultiSpacesResult.html")

      compressor = Compressor.new(:remove_multi_spaces => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_intertag_spaces
      source = read_resource("testRemoveIntertagSpaces.html")
      result = read_resource("testRemoveIntertagSpacesResult.html")

      compressor = Compressor.new(:remove_intertag_spaces => true)

      assert_equal result, compressor.compress(source)
    end

    def test_preserve_patterns
      source = read_resource("testPreservePatterns.html")
      result = read_resource("testPreservePatternsResult.html")

      preservePatterns = [
        Compressor::PHP_TAG_PATTERN,                                      # <?php ... ?> blocks
        Compressor::SERVER_SCRIPT_TAG_PATTERN,                            # <% ... %> blocks
        Compressor::SERVER_SIDE_INCLUDE_PATTERN,                          # <!--# ... --> blocks
        Regexp.new("<jsp:.*?>", Regexp::MULTILINE | Regexp::IGNORECASE)   # <jsp: ... > tags
      ]

      compressor = Compressor.new(
        :preserve_patterns => preservePatterns,
        :remove_comments => true,
        :remove_intertag_spaces => true
      )

      assert_equal result, compressor.compress(source)
    end

    def test_compress_javascript_yui
      source = read_resource("testCompressJavaScript.html");
      result = read_resource("testCompressJavaScriptYuiResult.html");

      compressor = Compressor.new(
        :compress_javascript => true,
        :remove_intertag_spaces => true
      )

      assert_equal result, compressor.compress(source)
    end

    def test_compress_java_script_closure
      source = read_resource("testCompressJavaScript.html")
      result = read_resource("testCompressJavaScriptClosureResult.html")

      compressor = Compressor.new(
        :compress_javascript => true,
        :javascript_compressor => Closure::Compiler.new(:compilation_level => 'ADVANCED_OPTIMIZATIONS'),
        :remove_intertag_spaces => true
      )

      assert_equal result, compressor.compress(source)
    end

    def test_compress_css
      source = read_resource("testCompressCss.html")
      result = read_resource("testCompressCssResult.html")

      compressor = Compressor.new(
        :compress_css => true,
        :remove_intertag_spaces => true
      )

      assert_equal result, compressor.compress(source)
    end

    def test_compress
      source = read_resource("testCompress.html")
      result = read_resource("testCompressResult.html")

      compressor = Compressor.new

      assert_equal result, compressor.compress(source)
    end

    def test_simple_doctype
      source = read_resource("testSimpleDoctype.html")
      result = read_resource("testSimpleDoctypeResult.html")

      compressor = Compressor.new(:simple_doctype => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_script_attributes
      source = read_resource("testRemoveScriptAttributes.html")
      result = read_resource("testRemoveScriptAttributesResult.html")

      compressor = Compressor.new(:remove_script_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_style_attributes
      source = read_resource("testRemoveStyleAttributes.html")
      result = read_resource("testRemoveStyleAttributesResult.html")

      compressor = Compressor.new(:remove_style_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_link_attributes
      source = read_resource("testRemoveLinkAttributes.html")
      result = read_resource("testRemoveLinkAttributesResult.html")

      compressor = Compressor.new(:remove_link_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_form_attributes
      source = read_resource("testRemoveFormAttributes.html")
      result = read_resource("testRemoveFormAttributesResult.html")

      compressor = Compressor.new(:remove_form_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_input_attributes
      source = read_resource("testRemoveInputAttributes.html")
      result = read_resource("testRemoveInputAttributesResult.html")

      compressor = Compressor.new(:remove_input_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_javascript_protocol
      source = read_resource("testRemoveJavaScriptProtocol.html")
      result = read_resource("testRemoveJavaScriptProtocolResult.html")

      compressor = Compressor.new(:remove_javascript_protocol => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_http_protocol
      source = read_resource("testRemoveHttpProtocol.html")
      result = read_resource("testRemoveHttpProtocolResult.html")

      compressor = Compressor.new(:remove_http_protocol => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_https_protocol
      source = read_resource("testRemoveHttpsProtocol.html")
      result = read_resource("testRemoveHttpsProtocolResult.html")

      compressor = Compressor.new(:remove_https_protocol => true)

      assert_equal result, compressor.compress(source)
    end

    def test_preserve_line_breaks
      source = read_resource("testPreserveLineBreaks.html")
      result = read_resource("testPreserveLineBreaksResult.html")

      compressor = Compressor.new(:preserve_line_breaks => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_surrounding_spaces
      source = read_resource("testSurroundingSpaces.html")
      result = read_resource("testSurroundingSpacesResult.html")

      compressor = Compressor.new(
        :remove_intertag_spaces => true,
        :remove_surrounding_spaces => "p,br"
      )

      assert_equal result, compressor.compress(source)
    end

    def test_simple_boolean_attributes
      source = read_resource("testSimpleBooleanAttributes.html")
      result = read_resource("testSimpleBooleanAttributesResult.html")

      compressor = Compressor.new(:simple_boolean_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    private

    def resource_path
      File.join File.expand_path(File.dirname(__FILE__)), 'resources', 'html'
    end

    def read_resource file
      File.open File.join(resource_path, file), 'r' do |f|
        return f.readlines.join('')
      end
    end

  end

end