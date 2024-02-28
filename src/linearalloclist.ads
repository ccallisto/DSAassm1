with Ada.Text_IO; use Ada.Text_IO;
with Food_DataStructures; use Food_DataStructures;
generic
   type message is private;
   with function GetFoodType(msg: in message) return Food_Type is <>;
   capacity: Natural;
package linearalloclist is
    subtype slotindex is Natural range 0 .. Capacity;
    procedure insert(msg: in message);
    procedure remove(msg: in out message; desiredFood: Food_Type);
    function isFull return Boolean;
    function isEmpty return Boolean;
    procedure printlist;
end linearalloclist;
