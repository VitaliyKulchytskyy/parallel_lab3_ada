with Parse_Args;  use Parse_Args;
with Ada.Text_IO; use Ada.Text_IO;
with Parse_Args.Integer_Array_Options;

package CliParser is
    AP : Argument_Parser;
    Parse_Usage, Parse_Exception : exception;

    procedure Setup;
    procedure Parse;

    function Get_Item_Number return Positive;
    function Get_Storage_Size return Positive;
    function Is_Verbose return Boolean;

private
    Items        : Positive;
    Storage_Size : Positive;

end CliParser;
