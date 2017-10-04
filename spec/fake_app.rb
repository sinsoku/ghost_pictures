class FakeApp
  HTML = <<~EOF
    <html>
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
  EOF

  def self.call(env)
    if env["PATH_INFO"] == "/js"
      [200, { 'Content-Type' => 'text/plain' }, ['']]
    else
      [200, { 'Content-Type' => 'text/html' }, [HTML]]
    end
  end
end
