class Sdml < Formula
  desc "Rust CLI tools for the Simple Domain Modeling Language (SDML)"
  homepage "https://sdml.io"
  url "https://github.com/sdm-lang/rust-sdml/archive/refs/tags/v0.2.10-preview.tar.gz"
  sha256 "511666e022b645d9c8d444b349698b1dbff95a6751c79263e3c8e8bcc74ef27f"
  license "Apache-2.0"

  depends_on "rust"
  option "without-graphviz", "Do not install GraphViz for diagrams"
  depends_on "graphviz" => :recommended
  option "without-plantuml", "Do not install PlantUML for diagrams"
  depends_on "plantuml" => :recommended

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output(bin/"sdml -V")

    (testpath/"example.sdml").write <<~EOS
      module example is
        structure Foo
      end
    EOS

    output = shell_output(bin/"sdml validate -i #{testpath}/example.sdml")
    assert_match "this definition is incomplete", output
  end
end
