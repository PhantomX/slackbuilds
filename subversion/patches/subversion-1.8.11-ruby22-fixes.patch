Index: subversion/bindings/swig/ruby/test/my-assertions.rb
===================================================================
--- subversion/bindings/swig/ruby/test/my-assertions.rb	(revision 1671099)
+++ subversion/bindings/swig/ruby/test/my-assertions.rb	(working copy)
@@ -27,9 +27,7 @@
       # make an intermediary assertion block handler
       def _my_assert_block(&block)
        if RUBY_VERSION > '1.9'
-         assert_block do
-           yield
-         end
+         yield
        else
          _wrap_assertion do
            yield
Index: subversion/bindings/swig/ruby/test/test-unit-ext.rb
===================================================================
--- subversion/bindings/swig/ruby/test/test-unit-ext.rb	(revision 1671099)
+++ subversion/bindings/swig/ruby/test/test-unit-ext.rb	(working copy)
@@ -18,6 +18,6 @@
 # ====================================================================
 
 require "test-unit-ext/always-show-result" if RUBY_VERSION < '1.9.3'
-require "test-unit-ext/priority"
+require "test-unit-ext/priority" if defined? MiniTest or defined? Minitest
 require "test-unit-ext/backtrace-filter" if RUBY_VERSION < '1.9.3'
 require "test-unit-ext/long-display-for-emacs" if RUBY_VERSION < '1.9.3'
Index: subversion/bindings/swig/ruby/test/test_repos.rb
===================================================================
--- subversion/bindings/swig/ruby/test/test_repos.rb	(revision 1671099)
+++ subversion/bindings/swig/ruby/test/test_repos.rb	(working copy)
@@ -679,7 +679,7 @@
       dest_path = File.join(@tmp_path, "dest")
       Svn::Repos.create(dest_path) do |repos|
         assert_raises(NoMethodError) do
-          repos.load_fs(nil)
+          repos.load_fs(Object.new)
         end
       end
 
Index: subversion/bindings/swig/ruby/test/test_wc.rb
===================================================================
--- subversion/bindings/swig/ruby/test/test_wc.rb	(revision 1671099)
+++ subversion/bindings/swig/ruby/test/test_wc.rb	(working copy)
@@ -411,7 +411,7 @@
     end
   end
 
-  def test_status
+  def test_status2
     source = "source"
     file1 = "file1"
     file2 = "file2"
@@ -540,7 +540,6 @@
           result = yield(access.send(*args), source)
           result ||= File.open(src_path, "rb") {|f| f.read}
           assert_equal(crlf_source, result)
-
           File.open(src_path, "wb") {|f| f.print(source)}
           args = [method_name, src_path, cr_path, Svn::Wc::TRANSLATE_FROM_NF]
           result = yield(access.send(*args), source)
@@ -1072,8 +1071,8 @@
         assert_not_nil context
         assert_kind_of Svn::Wc::Context, context
       end
-      if RUBY_VERSION > '1.9'
-        assert_equal(result,true)
+      if defined? MiniTest or defined? Minitest
+        assert_equal(true, result)
       else
         assert_nil result
       end
