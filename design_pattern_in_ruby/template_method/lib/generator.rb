module Newsletter
  class Generator
    def render
      <<EOF
#{header}

#{content}
EOF
    end

    def header
      "<h1>Hello World!</h1>"
    end

    def content
      <<EOF
<div class="content">
  <p>lorem ipsum</p>
</div>
EOF
    end
  end
end
