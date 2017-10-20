# frozen_string_literal: true

class FakeApp
  HTML = <<~HTML
    <html>
    <script src="/jquery.min.js"></script>
    <script>
      const callAjax = (method, path, delay) => {
        setTimeout( () => {
          const xhr = new XMLHttpRequest();
          xhr.open(method, path, true);
          xhr.send(null);
        }, delay);
      };
    </script>
    </html>
  HTML
  JQUERY = File.read(File.expand_path('../assets/jquery-3.2.1.min.js', __FILE__))

  def self.call(env)
    if env['PATH_INFO'] == '/js'
      [200, { 'Content-Type' => 'text/plain' }, ['']]
    elsif env['PATH_INFO'] == '/jquery.min.js'
      [200, { 'Content-Type' => 'application/javascript' }, [JQUERY]]
    else
      [200, { 'Content-Type' => 'text/html' }, [HTML]]
    end
  end
end
