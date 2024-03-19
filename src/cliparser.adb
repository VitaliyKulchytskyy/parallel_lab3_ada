with CliParser;

package body CliParser is
    procedure Setup is
    begin
        AP.Add_Option
           (Make_Boolean_Option (False), "help", 'h',
            Usage => "Display this help text");
        AP.Add_Option
           (Make_Boolean_Option (False), "verbose", 'v',
            Usage => "Print verbose information");
       AP.Add_Option
           (Make_Positive_Option (1), "items", 'i',
            Usage => "Set the number of items");
        AP.Add_Option
           (Make_Positive_Option (1), "storage", 's',
            Usage => "Set the storage size");
        AP.Set_Prologue ("Lab3");
        AP.Parse_Command_Line;
    end Setup;

    procedure Parse is
    begin
        if AP.Parse_Success and then AP.Boolean_Value ("help") then
            raise Parse_Usage;
        end if;

        if not AP.Parse_Success then
            raise Parse_Exception
               with
               ("Error while parsing command-line arguments: " &
                AP.Parse_Message);
        end if;

        Items        := AP.Integer_Value ("items");
        Storage_Size := AP.Integer_Value ("storage");

        if Is_Verbose then
            Put_Line ("Items:        " & Get_Item_Number'Img);
            Put_Line ("Storage size: " & Get_Storage_Size'Img);
            Put_Line ("");
        end if;
    end Parse;


    function Get_Item_Number return Positive is
    begin
        return Items;
    end Get_Item_Number;

    function Get_Storage_Size return Positive is
    begin
        return Storage_Size;
    end Get_Storage_Size;

    function Is_Verbose return Boolean is
    begin
        return AP.Boolean_Value ("verbose");
    end Is_Verbose;
end CliParser;
