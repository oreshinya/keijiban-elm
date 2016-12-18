port module StyleCompiler exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Style

port files : CssFileStructure -> Cmd msg

fileStructure : CssFileStructure
fileStructure =
  Css.File.toFileStructure
    [ ( "bundle.css", Css.File.compile [ Style.styles ] ) ]


main : CssCompilerProgram
main =
  Css.File.compiler files fileStructure
