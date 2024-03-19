with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Text_IO, GNAT.Semaphores; use Ada.Text_IO, GNAT.Semaphores;
with Ada.Containers.Indefinite_Doubly_Linked_Lists; use Ada.Containers;

package ParallelQueries is
    type Callback is access procedure(Message: String);

    procedure Setup(Items : Positive; Storage_Size : Positive);
    procedure Run;

    procedure On_Consumer_Callback(cb: in not null Callback);
    procedure On_Producer_Callback(cb: in not null Callback);

private
    Items        : Positive;
    Storage_Size : Positive;
    Consumer_CB  : Callback;
    Producer_CB  : Callback;

    package String_Lists is new Indefinite_Doubly_Linked_Lists (String);
    use String_Lists;

end ParallelQueries;
