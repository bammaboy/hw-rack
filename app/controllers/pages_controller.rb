module EmailCollector
  class PagesController
    def self.root
      template = File.read('./app/views/pages/root.html')
      [200, { 'Content-Type' => 'text/html' }, [template]]
    end
  end
end
