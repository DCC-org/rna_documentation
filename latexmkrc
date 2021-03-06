$pdflatex = 'lualatex --recorder --synctex=1 --shell-escape --interaction=nonstopmode %O %S';
$pdf_mode = 1;
$out_dir = ".";
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}
@default_files = ('documentation.tex');
