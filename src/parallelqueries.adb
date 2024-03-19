with ParallelQueries;

package body ParallelQueries is
    procedure Setup (Items : Positive; Storage_Size : Positive) is
    begin
        ParallelQueries.Items        := Items;
        ParallelQueries.Storage_Size := Storage_Size;
    end Setup;

    procedure Run is
        Storage : List;

        Access_Storage : Counting_Semaphore (1, Default_Ceiling);
        Full_Storage   : Counting_Semaphore (Storage_Size, Default_Ceiling);
        Empty_Storage  : Counting_Semaphore (0, Default_Ceiling);

        task Producer;

        task body Producer is
        begin
            for i in 1 .. ParallelQueries.Items loop
                declare
                    Item_Name : String := "item " & i'Img;
                begin
                    Full_Storage.Seize;
                    Access_Storage.Seize;

                    Storage.Append (Item_Name);
                    if Producer_CB /= null then
                        Producer_CB (Item_Name);
                    end if;

                    Access_Storage.Release;
                    Empty_Storage.Release;
                    delay 1.5;
                end;
            end loop;
        end Producer;

        task Consumer;

        task body Consumer is
        begin

            for i in 1 .. ParallelQueries.Items loop
                Empty_Storage.Seize;
                Access_Storage.Seize;

                declare
                    item : String := First_Element (Storage);
                begin
                    if Consumer_CB /= null then
                        Consumer_CB (item);
                    end if;
                end;

                Storage.Delete_First;

                Access_Storage.Release;
                Full_Storage.Release;

                delay 2.0;
            end loop;

        end Consumer;
    begin
        null;
    end Run;

    procedure On_Consumer_Callback (cb : in not null Callback) is
    begin
        Consumer_CB := cb;
    end On_Consumer_Callback;

    procedure On_Producer_Callback (cb : in not null Callback) is
    begin
        Producer_CB := cb;
    end On_Producer_Callback;
end ParallelQueries;
