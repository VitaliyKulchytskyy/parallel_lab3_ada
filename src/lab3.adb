with Ada.Exceptions;  use Ada.Exceptions;
with Ada.Text_IO;     use Ada.Text_IO;
with CliParser;       use CliParser;
with ParallelQueries; use ParallelQueries;

procedure Lab3 is
    procedure Consumer_Callback (Message : String) is
    begin
        Put_Line ("[Consumer]: consume - " & Message);
    end Consumer_Callback;

    procedure Producer_Callback (Message : String) is
    begin
        Put_Line ("[Producer]: produce - " & Message);
    end Producer_Callback;

begin
    CliParser.Setup;
    CliParser.Parse;
    
    ParallelQueries.On_Consumer_Callback (Consumer_Callback'Unrestricted_Access);
    ParallelQueries.On_Producer_Callback (Producer_Callback'Unrestricted_Access);
    ParallelQueries.Setup
       (Items        => CliParser.Get_Item_Number,
        Storage_Size => CliParser.Get_Storage_Size);

    ParallelQueries.Run;

exception
    when e : Parse_Exception =>
        Put_Line (Exception_Message (e));
    when Parse_Usage         =>
        AP.Usage;

end Lab3;
